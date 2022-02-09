package com.data.controller;

import java.io.File;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.data.dto.CarInfoDto;
import com.data.dto.MemberDto;
import com.data.dto.SsCarDto;
import com.data.mapper.CarMapper;
import com.data.mapper.MemberMapper;
import com.data.mapper.SsCarMapper;


@Controller
public class AdminController {
	
	@Autowired
	CarMapper mapper;
	
	@Autowired
	SsCarMapper ssmapper;
	
	@Autowired
	MemberMapper mmapper;
	
	@GetMapping("admin/carlist")
	public ModelAndView carlist()
	{	
		ModelAndView mview = new ModelAndView();
		List<CarInfoDto> list = mapper.getAllCarInfo();
		mview.addObject("list", list);
	
		mview.setViewName( "admin/carlist");
		return mview;
	}
	@GetMapping("admin/caraddform")
	public String caraddform()
	{
		return "admin/caraddform";
	}
	@PostMapping("admin/insert")
	public String insert(@ModelAttribute CarInfoDto dto,
			 			@RequestParam MultipartFile upload,
			 			HttpSession session)
	{
		String path = session.getServletContext().getRealPath("/carphoto");
		System.out.println(path);
		String filename = upload.getOriginalFilename(); //업로드한 파일명
		System.out.println(filename);
		dto.setPhoto(filename);
		
		
			//path에 업로드
			try {
				upload.transferTo(new File(path+"\\"+filename));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		mapper.insertCarList(dto);
		
		return "redirect:carlist";
	}
	@GetMapping("admin/updatecarform")
	public String updatecarlist(@RequestParam String ci_num,
								Model model)
	{
		 CarInfoDto dto = mapper.getInfoOfCar(ci_num);
		model.addAttribute("dto", dto);
			
		return "admin/updatecarform";	
	}
	@PostMapping("admin/update")
	public String update(@ModelAttribute CarInfoDto dto,
						 @RequestParam MultipartFile upload,
						 HttpSession session)
	{
	
		String path = session.getServletContext().getRealPath("/carphoto");
		String filename = upload.getOriginalFilename(); //업로드한 파일명
	
		if(!filename.equals(""))
		{	
			dto.setPhoto(filename);
			//path에 업로드
			try {
				upload.transferTo(new File(path+"\\"+filename));
				
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else
		{
			filename="Null"; //업로드 하지 않았을 경우
			dto.setPhoto(filename);
		}
	
		mapper.updateCarList(dto);
		
		return "redirect:carlist";
	}
	@GetMapping("admin/deletecar")
	public String delete(@RequestParam String ci_num,
						 HttpSession session)
	{
		//photo폴더 사진 지우기
				String uploadfile = mapper.getInfoOfCar(ci_num).getPhoto();
							
				//실제 업로드 경로
					String path = session.getServletContext().getRealPath("/carphoto");
					System.out.println(path);
						File file = new File(path+"\\"+uploadfile);
						file.delete();
					
					mapper.deleteCarList(ci_num);
				
				
				return "redirect:carlist";
	}
	@GetMapping("admin/sscarinfo")
	public ModelAndView sscaraddform()
	{	ModelAndView mview = new ModelAndView();
		
		String api_key = "9a033f3e554352ea8253b04b6f4efe4e";
	
		List<SsCarDto> list = ssmapper.getAllDatasOfSsCar();
		List<CarInfoDto> cilist = mapper.getAllCarInfo();
		
		mview.addObject("api_key", api_key);
		mview.addObject("title", "렌트 차량 관리");
		mview.addObject("list", list);
		mview.addObject("cilist", cilist);
		mview.setViewName("admin/sscarwriteform");
		return mview;
	}
	@PostMapping("admin/ssinsert")
	public String ssinsert(@ModelAttribute SsCarDto dto) {
		ssmapper.ssCarInsert(dto);
		return "redirect:sscarinfo";
	}
	@GetMapping("admin/sscarlist")
	public ModelAndView sscarlist()
	{  	ModelAndView mview = new ModelAndView();
	
		List<SsCarDto> sslist = ssmapper.getAllDatasOfSsCar();
		
		List<String> cnlist = ssmapper.getCinumOfCar();
		List<String> nlist = new ArrayList<String>();
		for(int i=0;i<cnlist.size();i++) {
			nlist.add(mapper.getNameOfCar(cnlist.get(i)));
		}
		mview.addObject("title","렌트 차량 목록");
		mview.addObject("nlist", nlist);
		mview.addObject("sslist", sslist);
		mview.setViewName("admin/sscarlist");
		return mview;
	}
	@GetMapping("admin/ssupdateform")
	public ModelAndView updateform(@RequestParam String car_num)
	{	ModelAndView mview = new ModelAndView();
	
		String api_key = "9a033f3e554352ea8253b04b6f4efe4e";
		List<SsCarDto> list = ssmapper.getAllDatasOfSsCar();
		List<CarInfoDto> cilist = mapper.getAllCarInfo();
		List<String> glist= new ArrayList<String>();
		glist.add("A");
		glist.add("B");
		glist.add("C");
		glist.add("D");
		
		SsCarDto sdto = ssmapper.getOneDataOfSsCar(car_num);
		
		String lat= sdto.getLatitude();
		String lng = sdto.getLongtitude();
		
		mview.addObject("api_key", api_key);
		mview.addObject("title", "렌트 차량 정보 수정");
		mview.addObject("sdto", sdto);
		mview.addObject("list", list);
		mview.addObject("glist", glist);
		mview.addObject("lat",lat);
		mview.addObject("lng", lng);
		mview.addObject("cilist", cilist);
		
		mview.setViewName("admin/ssupdateform");
		
		return mview;
	}
	@PostMapping("admin/ssupdate")
	public String ssupdate(@ModelAttribute SsCarDto dto) {
		ssmapper.ssCarUpdate(dto);
		return "redirect:sscarlist";
	}
	@GetMapping("admin/ssdelete")
	public  @ResponseBody Map<String, Integer> ssdelete(@RequestParam String car_num,
							@RequestParam String mem_pass,
							HttpSession session) {
		
		String id=(String)session.getAttribute("id");
		
		MemberDto dto=mmapper.getAllDataById(id);
		String mem_num=dto.getMem_num();
		
		System.out.println(mem_num);
		System.out.println(mem_pass);
		
		
		HashMap<String, String> map=new HashMap<String, String>();
		map.put("mem_pass", mem_pass);
		map.put("mem_num", mem_num);
				
		int check=mmapper.getCheckPass(map);
		
		if(check==1) 
			ssmapper.ssCarDelete(car_num);
		
		HashMap<String, Integer>rmap = new HashMap<String, Integer>();
		rmap.put("check", check);
		return rmap;
	}
}
