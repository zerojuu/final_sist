package com.data.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.data.dto.CarInfoDto;
import com.data.dto.SsCarDto;
import com.data.mapper.CarMapper;
import com.data.mapper.SsCarMapper;

@Controller
public class CarController {
	
	@Autowired
	CarMapper mapper;
	@Autowired
	SsCarMapper ssmapper;
	
	@GetMapping("/car/list")
	public ModelAndView carinfo()
	{	
		ModelAndView mview = new ModelAndView();
		List<CarInfoDto> list = mapper.getAllCarInfo();
	
		mview.addObject("title", "차량별 요금정보");
		mview.addObject("list", list);
		
		mview.setViewName("car/carinfolist");
		return mview;
	}
	@GetMapping("/car/cardetail")
	public ModelAndView cardetail(@RequestParam String ci_num,
							Model model)
	{	
		ModelAndView mview = new ModelAndView();
		 CarInfoDto dto = mapper.getInfoOfCar(ci_num);
		 List<SsCarDto> slist = ssmapper.getDatasOfCarInfoNum(ci_num);
		
		 
		
		// 지도에 차량 위치 표시를 위한 sscar 테이블의 위도 경도 데이터
		 String api_key = "9a033f3e554352ea8253b04b6f4efe4e";
			List<Double> latitude_list = new ArrayList<Double>();
			List<Double> longtitude_list = new ArrayList<Double>();
			// 지도 api key
			mview.addObject("api_key", api_key);
			
			// 차량번호 / 위도 / 경도 데이터를 리스트에 추가해서 넘김
			for (SsCarDto i : slist) {
				latitude_list.add(Double.parseDouble(i.getLatitude()));
				longtitude_list.add(Double.parseDouble(i.getLongtitude()));
			}
			
	     mview.addObject("dto", dto);
		 mview.addObject("slist", slist);
		 mview.addObject("sscar_count", slist.size());
		 mview.addObject("latitude_list", latitude_list);
		 mview.addObject("longtitude_list", longtitude_list);
		 
		 mview.setViewName("car/cardetail");
		 return mview;
	}
}
