package com.data.controller;

import java.util.List;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.data.dto.CarpoolAnswerDto;
import com.data.mapper.CarpoolAnswerMapper;
import com.data.mapper.MemberMapper;


@RestController
public class CarpoolAnswerController {

	@Autowired
	CarpoolAnswerMapper mapper;
	
	@Autowired
	MemberMapper memMapper;
	
	
	@PostMapping("/carpool/ainsert")
	public void insert(
			@ModelAttribute CarpoolAnswerDto dto,
			HttpSession session
			) {
		//세션에 로그인한 아이디,회원명,회원번호
		String myid=(String)session.getAttribute("id");		
		String name=memMapper.getNameById(myid);
		String mem_num=memMapper.getMemNumById(myid);
		
		dto.setMyid(myid);
		dto.setName(name);
		dto.setMem_num(mem_num);
		
		mapper.insertCarpoolAnswer(dto);
	}
	
	@GetMapping("/carpool/alist")
	public List<CarpoolAnswerDto> alist(String cp_num){
		return mapper.getListCarpoolAnswer(cp_num);
	}
	
	@GetMapping("/carpool/adata")
	public CarpoolAnswerDto adata(String ca_num) {
		return mapper.getCarpoolAnswer(ca_num);
	}
	
	
	@PostMapping("/carpool/aupdate")
	public void aupdate(
			@ModelAttribute CarpoolAnswerDto dto
			) {
		mapper.updateCarpoolAnswer(dto);
	}
	
	
	@GetMapping("/carpool/adelete")
	public void adelete(String ca_num) {
		mapper.deleteCarpoolAnswer(ca_num);
	}
}
