package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Praise;

public interface PraiseMapper {
	/*添加表扬信息*/
	public void addPraise(Praise praise) throws Exception;

	/*按照查询条件分页查询表扬记录*/
	public ArrayList<Praise> queryPraise(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有表扬记录*/
	public ArrayList<Praise> queryPraiseList(@Param("where") String where) throws Exception;

	/*按照查询条件的表扬记录数*/
	public int queryPraiseCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条表扬记录*/
	public Praise getPraise(int praiseId) throws Exception;

	/*更新表扬记录*/
	public void updatePraise(Praise praise) throws Exception;

	/*删除表扬记录*/
	public void deletePraise(int praiseId) throws Exception;

}
