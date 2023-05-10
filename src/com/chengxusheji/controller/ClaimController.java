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
import com.chengxusheji.service.ClaimService;
import com.chengxusheji.po.Claim;
import com.chengxusheji.service.LostFoundService;
import com.chengxusheji.po.LostFound;

//Claim管理控制层
@Controller
@RequestMapping("/Claim")
public class ClaimController extends BaseController {

    /*业务层对象*/
    @Resource ClaimService claimService;

    @Resource LostFoundService lostFoundService;
	@InitBinder("lostFoundObj")
	public void initBinderlostFoundObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("lostFoundObj.");
	}
	@InitBinder("claim")
	public void initBinderClaim(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("claim.");
	}
	/*跳转到添加Claim视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Claim());
		/*查询所有的LostFound信息*/
		List<LostFound> lostFoundList = lostFoundService.queryAllLostFound();
		request.setAttribute("lostFoundList", lostFoundList);
		return "Claim_add";
	}

	/*客户端ajax方式提交添加认领信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Claim claim, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        claimService.addClaim(claim);
        message = "认领添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询认领信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("lostFoundObj") LostFound lostFoundObj,String personName,String claimTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (personName == null) personName = "";
		if (claimTime == null) claimTime = "";
		if(rows != 0)claimService.setRows(rows);
		List<Claim> claimList = claimService.queryClaim(lostFoundObj, personName, claimTime, page);
	    /*计算总的页数和总的记录数*/
	    claimService.queryTotalPageAndRecordNumber(lostFoundObj, personName, claimTime);
	    /*获取到总的页码数目*/
	    int totalPage = claimService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = claimService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Claim claim:claimList) {
			JSONObject jsonClaim = claim.getJsonObject();
			jsonArray.put(jsonClaim);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询认领信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Claim> claimList = claimService.queryAllClaim();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Claim claim:claimList) {
			JSONObject jsonClaim = new JSONObject();
			jsonClaim.accumulate("claimId", claim.getClaimId());
			jsonArray.put(jsonClaim);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询认领信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("lostFoundObj") LostFound lostFoundObj,String personName,String claimTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (personName == null) personName = "";
		if (claimTime == null) claimTime = "";
		List<Claim> claimList = claimService.queryClaim(lostFoundObj, personName, claimTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    claimService.queryTotalPageAndRecordNumber(lostFoundObj, personName, claimTime);
	    /*获取到总的页码数目*/
	    int totalPage = claimService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = claimService.getRecordNumber();
	    request.setAttribute("claimList",  claimList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("lostFoundObj", lostFoundObj);
	    request.setAttribute("personName", personName);
	    request.setAttribute("claimTime", claimTime);
	    List<LostFound> lostFoundList = lostFoundService.queryAllLostFound();
	    request.setAttribute("lostFoundList", lostFoundList);
		return "Claim/claim_frontquery_result"; 
	}

     /*前台查询Claim信息*/
	@RequestMapping(value="/{claimId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer claimId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键claimId获取Claim对象*/
        Claim claim = claimService.getClaim(claimId);

        List<LostFound> lostFoundList = lostFoundService.queryAllLostFound();
        request.setAttribute("lostFoundList", lostFoundList);
        request.setAttribute("claim",  claim);
        return "Claim/claim_frontshow";
	}

	/*ajax方式显示认领修改jsp视图页*/
	@RequestMapping(value="/{claimId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer claimId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键claimId获取Claim对象*/
        Claim claim = claimService.getClaim(claimId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonClaim = claim.getJsonObject();
		out.println(jsonClaim.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新认领信息*/
	@RequestMapping(value = "/{claimId}/update", method = RequestMethod.POST)
	public void update(@Validated Claim claim, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			claimService.updateClaim(claim);
			message = "认领更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "认领更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除认领信息*/
	@RequestMapping(value="/{claimId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer claimId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  claimService.deleteClaim(claimId);
	            request.setAttribute("message", "认领删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "认领删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条认领记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String claimIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = claimService.deleteClaims(claimIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出认领信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("lostFoundObj") LostFound lostFoundObj,String personName,String claimTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(personName == null) personName = "";
        if(claimTime == null) claimTime = "";
        List<Claim> claimList = claimService.queryClaim(lostFoundObj,personName,claimTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Claim信息记录"; 
        String[] headers = { "认领id","招领信息","认领人","认领时间","发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<claimList.size();i++) {
        	Claim claim = claimList.get(i); 
        	dataset.add(new String[]{claim.getClaimId() + "",claim.getLostFoundObj().getTitle(),claim.getPersonName(),claim.getClaimTime(),claim.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Claim.xls");//filename是下载的xls的名，建议最好用英文 
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
