package com.mycompany.webapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.webapp.dao.ProductsRefundDao;

@Service
public class ProductsRefundService {
	@Autowired
	private ProductsRefundDao refundDao;
	
	public void saveRefund(int orderNo, String refundReason) {
		refundDao.insert(orderNo, refundReason);
	}

//	public void updateRefund(int orderNo, String refundReason) {
//		refundDao.update(orderNo, refundReason);
//	}
	
	/*public void saveReview(ProductsRefund refund) {
		refundDao.insert(refund);
	}
	
	public void updateRefund(ProductsRefund refund) {
		refundDao.update(refund);
	}*/
}
