package com.mycompany.webapp.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.Products;
import com.mycompany.webapp.dto.Reviews;
import com.mycompany.webapp.service.ProductsService;
import com.mycompany.webapp.service.ReviewsService;

@Controller
public class ProductController {
	private static final Logger logger =
			LoggerFactory.getLogger(ProductController.class);

	@Autowired
	private ProductsService productsService;
	
	@Autowired
	private ReviewsService reviewsService;


	@GetMapping("/product")
	public String openProduct(int productNo, Model model) 	{	
		productsService.addHitCount(productNo);
		List<Products> list = productsService.getProductDetail(productNo);
		
	
		Products product = new Products();
		product = list.get(0);
		
		model.addAttribute("list", list);
		model.addAttribute("product", product);
		
		return "product/product";
	}
	
	@GetMapping("/list")
	public String list(int productNo, Model model, String pageNo, HttpSession session) {
		logger.info("상품 리뷰 보기");
		
		int intPageNo = 1;
		if(pageNo == null ) {	//클라이언트에서 pagerNo가 넘어오지 않았을 경우
			// 세션에서 Pager를 찾고, 있으면 pageNo를 설정
			Pager pager = (Pager)session.getAttribute("pager");
			if (pager != null) {
				intPageNo = pager.getPageNo();
			}
		} else {	//클라이언트에서 pageNo가 넘어왔을 경우
			intPageNo = Integer.parseInt(pageNo);
		}
				
		int totalRows = reviewsService.getTotalRows(productNo);
		logger.info(String.valueOf(totalRows));
		Pager pager = new Pager(4, 5, totalRows, intPageNo);
		session.setAttribute("pager", pager);
		
		List<Reviews> rlist = reviewsService.getReview(productNo, pager);
		logger.info(String.valueOf(rlist.size()));
		//logger.info(rlist.get(1).getProductName());
		model.addAttribute("rlist", rlist);
		model.addAttribute("size", rlist.size());
		model.addAttribute("pager", pager);	
		model.addAttribute("productNo", productNo);
		
		//logger.info("pageno :" +  pageNo);
		//logger.info("productno : " + productNo);					
				
		return "product/productReviews";
	}
	
	 @GetMapping("/getphoto")
	   public void getPhoto(int cno, String imgSname, String imgType, HttpServletResponse response) {
	      try {
	 
	    	  
	         // 응답 HTTP 헤더에 저장될 바디의 타입
	    	 response.setContentType(imgType);

	         // 한글 파일일 경우, 깨짐 현상을 방지
	    	 imgSname = new String(imgSname.getBytes("UTF-8"), "ISO-8859-1");
	
	         response.setHeader("Content-Disposition", "attachment; filename=\"" + imgSname+ "\";");

	         // 응답 HTTP 바디에 이미지 데이터를 출력
	         InputStream is;
	         OutputStream os;
	    	 if(cno == 1) {
	    		 is = new FileInputStream("D://상품사진들/캔들/" + imgSname + "." + imgType);
		         os = response.getOutputStream();
		         FileCopyUtils.copy(is, os);
	    	 }else if(cno == 2) {
	    		 is = new FileInputStream("D://상품사진들/조명/" + imgSname + "." + imgType);

		         os = response.getOutputStream();
		         FileCopyUtils.copy(is, os);
	    	 }else if(cno == 3) {

	    		 is = new FileInputStream("D://상품사진들/트리/" + imgSname + "." + imgType);

		         os = response.getOutputStream();
		         FileCopyUtils.copy(is, os);
	    	 }else {
	    		 is = new FileInputStream("D://상품사진들/기타/" + imgSname + "." + imgType);

		         os = response.getOutputStream();
		         FileCopyUtils.copy(is, os);
	    	 }
	        
	         os.flush();
	         is.close();
	         os.close();

	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }

	
	
		/*
		 * //이미지를 DB에 넣기위한 관리자 전용 페이지
		 * 
		 * @GetMapping("/insertImg") public String insertImg() { return
		 * "admin/insertImg"; }
		 * 
		 * //이미지를 DB에 넣기위한 관리자 전용 페이지
		 * 
		 * @PostMapping("/insertImg") public String insertImgFile(ProductsImg
		 * productImg) { int result = 0; MultipartFile[] battach =
		 * productImg.getBattach(); for(int i=0; i<battach.length; i++) {
		 * productImg.setImgOname(battach[i].getOriginalFilename());
		 * productImg.setImgType(battach[i].getContentType()); //파일 저장 시 이름 중복 제거 String
		 * saveName = new Date().getTime() + "-" + battach[i].getOriginalFilename();
		 * productImg.setImgSname(saveName);
		 * 
		 * logger.info(productImg.getImgOname()); logger.info(productImg.getImgSname());
		 * System.out.println(result);
		 * 
		 * result = productsService.insertImg(productImg);
		 * 
		 * File file = new File("D:/상품/캔들/" + saveName);
		 * 
		 * try { battach[i].transferTo(file); } catch (Exception e) {
		 * e.printStackTrace(); } }
		 * 
		 * 
		 * return "main"; }
		 */

	 
	@GetMapping("/search")
	public String searchProductPager(String pageNo, Model model, HttpSession session,String keyword,RedirectAttributes redirect) {

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

		int totalRows = productsService.getTotalRows(keyword);
		Pager pager = new Pager(12, 10, totalRows, intPageNo);
		session.setAttribute("pager", pager);
		
		List<Products> list = productsService.getProductsSearchListPager(pager,keyword);
		model.addAttribute("list", list);
		model.addAttribute("pager", pager);
		model.addAttribute("keyword",keyword);
		
	
		return "product/searchProduct";
		
	}




}
