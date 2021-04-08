package com.mycompany.webapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.Cart;
import com.mycompany.webapp.dto.OrderProducts;
import com.mycompany.webapp.dto.Orders;
import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.Products;
import com.mycompany.webapp.dto.Wishlist;
import com.mycompany.webapp.service.CartService;
import com.mycompany.webapp.service.OrderProductsService;
import com.mycompany.webapp.service.OrdersService;
import com.mycompany.webapp.service.ProductsService;
import com.mycompany.webapp.service.WishlistService;


@Controller
@RequestMapping("/user")
public class OrderController {
	private static final Logger logger =
			LoggerFactory.getLogger(OrderController.class);

	Cart[] cartArray;

	@Autowired
	private CartService cartService;

	@Autowired
	private ProductsService productService;

	@Autowired
	private WishlistService wishlistService;


	@Autowired
	private OrdersService ordersService;

	@Autowired
	private OrderProductsService orderProductsService;

	@GetMapping("/cart")
	public String openCart(Authentication auth, Model model) {
		String userId = auth.getName();
		List<Cart> clist = cartService.getCart(userId);
		model.addAttribute("clist",clist);
		model.addAttribute("size", clist.size());
		cartArray = new Cart[clist.size()];
	
		return "order/cart";
	}
	
	//선택옵션 정보
	@PostMapping(value = "/addcart", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addCart(Authentication auth, Cart cart) {
		
		cart.setUserId(auth.getName());
		
		Products product = productService.getProductDetail(cart.getProductNo()).get(0);
		String price = product.getProductPrice();
		price = price.replaceAll(",", "");
		price = price.replaceAll(" ", "");
		
		int allprice = cart.getAmount() * (Integer.parseInt(price));
		cart.setAllPrice(allprice);
		
		int result = cartService.getCartCheckCount(cart.getProductNo(), auth.getName());
		
		JSONObject jsonObject = new JSONObject();
		if(result != 1) {
			int addResult = cartService.saveCart(cart);
			jsonObject.put("result", "success");
			return jsonObject.toString();
		}else {
			jsonObject.put("result", "danger");
			return jsonObject.toString();
		}
		
	}

	@GetMapping("/delcart")
	public String delCart(Authentication auth, int productNo) {
		logger.info("실행");
		int pno = productNo;
		String userID = auth.getName();

		//logger.info(String.valueOf(productNo));

		cartService.deleteCart(pno, userID);

		return "redirect:/user/cart";
	}

	@PostMapping("/updateamount")
	public String updateAmount(Cart cart) {
		
		String price = cart.getPrice();
		price = price.replaceAll(",", "");
		price = price.replaceAll(" ", "");
		
		int allprice = cart.getAmount() * Integer.parseInt(price);
		cart.setAllPrice(allprice);
		cartService.updateAmount(cart);
		return "redirect:/user/cart";
	}

	@PostMapping("/order")
	public String openOrder(HttpServletRequest request, Authentication auth, Cart cart, Model model) {
		String userId = auth.getName();

		String[] productNo = request.getParameterValues("productNo");
		String[] amount = request.getParameterValues("amount");
		String[] allPrice = request.getParameterValues("allPrice");
		String[] productName = request.getParameterValues("productName");
		String[] price = request.getParameterValues("price");
		String[] imgOname = request.getParameterValues("imgOname");
		String[] imgSname = request.getParameterValues("imgSname");
		String[] imgType = request.getParameterValues("imgType");

		for(int i =0; i < cartArray.length; i++) {
			cartArray[i] = new Cart();
			if(cartArray[i].getProductName() == null) {
				cartArray[i].setProductNo(Integer.parseInt(productNo[i]));
				cartArray[i].setUserId(userId);
				cartArray[i].setAmount(Integer.parseInt(amount[i]));
				cartArray[i].setAllPrice(Integer.parseInt(allPrice[i]));
				cartArray[i].setProductName(productName[i]);
				cartArray[i].setPrice(price[i]);
				cartArray[i].setImgOname(imgOname[i]);
				cartArray[i].setImgSname(imgSname[i]);
				cartArray[i].setImgType(imgType[i]);							
			}		
		}

		String sum = request.getParameter("sum");
		String count = request.getParameter("count");
		model.addAttribute("sum", Integer.parseInt(sum));
		model.addAttribute("count", Integer.parseInt(count));

		return "order/order";
	}

	@PostMapping("/ordercomplete")
	public String openOrdercomplete(Authentication auth, HttpServletRequest request) {
		Orders orders = new Orders();
		String allPrice = request.getParameter("allPrice");
		String zipCode = request.getParameter("zipCode");
		String userId = auth.getName();

		orders.setUserId(userId);	
		orders.setAllPrice(Integer.parseInt(allPrice));
		orders.setZipCode(Integer.parseInt(zipCode));
		orders.setRoadAddress(request.getParameter("roadAddress"));
		orders.setDetailAddress(request.getParameter("detailAddress"));

		ordersService.saveOrder(orders);

		OrderProducts orderProducts = new OrderProducts();

		for(int i = 0; i < cartArray.length; i++) {
			if(cartArray[i].getProductName() == null) {
				break;
			}
			else{
				orderProducts.setProductNo(cartArray[i].getProductNo());
				orderProducts.setUserId(cartArray[i].getUserId());
				orderProducts.setAmount(cartArray[i].getAmount());
				orderProducts.setPrice(cartArray[i].getAllPrice());
			
				orderProductsService.saveOrderProduct(orderProducts);
				cartService.deleteCart(orderProducts.getProductNo(), orderProducts.getUserId());
				productService.addPsellCount(orderProducts.getProductNo(), orderProducts.getAmount());
			} 
		}		

		return "order/ordercomplete";
	}

	@GetMapping("/wishlist")
	public String openWishlist(Authentication auth,String pageNo, Model model, HttpSession session) {

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
		int totalRows = wishlistService.getTotalRows(userId);
		Pager pager = new Pager(12, 5, totalRows, intPageNo);
		session.setAttribute("pager", pager);

		
		List<Wishlist> list = wishlistService.getWishlist(pager,userId);
		logger.info(String.valueOf(list.size()));
		model.addAttribute("list", list);
		model.addAttribute("size",list.size());
		model.addAttribute("pager", pager);

		return "order/wishlist";
	}

	
	@PostMapping(value = "/addwishlist", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addWishlist(Authentication auth, Wishlist wishlist) {
		
		wishlist.setUserId(auth.getName());
		
		int result = wishlistService.getwishListCheckCount(wishlist.getProductNo(), auth.getName());
		
		JSONObject jsonObject = new JSONObject();
		if(result != 1) {
			int addResult = wishlistService.saveWishlist(wishlist);
			jsonObject.put("result", "success");
			return jsonObject.toString();
		}else {
			jsonObject.put("result", "danger");
			return jsonObject.toString();
		}
		
	}
	

	@GetMapping("/delwishlist")
	public String delWishList(int productNo, Authentication auth) {
		/*logger.info(String.valueOf(productNo));*/

		String userId = auth.getName();
		wishlistService.deleteWishlist(productNo, userId);

		return "redirect:/user/wishlist";
	}


}
