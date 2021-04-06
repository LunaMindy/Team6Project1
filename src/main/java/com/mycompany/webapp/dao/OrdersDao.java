package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.Orders;
import com.mycompany.webapp.dto.Pager;

@Mapper
public interface OrdersDao {

	public void createOrder(String userId, int orderNo);
	public void insert(Orders orders);
	/*주문디테일*/
	//public List<Orders> selectAll(String userId);
	/*주문디테일페지이*/
	public List<Orders> selectByPage(@Param("pager") Pager pager,@Param("userId") String userId);
	public int count(String userId);
	public void update(int orderNo);
	
}
