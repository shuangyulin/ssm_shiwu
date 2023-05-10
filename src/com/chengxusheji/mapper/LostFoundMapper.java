package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.LostFound;

public interface LostFoundMapper {
	/*添加失物招领信息*/
	public void addLostFound(LostFound lostFound) throws Exception;

	/*按照查询条件分页查询失物招领记录*/
	public ArrayList<LostFound> queryLostFound(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有失物招领记录*/
	public ArrayList<LostFound> queryLostFoundList(@Param("where") String where) throws Exception;

	/*按照查询条件的失物招领记录数*/
	public int queryLostFoundCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条失物招领记录*/
	public LostFound getLostFound(int lostFoundId) throws Exception;

	/*更新失物招领记录*/
	public void updateLostFound(LostFound lostFound) throws Exception;

	/*删除失物招领记录*/
	public void deleteLostFound(int lostFoundId) throws Exception;

}
