package com.data.controller;

import java.util.HashMap;



import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.data.dto.CarpoolDto;
import com.data.mapper.CarpoolAnswerMapper;
import com.data.mapper.CarpoolMapper;
import com.data.mapper.MemberMapper;



@Controller
public class CarpoolController {

	@Autowired
	CarpoolMapper mapper;
	
	@Autowired
	MemberMapper memMapper;	
	
	@Autowired
	CarpoolAnswerMapper camapper;
	
	
	@GetMapping("/carpool/list")
	public ModelAndView list(
			@RequestParam(value = "currentPage",defaultValue = "1") int currentPage
			) {
		ModelAndView model=new ModelAndView();
		int totalCount=mapper.getTotalCountOfCarpool();
		
////////////페이징처리	
	int totalPage;
	int startPage;
	int endPage;
	int start;
	int perPage=10;
	int perBlock=5;

	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;

	    if(endPage>totalPage)
		    endPage=totalPage;

	start=(currentPage-1)*perPage;

	HashMap<String, Integer> map=new HashMap<String, Integer>();
	map.put("start", start);
	map.put("perPage", perPage);
	
    List<CarpoolDto> list=mapper.getListOfCarpool(map);

	int	no=totalCount-(currentPage-1)*perPage;
	
	for(CarpoolDto c:list) {
		//이름
		String name=memMapper.getNameById(c.getMyid());
		c.setName(name);
		//댓글
		c.setAcount(camapper.getListCarpoolAnswer(c.getCp_num()).size());
	}	

	model.addObject("list",list);
	model.addObject("startPage",startPage);
	model.addObject("endPage",endPage);
	model.addObject("totalPage",totalPage);
	model.addObject("totalCount",totalCount);
	model.addObject("no",no);
	model.addObject("currentPage",currentPage);
///////////////////////////////
		
		model.setViewName("carpool/list");
		return model;
	}
	
	@GetMapping("/carpool/form")
	public ModelAndView form(
			@ModelAttribute CarpoolDto dto,
			String type,
			HttpSession session
			) {
		ModelAndView model=new ModelAndView();
		
		// 페이지 title
		model.addObject("title", "카풀 게시판");
		
		//카풀분야
		model.addObject("type", type);		
		
		model.setViewName("carpool/writeform");
		return model;
	}
	
	@PostMapping("/carpool/insert")
	public String insert(
			@ModelAttribute CarpoolDto dto,
			HttpSession session,
			String type
			) {
		
		//아이디 얻기
		String myid=(String)session.getAttribute("id");
		dto.setMyid(myid);		
		
		//이름
		String name=memMapper.getNameById(dto.getMyid());
		dto.setName(name);
		
		//회원번호
		String mem_num=memMapper.getMemNumById(dto.getMyid());
		dto.setMem_num(mem_num);
		
		//카풀분야
		dto.setType(type);
		
		mapper.insertCarpool(dto);
		
		int maxnum=mapper.getMaxNumOfCarpool();
		
		return "redirect:content?cp_num="+maxnum;
	}
	
	
	@GetMapping("/carpool/content")
	public ModelAndView content(
			@RequestParam String cp_num,
			@RequestParam(value = "currentPage",defaultValue = "1") int currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		CarpoolDto dto=mapper.getDataOfCarpool(cp_num);
		
		mapper.updateReadCount(cp_num);
		
		//dto의 name에 작성자 이름넣기
		String name=memMapper.getNameById(dto.getMyid());
		dto.setName(name);
		
		model.addObject("dto", dto);
		model.addObject("currentPage", currentPage);
		
		model.setViewName("carpool/content");
		return model;
	}
	
	
	@GetMapping("/carpool/updateform")
	public ModelAndView updateform(
			@RequestParam String cp_num,
			@RequestParam String currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		CarpoolDto dto=mapper.getDataOfCarpool(cp_num);
		model.addObject("dto", dto);
		model.addObject("currentPage", currentPage);
		
		model.setViewName("carpool/updateform");
		return model;
	}
	
	@PostMapping("/carpool/update")
	public String update(
			@ModelAttribute CarpoolDto dto,
			@RequestParam String currentPage
			) {
		mapper.updateCarpool(dto);			
		
		return "redirect:content?cp_num="+dto.getCp_num()+"&currentPage="+currentPage;
	}
	
	
	@GetMapping("/carpool/delete")
	public String delete(@RequestParam String cp_num,
			@RequestParam String currentPage
			) {
		mapper.deleteCarpool(cp_num);
		
		return "redirect:list?currentPage="+currentPage;
	} 

}
