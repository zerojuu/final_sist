package com.data.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.data.dto.CarInfoDto;
import com.data.dto.MemberDto;
import com.data.dto.RentDto;
import com.data.dto.SsCarDto;
import com.data.mapper.CarMapper;
import com.data.mapper.MemberMapper;
import com.data.mapper.RentMapper;
import com.data.mapper.SsCarMapper;

import net.sf.json.JSONObject;

@Controller
public class RentController {
	// 카카오 지도 API 키
	String api_key = "9a033f3e554352ea8253b04b6f4efe4e";
	
	// 결제 서비스 API
	String aCode = "imp59990634";
	String pay_key = "3359950845382062";
	
	@Autowired
	CarMapper car_mapper;
	
	@Autowired
	SsCarMapper sscar_mapper;
	
	@Autowired
	RentMapper rent_mapper;
	
	@Autowired
	MemberMapper member_mapper;
	
	// 렌트 예약 페이지
	@GetMapping("rent/rentForm")
	public ModelAndView rent(@RequestParam(required = false) String car_num, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		// 로그인 확인 과정
		String login=(String)session.getAttribute("loginok");
		if (login!=null) {
			mv.setViewName("rent/rentForm");
		} else {
			mv.setViewName("redirect:/member/loginform");
			
			return mv;
		}
		
		// 페이지 title
		mv.addObject("title", "렌트 예약");
		
		// 지도 api key
		mv.addObject("api_key", api_key);
		
		// 다른 페이지에서 차량 선택 후 접근 시 차량 번호 유지
		mv.addObject("car_num", car_num != null ? car_num : "none");
		
		// 차량 정보 데이터 출력을 위한 carinfo 테이블 데이터
		List<CarInfoDto> car_list = car_mapper.getAllCarInfo();
		mv.addObject("car_list", car_list);
		
		// 지도에 차량 위치 표시를 위한 sscar 테이블의 위도 경도 데이터
		List<SsCarDto> sscar_list = sscar_mapper.getAllDatasOfSsCar();
		List<Double> latitude_list = new ArrayList<Double>();
		List<Double> longtitude_list = new ArrayList<Double>();
		List<String> car_num_list = new ArrayList<String>();
		
		// 차량번호 / 위도 / 경도 데이터를 리스트에 추가해서 넘김
		for (SsCarDto i : sscar_list) {
			latitude_list.add(Double.parseDouble(i.getLatitude()));
			longtitude_list.add(Double.parseDouble(i.getLongtitude()));
			car_num_list.add(i.getCar_num());
		}
		
		// 차량 목록, 개수, 위도 목록, 경도 목록, 차량 번호 목록 보냄
		mv.addObject("sscar_list", sscar_list);
		mv.addObject("sscar_count", sscar_list.size());
		mv.addObject("latitude_list", latitude_list);
		mv.addObject("longtitude_list", longtitude_list);
		mv.addObject("car_num_list", car_num_list);
		
		mv.setViewName("rent/rentForm");
		
		return mv;
	}
	
	// 차량 선택 후 시간 선택시 예약 시간이 겹치지 않도록 예약 시간을 ajax로 받아서 수정
	@ResponseBody
	@GetMapping("rent/getDate")
	public String getDate(@RequestParam String car_num) {
		// 날짜 형식 지정
		SimpleDateFormat date_sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat time_sdf = new SimpleDateFormat("HH");
		
		// 선택한 차량에 대한 전체 예약 정보 받아옴
		List<RentDto> rent_list = rent_mapper.getRezDate(car_num);
		ArrayList<Object> list = new ArrayList<Object>();
		
		// 각 시간을 날짜와 시간으로 나눠서 저장
		for (RentDto i: rent_list) {
			HashMap<String, String> tmp = new HashMap<String, String>();
			tmp.put("startday", date_sdf.format(i.getStart_day()));
			tmp.put("endday", date_sdf.format(i.getEnd_day()));
			tmp.put("starttime", time_sdf.format(i.getStart_day()));
			tmp.put("endtime", time_sdf.format(i.getEnd_day()));
			list.add(tmp);
		}
		
		JSONObject json = new JSONObject();
		
		json.put("data", list);
		
		return json.toString();
	}
	
	// 차량 / 시간 선택 후 결제 페이지
	@GetMapping("rent/payment")
	public ModelAndView payment(@RequestParam String car_num, @RequestParam String start_date, @RequestParam String end_date, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		String login=(String)session.getAttribute("loginok");
		
		if (login!=null) {
			mv.setViewName("rent/payment");
		} else {
			mv.setViewName("member/loginform");
			
			return mv;
		}
		
		// 차량 번호에 대한 정보 가져옴
		SsCarDto sscar_dto = sscar_mapper.getOneDataOfSsCar(car_num);
		CarInfoDto car_dto = car_mapper.getInfoOfCar(sscar_dto.getCi_num());
		
		// 회원 정보에 대한 정보를 가져옴
		MemberDto member_dto = member_mapper.getAllDataById((String)session.getAttribute("id"));
		
		// 타이틀
		mv.addObject("title", "렌트 예약");
		
		// 카카오맵 API
		mv.addObject("api_key", api_key);
		
		// 날짜 비교를 위한 포맷
		SimpleDateFormat compare_sdf = new SimpleDateFormat("yyyy-MM-dd HH");
		Date sdate = null, edate = null;
		long total_hour = 0;
		
		// 날짜 비교 후 차이를 시간으로 나타내줌
		try {
			sdate = compare_sdf.parse(start_date);
			edate = compare_sdf.parse(end_date);
			
			total_hour = (edate.getTime() - sdate.getTime()) / 3600000;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		long total_price = Integer.parseInt(car_dto.getPrice()) + Integer.parseInt(car_dto.getTime_price()) * (total_hour);
		
		// 필요한 객체 추가
		mv.addObject("car_num", car_num);
		mv.addObject("start_date", start_date);
		mv.addObject("end_date", end_date);
		mv.addObject("car_num", car_num);
		mv.addObject("total_hour", total_hour);
		mv.addObject("sdto", sscar_dto);
		mv.addObject("cdto", car_dto);
		mv.addObject("mdto", member_dto);
		mv.addObject("total_price", total_price);
		
		// 결제 서비스 API 코드 추가
		mv.addObject("aCode", aCode);
		mv.addObject("pay_key", pay_key);
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping("rent/reserve")
	public void reserve(@RequestParam String mem_num, @RequestParam String car_num, @RequestParam String start_day, @RequestParam String end_day, @RequestParam String total_price) {
		Timestamp sdate = Timestamp.valueOf(start_day + ":00:00");
		Timestamp edate = Timestamp.valueOf(end_day + ":00:00");
		rent_mapper.insertRez(mem_num, car_num, sdate, edate, total_price);
	}
}
