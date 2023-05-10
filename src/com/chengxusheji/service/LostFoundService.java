package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.LostFound;

import com.chengxusheji.mapper.LostFoundMapper;
@Service
public class LostFoundService {

	@Resource LostFoundMapper lostFoundMapper;
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

    /*添加失物招领记录*/
    public void addLostFound(LostFound lostFound) throws Exception {
    	lostFoundMapper.addLostFound(lostFound);
    }

    /*按照查询条件分页查询失物招领记录*/
    public ArrayList<LostFound> queryLostFound(String title,String goodsName,String pickUpTime,String pickUpPlace,String connectPerson,String phone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_lostFound.title like '%" + title + "%'";
    	if(!goodsName.equals("")) where = where + " and t_lostFound.goodsName like '%" + goodsName + "%'";
    	if(!pickUpTime.equals("")) where = where + " and t_lostFound.pickUpTime like '%" + pickUpTime + "%'";
    	if(!pickUpPlace.equals("")) where = where + " and t_lostFound.pickUpPlace like '%" + pickUpPlace + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_lostFound.connectPerson like '%" + connectPerson + "%'";
    	if(!phone.equals("")) where = where + " and t_lostFound.phone like '%" + phone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return lostFoundMapper.queryLostFound(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<LostFound> queryLostFound(String title,String goodsName,String pickUpTime,String pickUpPlace,String connectPerson,String phone) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_lostFound.title like '%" + title + "%'";
    	if(!goodsName.equals("")) where = where + " and t_lostFound.goodsName like '%" + goodsName + "%'";
    	if(!pickUpTime.equals("")) where = where + " and t_lostFound.pickUpTime like '%" + pickUpTime + "%'";
    	if(!pickUpPlace.equals("")) where = where + " and t_lostFound.pickUpPlace like '%" + pickUpPlace + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_lostFound.connectPerson like '%" + connectPerson + "%'";
    	if(!phone.equals("")) where = where + " and t_lostFound.phone like '%" + phone + "%'";
    	return lostFoundMapper.queryLostFoundList(where);
    }

    /*查询所有失物招领记录*/
    public ArrayList<LostFound> queryAllLostFound()  throws Exception {
        return lostFoundMapper.queryLostFoundList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,String goodsName,String pickUpTime,String pickUpPlace,String connectPerson,String phone) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_lostFound.title like '%" + title + "%'";
    	if(!goodsName.equals("")) where = where + " and t_lostFound.goodsName like '%" + goodsName + "%'";
    	if(!pickUpTime.equals("")) where = where + " and t_lostFound.pickUpTime like '%" + pickUpTime + "%'";
    	if(!pickUpPlace.equals("")) where = where + " and t_lostFound.pickUpPlace like '%" + pickUpPlace + "%'";
    	if(!connectPerson.equals("")) where = where + " and t_lostFound.connectPerson like '%" + connectPerson + "%'";
    	if(!phone.equals("")) where = where + " and t_lostFound.phone like '%" + phone + "%'";
        recordNumber = lostFoundMapper.queryLostFoundCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取失物招领记录*/
    public LostFound getLostFound(int lostFoundId) throws Exception  {
        LostFound lostFound = lostFoundMapper.getLostFound(lostFoundId);
        return lostFound;
    }

    /*更新失物招领记录*/
    public void updateLostFound(LostFound lostFound) throws Exception {
        lostFoundMapper.updateLostFound(lostFound);
    }

    /*删除一条失物招领记录*/
    public void deleteLostFound (int lostFoundId) throws Exception {
        lostFoundMapper.deleteLostFound(lostFoundId);
    }

    /*删除多条失物招领信息*/
    public int deleteLostFounds (String lostFoundIds) throws Exception {
    	String _lostFoundIds[] = lostFoundIds.split(",");
    	for(String _lostFoundId: _lostFoundIds) {
    		lostFoundMapper.deleteLostFound(Integer.parseInt(_lostFoundId));
    	}
    	return _lostFoundIds.length;
    }
}
