package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.LostFound;
import com.chengxusheji.po.Praise;

import com.chengxusheji.mapper.PraiseMapper;
@Service
public class PraiseService {

	@Resource PraiseMapper praiseMapper;
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

    /*添加表扬记录*/
    public void addPraise(Praise praise) throws Exception {
    	praiseMapper.addPraise(praise);
    }

    /*按照查询条件分页查询表扬记录*/
    public ArrayList<Praise> queryPraise(LostFound lostFoundObj,String title,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != lostFoundObj && lostFoundObj.getLostFoundId()!= null && lostFoundObj.getLostFoundId()!= 0)  where += " and t_praise.lostFoundObj=" + lostFoundObj.getLostFoundId();
    	if(!title.equals("")) where = where + " and t_praise.title like '%" + title + "%'";
    	if(!addTime.equals("")) where = where + " and t_praise.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return praiseMapper.queryPraise(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Praise> queryPraise(LostFound lostFoundObj,String title,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != lostFoundObj && lostFoundObj.getLostFoundId()!= null && lostFoundObj.getLostFoundId()!= 0)  where += " and t_praise.lostFoundObj=" + lostFoundObj.getLostFoundId();
    	if(!title.equals("")) where = where + " and t_praise.title like '%" + title + "%'";
    	if(!addTime.equals("")) where = where + " and t_praise.addTime like '%" + addTime + "%'";
    	return praiseMapper.queryPraiseList(where);
    }

    /*查询所有表扬记录*/
    public ArrayList<Praise> queryAllPraise()  throws Exception {
        return praiseMapper.queryPraiseList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(LostFound lostFoundObj,String title,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(null != lostFoundObj && lostFoundObj.getLostFoundId()!= null && lostFoundObj.getLostFoundId()!= 0)  where += " and t_praise.lostFoundObj=" + lostFoundObj.getLostFoundId();
    	if(!title.equals("")) where = where + " and t_praise.title like '%" + title + "%'";
    	if(!addTime.equals("")) where = where + " and t_praise.addTime like '%" + addTime + "%'";
        recordNumber = praiseMapper.queryPraiseCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取表扬记录*/
    public Praise getPraise(int praiseId) throws Exception  {
        Praise praise = praiseMapper.getPraise(praiseId);
        return praise;
    }

    /*更新表扬记录*/
    public void updatePraise(Praise praise) throws Exception {
        praiseMapper.updatePraise(praise);
    }

    /*删除一条表扬记录*/
    public void deletePraise (int praiseId) throws Exception {
        praiseMapper.deletePraise(praiseId);
    }

    /*删除多条表扬信息*/
    public int deletePraises (String praiseIds) throws Exception {
    	String _praiseIds[] = praiseIds.split(",");
    	for(String _praiseId: _praiseIds) {
    		praiseMapper.deletePraise(Integer.parseInt(_praiseId));
    	}
    	return _praiseIds.length;
    }
}
