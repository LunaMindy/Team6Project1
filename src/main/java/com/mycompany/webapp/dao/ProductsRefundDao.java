package com.mycompany.webapp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mycompany.webapp.dto.ProductsRefund;



@Mapper
public interface ProductsRefundDao {
	public void insert(@Param("orderNo") int orderNo, @Param("refundReason") String refundReason);
	//public void update(@Param("orderNo") int ono, @Param("refundReason") String refundReason);
}