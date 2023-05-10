package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.LookingForService;
import com.chengxusheji.po.LookingFor;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//LookingFor管理控制层
@Controller
@RequestMapping("/LookingFor")
public class LookingForController extends BaseController {

    /*业务层对象*/
    @Resource LookingForService lookingForService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("lookingFor")
	public void initBinderLookingFor(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("lookingFor.");
	}
	/*跳转到添加LookingFor视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new LookingFor());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "LookingFor_add";
	}

	/*客户端ajax方式提交添加寻物启事信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated LookingFor lookingFor, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			lookingFor.setGoodsPhoto(this.handlePhotoUpload(request, "goodsPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        lookingForService.addLookingFor(lookingFor);
        message = "寻物启事添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询寻物启事信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String title,String goodsName,String lostTime,String lostPlace,String telephone,@ModelAttribute("userObj") UserInfo userObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (goodsName == null) goodsName = "";
		if (lostTime == null) lostTime = "";
		if (lostPlace == null) lostPlace = "";
		if (telephone == null) telephone = "";
		if(rows != 0)lookingForService.setRows(rows);
		List<LookingFor> lookingForList = lookingForService.queryLookingFor(title, goodsName, lostTime, lostPlace, telephone, userObj, page);
	    /*计算总的页数和总的记录数*/
	    lookingForService.queryTotalPageAndRecordNumber(title, goodsName, lostTime, lostPlace, telephone, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = lookingForService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = lookingForService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(LookingFor lookingFor:lookingForList) {
			JSONObject jsonLookingFor = lookingFor.getJsonObject();
			jsonArray.put(jsonLookingFor);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询寻物启事信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<LookingFor> lookingForList = lookingForService.queryAllLookingFor();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(LookingFor lookingFor:lookingForList) {
			JSONObject jsonLookingFor = new JSONObject();
			jsonLookingFor.accumulate("lookingForId", lookingFor.getLookingForId());
			jsonLookingFor.accumulate("title", lookingFor.getTitle());
			jsonArray.put(jsonLookingFor);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询寻物启事信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String title,String goodsName,String lostTime,String lostPlace,String telephone,@ModelAttribute("userObj") UserInfo userObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		if (goodsName == null) goodsName = "";
		if (lostTime == null) lostTime = "";
		if (lostPlace == null) lostPlace = "";
		if (telephone == null) telephone = "";
		List<LookingFor> lookingForList = lookingForService.queryLookingFor(title, goodsName, lostTime, lostPlace, telephone, userObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    lookingForService.queryTotalPageAndRecordNumber(title, goodsName, lostTime, lostPlace, telephone, userObj);
	    /*获取到总的页码数目*/
	    int totalPage = lookingForService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = lookingForService.getRecordNumber();
	    request.setAttribute("lookingForList",  lookingForList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("title", title);
	    request.setAttribute("goodsName", goodsName);
	    request.setAttribute("lostTime", lostTime);
	    request.setAttribute("lostPlace", lostPlace);
	    request.setAttribute("telephone", telephone);
	    request.setAttribute("userObj", userObj);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "LookingFor/lookingFor_frontquery_result"; 
	}

     /*前台查询LookingFor信息*/
	@RequestMapping(value="/{lookingForId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer lookingForId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键lookingForId获取LookingFor对象*/
        LookingFor lookingFor = lookingForService.getLookingFor(lookingForId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("lookingFor",  lookingFor);
        return "LookingFor/lookingFor_frontshow";
	}

	/*ajax方式显示寻物启事修改jsp视图页*/
	@RequestMapping(value="/{lookingForId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer lookingForId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键lookingForId获取LookingFor对象*/
        LookingFor lookingFor = lookingForService.getLookingFor(lookingForId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonLookingFor = lookingFor.getJsonObject();
		out.println(jsonLookingFor.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新寻物启事信息*/
	@RequestMapping(value = "/{lookingForId}/update", method = RequestMethod.POST)
	public void update(@Validated LookingFor lookingFor, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String goodsPhotoFileName = this.handlePhotoUpload(request, "goodsPhotoFile");
		if(!goodsPhotoFileName.equals("upload/NoImage.jpg"))lookingFor.setGoodsPhoto(goodsPhotoFileName); 


		try {
			lookingForService.updateLookingFor(lookingFor);
			message = "寻物启事更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "寻物启事更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除寻物启事信息*/
	@RequestMapping(value="/{lookingForId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer lookingForId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  lookingForService.deleteLookingFor(lookingForId);
	            request.setAttribute("message", "寻物启事删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "寻物启事删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条寻物启事记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String lookingForIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = lookingForService.deleteLookingFors(lookingForIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出寻物启事信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String title,String goodsName,String lostTime,String lostPlace,String telephone,@ModelAttribute("userObj") UserInfo userObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        if(goodsName == null) goodsName = "";
        if(lostTime == null) lostTime = "";
        if(lostPlace == null) lostPlace = "";
        if(telephone == null) telephone = "";
        List<LookingFor> lookingForList = lookingForService.queryLookingFor(title,goodsName,lostTime,lostPlace,telephone,userObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "LookingFor信息记录"; 
        String[] headers = { "寻物id","标题","丢失物品","物品照片","丢失时间","丢失地点","报酬","联系电话","学生","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<lookingForList.size();i++) {
        	LookingFor lookingFor = lookingForList.get(i); 
        	dataset.add(new String[]{lookingFor.getLookingForId() + "",lookingFor.getTitle(),lookingFor.getGoodsName(),lookingFor.getGoodsPhoto(),lookingFor.getLostTime(),lookingFor.getLostPlace(),lookingFor.getReward(),lookingFor.getTelephone(),lookingFor.getUserObj().getName(),lookingFor.getAddTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"LookingFor.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
