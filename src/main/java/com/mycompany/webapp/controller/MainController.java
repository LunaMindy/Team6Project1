package com.mycompany.webapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.mycompany.webapp.dto.Pager;
import com.mycompany.webapp.dto.Products;
import com.mycompany.webapp.dto.Qna;
import com.mycompany.webapp.service.ProductsService;
import com.mycompany.webapp.service.QnaService;


@Controller
public class MainController {
	private static final Logger logger =
			LoggerFactory.getLogger(MainController.class);

	@Autowired
	private DataSource dataSource;

	@Autowired
	QnaService qnaService;
	
	@Autowired
	private ProductsService productsService;

	@GetMapping("/main")
	public String openMain(Model model) {

		List<Products> blist = productsService.getBestProductList();
		List<Products> nlist = productsService.getNewProductList();

		model.addAttribute("blist", blist);
		model.addAttribute("nlist", nlist);

		return "main";
	}

	////////////////////////////////////////////////////////

	@GetMapping("/category")
	public String openCategory(int cno, int kind, String pageNo, Model model, HttpSession session) {
		int intPageNo = 1; 
		if(pageNo == null) {
			Integer objCategoryNo = (Integer) session.getAttribute("categoryNo");
			if(objCategoryNo != null) {
				if(cno == objCategoryNo) {
					Pager pager = (Pager)session.getAttribute("pager"); 
					if(pager != null) { 
						intPageNo = pager.getPageNo(); 
					}
				}
			}
		} else {
			intPageNo = Integer.parseInt(pageNo); 
		}
		
		int totalCount = productsService.getTotalCount(cno);
		Pager pager = new Pager(12, 5, totalCount, intPageNo); 
		session.setAttribute("pager", pager);
		session.setAttribute("categoryNo", cno);
		
		List<Products> list = new ArrayList<Products>();
		if(kind == 2) {
			list = productsService.getProductsBestList(pager, cno);
		}else {
			list = productsService.getProductsList(pager, cno);
			
		}

		Products product = new Products();
		product = list.get(0);

		model.addAttribute("list", list);
		model.addAttribute("pager", pager);
		model.addAttribute("product", product);
		model.addAttribute("cno", cno);
		model.addAttribute("kind", kind);		
		
		return "main/category";
	}


	////////////////////////////////////////////////////////

	
	@GetMapping("/faq")
	public String openFaq() {
		
		return "main/faq";
	}
	
	@PostMapping("/qna")
	public String sendQna(Qna qna, HttpSession session) {
		
		qnaService.insertFaq(qna);		
		return "redirect:/main";
	}




}

