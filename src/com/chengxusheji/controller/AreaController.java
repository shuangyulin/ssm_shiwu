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
import com.chengxusheji.service.AreaService;
import com.chengxusheji.po.Area;

//Area管理控制层
@Controller
@RequestMapping("/Area")
public class AreaController extends BaseController {

    /*业务层对象*/
    @Resource AreaService areaService;

	@InitBinder("area")
	public void initBinderArea(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("area.");
	}
	/*跳转到添加Area视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Area());
		return "Area_add";
	}

	/*客户端ajax方式提交添加学院信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Area area, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        areaService.addArea(area);
        message = "学院添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询学院信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)areaService.setRows(rows);
		List<Area> areaList = areaService.queryArea(page);
	    /*计算总的页数和总的记录数*/
	    areaService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = areaService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = areaService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Area area:areaList) {
			JSONObject jsonArea = area.getJsonObject();
			jsonArray.put(jsonArea);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询学院信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Area> areaList = areaService.queryAllArea();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Area area:areaList) {
			JSONObject jsonArea = new JSONObject();
			jsonArea.accumulate("areaId", area.getAreaId());
			jsonArea.accumulate("areaName", area.getAreaName());
			jsonArray.put(jsonArea);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询学院信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<Area> areaList = areaService.queryArea(currentPage);
	    /*计算总的页数和总的记录数*/
	    areaService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = areaService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = areaService.getRecordNumber();
	    request.setAttribute("areaList",  areaList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "Area/area_frontquery_result"; 
	}

     /*前台查询Area信息*/
	@RequestMapping(value="/{areaId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer areaId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键areaId获取Area对象*/
        Area area = areaService.getArea(areaId);

        request.setAttribute("area",  area);
        return "Area/area_frontshow";
	}

	/*ajax方式显示学院修改jsp视图页*/
	@RequestMapping(value="/{areaId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer areaId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键areaId获取Area对象*/
        Area area = areaService.getArea(areaId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonArea = area.getJsonObject();
		out.println(jsonArea.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新学院信息*/
	@RequestMapping(value = "/{areaId}/update", method = RequestMethod.POST)
	public void update(@Validated Area area, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			areaService.updateArea(area);
			message = "学院更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "学院更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除学院信息*/
	@RequestMapping(value="/{areaId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer areaId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  areaService.deleteArea(areaId);
	            request.setAttribute("message", "学院删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "学院删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条学院记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String areaIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = areaService.deleteAreas(areaIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出学院信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<Area> areaList = areaService.queryArea();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Area信息记录"; 
        String[] headers = { "学院id","学院名称"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<areaList.size();i++) {
        	Area area = areaList.get(i); 
        	dataset.add(new String[]{area.getAreaId() + "",area.getAreaName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Area.xls");//filename是下载的xls的名，建议最好用英文 
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
