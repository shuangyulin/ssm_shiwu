package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.LostFound;
import com.chengxusheji.po.Claim;

import com.chengxusheji.mapper.ClaimMapper;
@Service
public class ClaimService {

	@Resource ClaimMapper claimMapper;
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

    /*添加认领记录*/
    public void addClaim(Claim claim) throws Exception {
    	claimMapper.addClaim(claim);
    }

    /*按照查询条件分页查询认领记录*/
    public ArrayList<Claim> queryClaim(LostFound lostFoundObj,String personName,String claimTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != lostFoundObj && lostFoundObj.getLostFoundId()!= null && lostFoundObj.getLostFoundId()!= 0)  where += " and t_claim.lostFoundObj=" + lostFoundObj.getLostFoundId();
    	if(!personName.equals("")) where = where + " and t_claim.personName like '%" + personName + "%'";
    	if(!claimTime.equals("")) where = where + " and t_claim.claimTime like '%" + claimTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return claimMapper.queryClaim(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Claim> queryClaim(LostFound lostFoundObj,String personName,String claimTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != lostFoundObj && lostFoundObj.getLostFoundId()!= null && lostFoundObj.getLostFoundId()!= 0)  where += " and t_claim.lostFoundObj=" + lostFoundObj.getLostFoundId();
    	if(!personName.equals("")) where = where + " and t_claim.personName like '%" + personName + "%'";
    	if(!claimTime.equals("")) where = where + " and t_claim.claimTime like '%" + claimTime + "%'";
    	return claimMapper.queryClaimList(where);
    }

    /*查询所有认领记录*/
    public ArrayList<Claim> queryAllClaim()  throws Exception {
        return claimMapper.queryClaimList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(LostFound lostFoundObj,String personName,String claimTime) throws Exception {
     	String where = "where 1=1";
    	if(null != lostFoundObj && lostFoundObj.getLostFoundId()!= null && lostFoundObj.getLostFoundId()!= 0)  where += " and t_claim.lostFoundObj=" + lostFoundObj.getLostFoundId();
    	if(!personName.equals("")) where = where + " and t_claim.personName like '%" + personName + "%'";
    	if(!claimTime.equals("")) where = where + " and t_claim.claimTime like '%" + claimTime + "%'";
        recordNumber = claimMapper.queryClaimCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取认领记录*/
    public Claim getClaim(int claimId) throws Exception  {
        Claim claim = claimMapper.getClaim(claimId);
        return claim;
    }

    /*更新认领记录*/
    public void updateClaim(Claim claim) throws Exception {
        claimMapper.updateClaim(claim);
    }

    /*删除一条认领记录*/
    public void deleteClaim (int claimId) throws Exception {
        claimMapper.deleteClaim(claimId);
    }

    /*删除多条认领信息*/
    public int deleteClaims (String claimIds) throws Exception {
    	String _claimIds[] = claimIds.split(",");
    	for(String _claimId: _claimIds) {
    		claimMapper.deleteClaim(Integer.parseInt(_claimId));
    	}
    	return _claimIds.length;
    }
}
