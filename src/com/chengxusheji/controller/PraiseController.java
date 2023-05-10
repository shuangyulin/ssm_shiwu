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
import com.chengxusheji.service.PraiseService;
import com.chengxusheji.po.Praise;
import com.chengxusheji.service.LostFoundService;
import com.chengxusheji.po.LostFound;

//Praise管理控制层
@Controller
@RequestMapping("/Praise")
public class PraiseController extends BaseController {

    /*业务层对象*/
    @Resource PraiseService praiseService;

    @Resource LostFoundService lostFoundService;
	@InitBinder("lostFoundObj")
	public void initBinderlostFoundObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("lostFoundObj.");
	}
	@InitBinder("praise")
	public void initBinderPraise(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("praise.");
	}
	/*跳转到添加Praise视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Praise());
		/*查询所有的LostFound信息*/
		List<LostFound> lostFoundList = lostFoundService.queryAllLostFound();
		request.setAttribute("lostFoundList", lostFoundList);
		return "Praise_add";
	}

	/*客户端ajax方式提交添加表扬信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Praise praise, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        praiseService.addPraise(praise);
        message = "表扬添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询表扬信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("lostFoundObj") LostFound lostFoundObj,String title,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (addTime == null) addTime = "";
		if(rows != 0)praiseService.setRows(rows);
		List<Praise> praiseList = praiseService.queryPraise(lostFoundObj, title, addTime, page);
	    /*计算总的页数和总的记录数*/
	    praiseService.queryTotalPageAndRecordNumber(lostFoundObj, title, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = praiseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = praiseService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Praise praise:praiseList) {
			JSONObject jsonPraise = praise.getJsonObject();
			jsonArray.put(jsonPraise);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询表扬信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Praise> praiseList = praiseService.queryAllPraise();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Praise praise:praiseList) {
			JSONObject jsonPraise = new JSONObject();
			jsonPraise.accumulate("praiseId", praise.getPraiseId());
			jsonPraise.accumulate("title", praise.getTitle());
			jsonArray.put(jsonPraise);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询表扬信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("lostFoundObj") LostFound lostFoundObj,String title,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		if (addTime == null) addTime = "";
		List<Praise> praiseList = praiseService.queryPraise(lostFoundObj, title, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    praiseService.queryTotalPageAndRecordNumber(lostFoundObj, title, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = praiseService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = praiseService.getRecordNumber();
	    request.setAttribute("praiseList",  praiseList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("lostFoundObj", lostFoundObj);
	    request.setAttribute("title", title);
	    request.setAttribute("addTime", addTime);
	    List<LostFound> lostFoundList = lostFoundService.queryAllLostFound();
	    request.setAttribute("lostFoundList", lostFoundList);
		return "Praise/praise_frontquery_result"; 
	}

     /*前台查询Praise信息*/
	@RequestMapping(value="/{praiseId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer praiseId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键praiseId获取Praise对象*/
        Praise praise = praiseService.getPraise(praiseId);

        List<LostFound> lostFoundList = lostFoundService.queryAllLostFound();
        request.setAttribute("lostFoundList", lostFoundList);
        request.setAttribute("praise",  praise);
        return "Praise/praise_frontshow";
	}

	/*ajax方式显示表扬修改jsp视图页*/
	@RequestMapping(value="/{praiseId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer praiseId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键praiseId获取Praise对象*/
        Praise praise = praiseService.getPraise(praiseId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonPraise = praise.getJsonObject();
		out.println(jsonPraise.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新表扬信息*/
	@RequestMapping(value = "/{praiseId}/update", method = RequestMethod.POST)
	public void update(@Validated Praise praise, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			praiseService.updatePraise(praise);
			message = "表扬更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "表扬更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除表扬信息*/
	@RequestMapping(value="/{praiseId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer praiseId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  praiseService.deletePraise(praiseId);
	            request.setAttribute("message", "表扬删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "表扬删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条表扬记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String praiseIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = praiseService.deletePraises(praiseIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出表扬信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("lostFoundObj") LostFound lostFoundObj,String title,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        if(addTime == null) addTime = "";
        List<Praise> praiseList = praiseService.queryPraise(lostFoundObj,title,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Praise信息记录"; 
        String[] headers = { "表扬id","招领信息","标题","表扬内容","表扬时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<praiseList.size();i++) {
        	Praise praise = praiseList.get(i); 
        	dataset.add(new String[]{praise.getPraiseId() + "",praise.getLostFoundObj().getTitle(),praise.getTitle(),praise.getContents(),praise.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Praise.xls");//filename是下载的xls的名，建议最好用英文 
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
