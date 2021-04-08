package com.mycompany.webapp.controller;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.webapp.dto.Users;
import com.mycompany.webapp.service.UsersService;

@Controller
public class UserController {
	private static final Logger logger =
			LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UsersService usersService;
	
	@GetMapping("/auth/login")
	public String openLogin() {
		return "user/login";
	}
	

	@GetMapping("/signup")
	public String openSignup() {
		return "user/signup";
	}
	
	@PostMapping("/signup")
	public String Signup(Users user) {
		
		BCryptPasswordEncoder bpe = new BCryptPasswordEncoder();
		user.setUserPassword(bpe.encode(user.getUserPassword()));
		String encodedPassword = bpe.encode(user.getUserPassword());
		
		int result = usersService.join(user);
		
		
		return "user/login";
	}
	
	//회원가입 이메일 중복검사
	@PostMapping(value = "/overlapuserid", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String overlapUserId(Users user) {
		
		JSONObject jsonObject = new JSONObject();
		
		if(user.getUserId() == "") {
			jsonObject.put("result", "danger");
			return jsonObject.toString();
		}else {
			int result = usersService.overlapUserId(user);
			
			if(result == 0) {
				jsonObject.put("result", "success");
			}else {
				jsonObject.put("result", "fail");
			}
			
			logger.info(jsonObject.toString());
			return jsonObject.toString();
		}
		
	}
	
	//아이디, 비밀번호 찾기 페이지
	@GetMapping("/findidpw")
	public String openFindIdPw() {
		return "user/findidpw";
	}
	
	//아이디 찾기 동작
	@PostMapping("/findid")
	public String findId(String userName, String userPhone, Model model) {
		
		String id = usersService.findById(userName, userPhone);
		model.addAttribute("userId", id);
		
		return "user/findid";
	}
	
	//비밀번호 찾기 유저 검사 페이지
	@GetMapping("/changepw")
	public String openChangePw() {
		return "user/changepw";
	}
	
	//유저 검사
	@PostMapping(value = "/checkuser", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkUser(Users user) {
		
		logger.info(user.getUserId());
		logger.info(user.getUserName());
		logger.info(String.valueOf(user.getUserSsn1()));
		logger.info(String.valueOf(user.getUserSsn2()));
		
		JSONObject jsonObject = new JSONObject();
		
		int result = usersService.checkUser(user);
			
			if(result == 0) {
				jsonObject.put("result", "fail");
			}else {
				jsonObject.put("result", "success");
			}
			
			logger.info(jsonObject.toString());
			return jsonObject.toString();
	}
		
	//비밀번호 변경 동작
	@PostMapping(value = "/changepassword", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String changePassword(Users user) {
		
		logger.info(user.getUserId());
		logger.info(user.getUserPassword());
		
		BCryptPasswordEncoder bpe = new BCryptPasswordEncoder();
		user.setUserPassword(bpe.encode(user.getUserPassword()));
		String encodedPassword = bpe.encode(user.getUserPassword());
		
		int result = usersService.changePassword(user);

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", "success");
		
		logger.info(jsonObject.toString());
		return jsonObject.toString();
	}
	
}
