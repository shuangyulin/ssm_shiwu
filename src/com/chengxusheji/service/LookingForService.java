package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.LookingFor;

import com.chengxusheji.mapper.LookingForMapper;
@Service
public class LookingForService {

	@Resource LookingForMapper lookingForMapper;
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

    /*添加寻物启事记录*/
    public void addLookingFor(LookingFor lookingFor) throws Exception {
    	lookingForMapper.addLookingFor(lookingFor);
    }

    /*按照查询条件分页查询寻物启事记录*/
    public ArrayList<LookingFor> queryLookingFor(String title,String goodsName,String lostTime,String lostPlace,String telephone,UserInfo userObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_lookingFor.title like '%" + title + "%'";
    	if(!goodsName.equals("")) where = where + " and t_lookingFor.goodsName like '%" + goodsName + "%'";
    	if(!lostTime.equals("")) where = where + " and t_lookingFor.lostTime like '%" + lostTime + "%'";
    	if(!lostPlace.equals("")) where = where + " and t_lookingFor.lostPlace like '%" + lostPlace + "%'";
    	if(!telephone.equals("")) where = where + " and t_lookingFor.telephone like '%" + telephone + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_lookingFor.userObj='" + userObj.getUser_name() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return lookingForMapper.queryLookingFor(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<LookingFor> queryLookingFor(String title,String goodsName,String lostTime,String lostPlace,String telephone,UserInfo userObj) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_lookingFor.title like '%" + title + "%'";
    	if(!goodsName.equals("")) where = where + " and t_lookingFor.goodsName like '%" + goodsName + "%'";
    	if(!lostTime.equals("")) where = where + " and t_lookingFor.lostTime like '%" + lostTime + "%'";
    	if(!lostPlace.equals("")) where = where + " and t_lookingFor.lostPlace like '%" + lostPlace + "%'";
    	if(!telephone.equals("")) where = where + " and t_lookingFor.telephone like '%" + telephone + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_lookingFor.userObj='" + userObj.getUser_name() + "'";
    	return lookingForMapper.queryLookingForList(where);
    }

    /*查询所有寻物启事记录*/
    public ArrayList<LookingFor> queryAllLookingFor()  throws Exception {
        return lookingForMapper.queryLookingForList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,String goodsName,String lostTime,String lostPlace,String telephone,UserInfo userObj) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_lookingFor.title like '%" + title + "%'";
    	if(!goodsName.equals("")) where = where + " and t_lookingFor.goodsName like '%" + goodsName + "%'";
    	if(!lostTime.equals("")) where = where + " and t_lookingFor.lostTime like '%" + lostTime + "%'";
    	if(!lostPlace.equals("")) where = where + " and t_lookingFor.lostPlace like '%" + lostPlace + "%'";
    	if(!telephone.equals("")) where = where + " and t_lookingFor.telephone like '%" + telephone + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_lookingFor.userObj='" + userObj.getUser_name() + "'";
        recordNumber = lookingForMapper.queryLookingForCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取寻物启事记录*/
    public LookingFor getLookingFor(int lookingForId) throws Exception  {
        LookingFor lookingFor = lookingForMapper.getLookingFor(lookingForId);
        return lookingFor;
    }

    /*更新寻物启事记录*/
    public void updateLookingFor(LookingFor lookingFor) throws Exception {
        lookingForMapper.updateLookingFor(lookingFor);
    }

    /*删除一条寻物启事记录*/
    public void deleteLookingFor (int lookingForId) throws Exception {
        lookingForMapper.deleteLookingFor(lookingForId);
    }

    /*删除多条寻物启事信息*/
    public int deleteLookingFors (String lookingForIds) throws Exception {
    	String _lookingForIds[] = lookingForIds.split(",");
    	for(String _lookingForId: _lookingForIds) {
    		lookingForMapper.deleteLookingFor(Integer.parseInt(_lookingForId));
    	}
    	return _lookingForIds.length;
    }
}
