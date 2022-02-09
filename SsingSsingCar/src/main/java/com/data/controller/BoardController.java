package com.data.controller;

import java.util.HashMap;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.data.dto.BoardDto;
import com.data.mapper.BoardMapper;

@Controller
public class BoardController {

	@Autowired
	BoardMapper mapper;
	
	
	@GetMapping("/board/list")
	public ModelAndView list(
			@RequestParam(value = "currentPage",defaultValue = "1") int currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		model.addObject("title", "공지사항");
		
		int totalCount=mapper.getTotalCountOfBoard();
		
////////////페이징처리	
	int totalPage;
	int startPage;
	int endPage;
	int start;
	int perPage=15;
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
	
	List<BoardDto> list=mapper.getListOfBoard(map);		
	
	int	no=totalCount-(currentPage-1)*perPage;
		

	model.addObject("list",list);
	model.addObject("startPage",startPage);
	model.addObject("endPage",endPage);
	model.addObject("totalPage",totalPage);
	model.addObject("totalCount",totalCount);
	model.addObject("no",no);
	model.addObject("currentPage",currentPage);
///////////////////////////////
		
		model.setViewName("board/list");
		return model;
	}
	
	
	@GetMapping("/board/form")
	public String form() {
		return "board/writeform";
	}
	
	@PostMapping("/board/insert")
	public String insert(
			@ModelAttribute BoardDto dto
			) {
		mapper.insertBoard(dto);
		
		int maxnum=mapper.getMaxNumOfBoard();
		
		//return "redirect:content?board_num="+maxnum;
		return "redirect:list";
	}
	
	@GetMapping("/board/content")
	public ModelAndView content(
			@RequestParam String board_num,
			@RequestParam String currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		BoardDto dto=mapper.getDataOfBoard(board_num);
		model.addObject("dto", dto);
		model.addObject("currentPage", currentPage);
		
		model.setViewName("board/content");
		return model;
	}
	
	
	@GetMapping("/board/updateform")
	public ModelAndView updateform(
			@RequestParam String board_num,
			@RequestParam String currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		BoardDto dto=mapper.getDataOfBoard(board_num);
		model.addObject("dto", dto);
		model.addObject("currentPage", currentPage);
		
		model.setViewName("board/updateform");
		return model;
	}
	
	@PostMapping("/board/update")
	public String update(
			@ModelAttribute BoardDto dto,
			@RequestParam String currentPage
			) {
		mapper.updateBoard(dto);				
		
		return "redirect:content?board_num="+dto.getBoard_num()+"&currentPage="+currentPage;
	}
	
	
	@GetMapping("/board/delete")
	public String delete(@RequestParam String board_num,
			@RequestParam String currentPage
			) {
		mapper.deleteBoard(board_num);
		
		return "redirect:list?currentPage="+currentPage;
	}  
}
