package com.data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.data.dto.MemberDto;
import com.data.dto.RentDto;

@Mapper
public interface MemberMapper {

	public int getTotalCountofMember();
	public void insertOfMember(MemberDto mdto);
	public String getLastNumOfMember();
	public String getNameOfMember(String num);
	public int getCheckPass(HashMap<String, String> map);
	public int getIdCheck(String mem_id);
	public MemberDto getAllDataById(String mem_id);
	public void updateMember(MemberDto dto);
	public int isCorrectLogin(String id, String pass);
	public List<RentDto> getListOfRentList(String mem_num);
	public String getCarName(String car_num);

	public HashMap<String, Object> getRentReserv(String rent_num);
	public String getIdByNameAndHp(String name, String hp);
	//carpool
	public String getNameById(String mem_id);
	public String getMemNumById(String mem_id);
	
	
}
