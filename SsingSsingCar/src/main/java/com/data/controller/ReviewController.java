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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.data.dto.CarInfoDto;
import com.data.dto.CarpoolDto;
import com.data.dto.MemberDto;
import com.data.dto.ReviewDto;
import com.data.mapper.CarMapper;
import com.data.mapper.MemberMapper;
import com.data.mapper.ReviewMapper;

@Controller
public class ReviewController {

	@Autowired
	ReviewMapper mapper;
	
	@Autowired
	CarMapper carmapper;
	
	@Autowired
	MemberMapper memMappper;
	
	
	@GetMapping("review/list")
	public ModelAndView list(
			@RequestParam(value = "currentPage",defaultValue = "1") int currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		int totalCount=mapper.getTotalCountOfReview();
		
		// 차량 정보..carinfo 데이터
		List<CarInfoDto> carlist=carmapper.getAllCarInfo();
		model.addObject("carlist", carlist);
		
////////////페이징처리	
        int totalPage;
        int startPage;
        int endPage;
        int start;
        int perPage=5;
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
	
        int no=totalCount-(currentPage-1)*perPage;	

        model.addObject("startPage",startPage);
        model.addObject("endPage",endPage);
        model.addObject("totalPage",totalPage);
        model.addObject("totalCount",totalCount);
        model.addObject("no",no);
        model.addObject("currentPage",currentPage);
///////////////////////////////		
		
		model.setViewName("review/list");
		return model;
	}
	
	
	@GetMapping("review/content")
	public ModelAndView content(
			@RequestParam String ci_num,
			@RequestParam String currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		int totalCount=mapper.getTotalCountOfReview();
		
		model.addObject("totalCount", totalCount);
		model.addObject("currentPage", currentPage);
		model.addObject("ci_num", ci_num);
		
		CarInfoDto cardto=carmapper.getInfoOfCar(ci_num);
		model.addObject("cardto", cardto);
		
		List<ReviewDto> list=mapper.getListOfReviewByCar(ci_num);
		model.addObject("list", list);
		
		model.setViewName("review/content");
		return model;
	}
	
	
	@GetMapping("review/form")
	public ModelAndView form(@RequestParam String ci_num) {		
		ModelAndView model=new ModelAndView();
		
		model.addObject("ci_num", ci_num);
		
		model.setViewName("review/writeform");
		return model;
	}
	
	@PostMapping("review/insert")
	public String insert(
			@ModelAttribute ReviewDto rvdto,
			@RequestParam String ci_num,
			@RequestParam int rating,
			HttpSession session
			) {		
		//아이디 얻기
		String myid=(String)session.getAttribute("id");
		rvdto.setMyid(myid);
		
		//ci_num
		rvdto.setCi_num(ci_num);
		
		//별점
		rvdto.setRating(rating);
		
		//회원번호
		String mem_num=memMappper.getMemNumById(rvdto.getMyid());
		rvdto.setMem_num(mem_num);
		
		mapper.insertOfReview(rvdto);
		
		int maxnum=mapper.getMaxNumOfReview();
		
		return "redirect:list";
	}
	
	
	@GetMapping("review/delete")
	public String delete(String rv_num,
			String currentPage) {
		mapper.deleteOfReview(rv_num);
		return "redirect:list?currentPage="+currentPage;
	}
}
