package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Area;

import com.chengxusheji.mapper.AreaMapper;
@Service
public class AreaService {

	@Resource AreaMapper areaMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加学院记录*/
    public void addArea(Area area) throws Exception {
    	areaMapper.addArea(area);
    }

    /*按照查询条件分页查询学院记录*/
    public ArrayList<Area> queryArea(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return areaMapper.queryArea(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Area> queryArea() throws Exception  { 
     	String where = "where 1=1";
    	return areaMapper.queryAreaList(where);
    }

    /*查询所有学院记录*/
    public ArrayList<Area> queryAllArea()  throws Exception {
        return areaMapper.queryAreaList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = areaMapper.queryAreaCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学院记录*/
    public Area getArea(int areaId) throws Exception  {
        Area area = areaMapper.getArea(areaId);
        return area;
    }

    /*更新学院记录*/
    public void updateArea(Area area) throws Exception {
        areaMapper.updateArea(area);
    }

    /*删除一条学院记录*/
    public void deleteArea (int areaId) throws Exception {
        areaMapper.deleteArea(areaId);
    }

    /*删除多条学院信息*/
    public int deleteAreas (String areaIds) throws Exception {
    	String _areaIds[] = areaIds.split(",");
    	for(String _areaId: _areaIds) {
    		areaMapper.deleteArea(Integer.parseInt(_areaId));
    	}
    	return _areaIds.length;
    }
}
