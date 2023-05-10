package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Claim;

public interface ClaimMapper {
	/*添加认领信息*/
	public void addClaim(Claim claim) throws Exception;

	/*按照查询条件分页查询认领记录*/
	public ArrayList<Claim> queryClaim(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有认领记录*/
	public ArrayList<Claim> queryClaimList(@Param("where") String where) throws Exception;

	/*按照查询条件的认领记录数*/
	public int queryClaimCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条认领记录*/
	public Claim getClaim(int claimId) throws Exception;

	/*更新认领记录*/
	public void updateClaim(Claim claim) throws Exception;

	/*删除认领记录*/
	public void deleteClaim(int claimId) throws Exception;

}
