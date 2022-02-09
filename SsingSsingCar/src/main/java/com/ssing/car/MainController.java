package com.ssing.car;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	
	// 첫 페이지 설정 (메인 레이아웃)
	@GetMapping("/")
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("title", "씽씽카");
		
		mv.setViewName("main-layout");
		
		return mv;
	}
}
