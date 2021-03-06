package com.mycompany.webapp.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mycompany.webapp.dto.OrderProducts;
import com.mycompany.webapp.dto.Orders;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.service.OrderProductsService;
import com.mycompany.webapp.service.OrdersService;
import com.mycompany.webapp.service.ProductsRefundService;
import com.mycompany.webapp.service.ReviewsService;

@Controller
@RequestMapping("/user")
public class PurchaseController {
	private static final Logger logger =
			LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	DataSource dateSource;
	
	@Autowired
	ProductsRefundService productsRefundService;
	
	@Autowired
	OrdersService ordersService;
	
	@Autowired
	private ReviewsService reviewsService;
	
	@Autowired
	OrderProductsService orderProductsService;
	
	/*주문리스트 페이징처리*/
	@GetMapping("/purchaselist")
	public String openPurchaseListPage(Authentication auth,String pageNo, Model model, HttpSession session) {

		int intPageNo = 1;
		if (pageNo == null) {
			// 세션에서 Pager를 찾고, 있으면 pageNo를 설정하고,
			Pager pager = (Pager) session.getAttribute("pager");
			if (pager != null) {
				intPageNo = pager.getPageNo();
			}
			// 없으면 Pager를 세션에 저장함
		} else {
			intPageNo = Integer.parseInt(pageNo);
		}
		
		String userId = auth.getName();
		int totalRows = ordersService.getTotalRows(userId);
		Pager pager = new Pager(4, 5, totalRows, intPageNo);
		session.setAttribute("pager", pager);

		
		List<Orders> list = ordersService.getOrdersPage(pager, userId);
		
		model.addAttribute("list", list);
		model.addAttribute("size",list.size());
		model.addAttribute("pager", pager);
		model.addAttribute("userId",userId);

		return "purchase/purchaseList";
	}
	
	
	/*주문리스트*/
//	@GetMapping("/purchaselist")
//	public String openPurchaseList(Model model,Authentication auth) {
//		String userId = auth.getName();
//		
//		List<Orders> list = ordersService.getOrders(userId);
//		model.addAttribute("list",list);
//		
//		logger.info("주문리스트 실행");
//		
//		return "purchase/purchaseList";
//	}	
	
	/*주문디테일*/
	@GetMapping("/purchaselistdetail")
	public String openPurchaseListDetail(Model model, int orderNo, Authentication auth) {
		String userId = auth.getName();
		
		List<OrderProducts> list = orderProductsService.getOrderDetail(orderNo, userId);
		model.addAttribute("list",list);
		
		return "purchase/purchaseListDetail";
	}
	
	/*환불*/
	@PostMapping("/exchangerefund")
	public String ExchangeRefund(int orderNo, Model model) {
		
		model.addAttribute("orderNo", orderNo);		
		return "purchase/exchangeRefund";
	}
		
	@PostMapping("/refundcomplete")
	public String refundComplete(int orderNo, String reason) {
		
		int ono = orderNo;
		String refundReason = "";
		
		if(reason.equals("one")) {
			refundReason = "고객 변심";
		} else if(reason.equals("two")) {
			refundReason = "상품 불량";
		} else if(reason.equals("three")) {
			refundReason = "서비스 불만족";
		} else if(reason.equals("four")) {
			refundReason = "늦은 배송";
		} else if(reason.equals("five")) {
			refundReason = "기타";
		}		
		
		productsRefundService.saveRefund(orderNo, refundReason);
		ordersService.updateRefund(orderNo);
		return "redirect:/user/purchaselist";
	}
	
	/*리뷰*/
	@PostMapping("/review")
	public String openReview(int orderNo, int productNo, Model model) {
		model.addAttribute("orderNo", orderNo);
		model.addAttribute("productNo", productNo);
		return "purchase/review";
	}
	
	@PostMapping("/createreview")
	public String updateReview(Authentication auth, int orderNo, int productNo, String reviewContent, RedirectAttributes redirect) {
		String userId = auth.getName();
		reviewsService.saveReview(userId, orderNo, productNo, reviewContent);
		orderProductsService.updateReview(userId, orderNo, productNo);
		redirect.addAttribute("orderNo", orderNo);
		return "redirect:/user/purchaselistdetail";
	}
	
	@GetMapping("/delreview")
	public String delReview(Authentication auth, int reviewNo, int productNo, RedirectAttributes redirect) {
		String userId = auth.getName();
		reviewsService.deleteReview(reviewNo, userId);
		redirect.addAttribute("productNo", productNo);
		return "redirect:/product";
	}

}

