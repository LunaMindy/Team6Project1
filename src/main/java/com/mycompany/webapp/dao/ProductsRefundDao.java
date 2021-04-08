package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.ProductsRefund;



@Mapper
public interface ProductsRefundDao {
	public List<ProductsRefund> selectAll(int orderNo);
	public void insert(@Param("orderNo") int orderNo, @Param("refundReason") String refundReason);
}