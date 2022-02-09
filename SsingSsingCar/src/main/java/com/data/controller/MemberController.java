package com.data.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.data.dto.MemberDto;
import com.data.dto.RentDto;
import com.data.dto.SsCarDto;
import com.data.mapper.MemberMapper;
import com.data.mapper.SsCarMapper;


@Controller
public class MemberController {

	@Autowired
	MemberMapper mapper;
	
	@Autowired
	SsCarMapper sscarMapper;
	
	private String CLIENT_ID = "a6TXdbLqSMGs_4RzNTcu";
	private String CLI_SECRET = "X2SPHRAo4K";

	@GetMapping("/member/memberform")
	public String memberform(Model model)
	{
		 model.addAttribute("title", "회원가입");

		
		return "member/memberform";
	}
	
	@PostMapping("/member/insert")
	public String memberinsert(@ModelAttribute MemberDto dto, Model model)
	{
		mapper.insertOfMember(dto);
		model.addAttribute("id",dto.getMem_id());
		
		return "member/welcomemember";
	}
	
	//로그인중이면 비밀번호확인 아니면 로그인폼으로
	@GetMapping("/member/updatepass")
	public String updatepass(
			Model model,
			HttpSession session)
	{
		String login=(String)session.getAttribute("loginok");
		 model.addAttribute("title", "비밀번호 확인");
		
		
		if(login!=null) {
			return "member/updatepass";
		}else {
			return "member/loginform";
		}
		
	}
	
	@PostMapping("/member/updateform")
	public ModelAndView updateform(
			@RequestParam String mem_pass,
			HttpSession session)
	{
		String id=(String)session.getAttribute("id");
		//아이디로 멤버정보 가져오기
		MemberDto dto=mapper.getAllDataById(id);
		String mem_num=dto.getMem_num();
		
		//db로부터 비번맞나 체크
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("mem_pass", mem_pass);
		map.put("mem_num", mem_num);
				
		int check=mapper.getCheckPass(map);
				
		ModelAndView mview=new ModelAndView();
		mview.addObject("mem_num",mem_num);
		mview.addObject("dto", dto);
		mview.addObject("title","회원정보 수정");
		if(check==1) {
			mview.setViewName("member/updateform");
		}else {
			mview.setViewName("redirect:updatepass");
		}
		
		return mview;
	}
	
	//update
	@PostMapping("/member/update")
	public String update(
			@RequestParam(value = "mem_num",required=false) String mem_num,
			@ModelAttribute MemberDto dto,
			HttpSession session)
	{
		session.removeAttribute("loginok");
		session.removeAttribute("id");
		dto.setMem_num(mem_num);
		
		mapper.updateMember(dto);
		return "redirect:loginform";
	}
	
	//id체크
	@PostMapping("/member/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam String id){
	     int cnt = mapper.getIdCheck(id);
	     return cnt;
    }
	
	//로그인 폼 가기
	@GetMapping("/member/loginform")
	public String goLogInForm(Model model, HttpSession session) throws UnsupportedEncodingException{
		
		//네이버 로그인 버튼 클릭시 인증 요청 API를 보내기 위함
		 String redirectURI = URLEncoder.encode("http://localhost:9001/member/navercallback", "UTF-8");
		 SecureRandom random = new SecureRandom();
		 String state = new BigInteger(130, random).toString();
		 String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		 apiURL += String.format("&client_id=%s&redirect_uri=%s&state=%s",
		        CLIENT_ID, redirectURI, state);
		 session.setAttribute("state", state);
		 model.addAttribute("apiURL", apiURL);
		
		// 페이지 title
		model.addAttribute("title", "로그인");
		return "member/loginform";
	}
	
	//로그인 버튼 클릭시
	@PostMapping("/member/login")
	@ResponseBody
	public int checkAccount(String id, String pass, @RequestParam String save, HttpSession session) {
		
		//아무것도 입력 하지 않았을 때
		if(id.isBlank()||pass.isBlank()) {
			return -1;
		}
		
		//id, 비밀번호 맞는지 체크
		int check = mapper.isCorrectLogin(id,pass);
		
		
		if(check==1) {
			//로그인 세션 저장, id, save 저장
			session.setAttribute("loginok", "true");
			session.setAttribute("id", id);
			session.setAttribute("save", save);		//save 체크시 true : 아니면 false
		}
		
		return check;
	}
	
	//네이버 로그인 버튼 클릭시 콜백할 url
	@GetMapping("/member/navercallback")
	public String goNaverLogin(HttpSession session, HttpServletRequest request, Model model) throws IOException, ParseException  {
		
		//네이버 로그인 api : 접근 토큰 발급
		String code = request.getParameter("code");
	    String state = request.getParameter("state");
	    String redirectURI = URLEncoder.encode("http://localhost:9001/member/navercallback", "UTF-8");
	    String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	    apiURL += "client_id=" + CLIENT_ID;
	    apiURL += "&client_secret=" + CLI_SECRET;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&code=" + code;
	    apiURL += "&state=" + state;
	    System.out.println("apiURL=" + apiURL);
	    String res = requestToServer(apiURL);
	    if(res != null && !res.equals("")) {
	      model.addAttribute("res", res);
	      Map<String, Object> parsedJson = new JSONParser(res).parseObject();
	      System.out.println(parsedJson);
	      session.setAttribute("currentAT", parsedJson.get("access_token"));
	      
	      //렌터카 예약을 위해선 DB에 정보가 저장되어야 함.
	      String id = putNaverMemberProfileIntoDb((String)session.getAttribute("currentAT"));
	    
	      session.setAttribute("loginok", "true");
	      session.setAttribute("id", id);
	      
	    }
	    
	    return "redirect:/";
	}
	
	
	//로그아웃 버튼 클릭시
	@GetMapping("/member/logout")
	public String goLogout(HttpSession session) throws IOException {
		
		session.removeAttribute("loginok");
		session.removeAttribute("id");
		
		return "member/logout";
	}
	
	//예약 상세 페이지
	@GetMapping("/member/rentcheck")
	public ModelAndView getRentDetail(@RequestParam(name = "num") String rentNum) {
		
		ModelAndView mview = new ModelAndView();
		HashMap<String, Object> map = new HashMap<>();
		
		
		//rentNum으로 받아서 예약 상세 정보들 map에 저장
		map = mapper.getRentReserv(rentNum);
		
		
		//시간이 UTC 시간으로 나오기 때문에 +9시간 해줌
		LocalDateTime sDay = (LocalDateTime)map.get("start_day");
		sDay= sDay.plusHours(9);
		
		LocalDateTime eDay = (LocalDateTime)map.get("end_day");
		eDay = eDay.plusHours(9);
		//System.out.println(localDateTime);

		
		//날짜만 뽑기
		String startDay = sDay.toString().split("T")[0];
		String endDay = eDay.toString().split("T")[0];
		
		//시간만 뽑기
		String startTime = sDay.toString().split("T")[1];
		String endTime = eDay.toString().split("T")[1];
	
		map.put("startDay", startDay);
		map.put("endDay", endDay);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		
		// 페이지 title
		mview.addObject("title", "예약상세");
		
		// sql로 받은 항목
		mview.addObject("list", map);
		
		mview.setViewName("member/confirmrent");
		
		return mview;
	}
	
	//회원가입 환영 페이지
	@GetMapping("/member/welcome")
	public String welcome(Model model) {
		// 페이지 title
		model.addAttribute("title", "환영페이지");
		return "member/welcomemember";
	}
	
	//마이페이지 예약리스트
	@GetMapping("/member/reservationlist")
	public ModelAndView reservationlist(
			@RequestParam(value = "list",required=false) Map<String, String> list,
			@RequestParam(value = "totalCount",required=false) String totalCount,
			HttpSession session
			)
	{
		ModelAndView mview=new ModelAndView();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		
		String loginok=(String)session.getAttribute("loginok");
		
		//현재날짜
		var today=sdf.format(cal.getTime());
		mview.addObject("today", today);
		
		//3개월 후 날짜
		cal.add(Calendar.MONTH, +3);
		var tmonth=sdf.format(cal.getTime());
		mview.addObject("tmonth", tmonth);
		mview.addObject("title", "마이페이지");
		mview.addObject("list",list);
		mview.addObject("totalCount",totalCount);
		

		if(loginok=="true") {
			mview.setViewName("member/reservationlist");
		}else {
			mview.setViewName("member/loginform");
		}
		
		return mview;
	}
	
	//ajax 조회
	@PostMapping("/member/inquiry")
	@ResponseBody
	public List<String> inquiry(
			@RequestParam(value = "fromDate") String fromDate,
			@RequestParam(value = "toDate") String toDate,
			HttpSession session
			)
	{
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

		String mem_id=(String)session.getAttribute("id");
		
		String mem_num=mapper.getMemNumById(mem_id);
		
		List<RentDto> rlist=mapper.getListOfRentList(mem_num);
		List<String> mlist=new ArrayList<String>();

		
		for(RentDto s:rlist) {
			String sdate=sdf.format(s.getStart_day());
			String edate=sdf.format(s.getEnd_day());
			//System.out.println(sdate+","+edate+","+fromDate+","+toDate);			
			try {
				java.util.Date day1=sdf.parse(sdate);
				java.util.Date day2=sdf.parse(edate);
				java.util.Date day1_com=sdf.parse(fromDate);
				java.util.Date day2_com=sdf.parse(toDate);

				
				int compare1=day1.compareTo(day1_com);
				int compare2=day2.compareTo(day2_com);
				//System.out.println(compare1+","+compare2);
				if ((compare1==1 || compare1==0) && (compare2==-1 || compare2==0)) {
					//범위 사이에 있으니까 조회하기
					String period=sdate+" ~ "+edate;
					String rentnum=s.getRent_num();
					
					SsCarDto sscar_dto = sscarMapper.getOneDataOfSsCar(s.getCar_num());
					
					String carname=mapper.getCarName(sscar_dto.getCi_num());

					mlist.add(rentnum);
					mlist.add(carname);
					mlist.add(period);
					
				}else {
					//범위 사이에 없으니까 조회x
					//System.out.println("조회x");
				}
				
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		}	
		
		
		return mlist;
	}

	// 서버 통신 확인, 요청된 응답에 대한 값 return
	  private String requestToServer(String apiURL) throws IOException {
	    return requestToServer(apiURL, "");
	  }
	  
	  // 서버 통신 확인, 요청된 응답에 대한 값 return
	  private String requestToServer(String apiURL, String headerStr) throws IOException {
	    URL url = new URL(apiURL);
	    HttpURLConnection con = (HttpURLConnection)url.openConnection();
	    con.setRequestMethod("GET");
	    System.out.println("header Str: " + headerStr);
	    if(headerStr != null && !headerStr.equals("") ) {
	      con.setRequestProperty("Authorization", headerStr);
	    }
	    int responseCode = con.getResponseCode();
	    BufferedReader br;
	    System.out.println("responseCode="+responseCode);
	    if(responseCode == 200) { // 정상 호출
	      br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	    } else {  // 에러 발생
	      br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	    }
	    String inputLine;
	    StringBuffer res = new StringBuffer();
	    while ((inputLine = br.readLine()) != null) {
	      res.append(inputLine);
	    }
	    br.close();
	    if(responseCode==200) {
	      return res.toString();
	    } else {
	      return null;
	    }
	  }
	  
	  //네이버 아이디 로그인시 회원 프로필 DB 저장, id return
	  private String putNaverMemberProfileIntoDb(String accessToken) throws IOException, ParseException {
		  
		  String apiURL = "https://openapi.naver.com/v1/nid/me";
		  String headerStr = "Bearer "+accessToken;
		  String res = requestToServer(apiURL, headerStr);
		  Map<String, Object> parsedJson = new JSONParser(res).parseObject();
	      LinkedHashMap<String, String> list = (LinkedHashMap<String, String>)parsedJson.get("response");
	     
	      String name = list.get("name");
	      String hp = list.get("mobile");
	      String email = list.get("email");
	      String id = email.split("@")[0];
	      String pass = hp.split("-")[2];
	      
	      int result = mapper.getIdCheck(id);
	      
	      // 네이버 로그인이 처음이면 DB에 저장 : 처음이 아니면 DB 저장 x
	      if(result == 0) {
	    	  MemberDto dto = new MemberDto();
		      dto.setMem_name(name);
		      dto.setMem_hp(hp);
		      dto.setMem_email(email);
		      dto.setMem_id(id);
		      dto.setMem_pass(pass);
		      
		      mapper.insertOfMember(dto);
		      
	      }
	      
	      return id;
		  
	  }
	  
	  //아이디 찾기 폼
	  @GetMapping("/member/findidform")
	  public String findIdForm() {
		  return "member/findId";
	  }
	  
	  //아이디 찾기
	  @PostMapping("/member/findIdByHp")
	  public String findIdByHp(String name, String hp, Model model) {
		  
		  String id = mapper.getIdByNameAndHp(name, hp);
		  
		  if(id==null)
			  return "member/nomember";
		  else {
			  model.addAttribute("id", id);
			  return "member/findidresult";
		  
		  }
		  
	  }
}
	
