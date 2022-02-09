package com.data.mapper;

import java.util.HashMap;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.data.dto.CarpoolAnswerDto;

@Mapper
public interface CarpoolAnswerMapper {
    
	public void insertCarpoolAnswer(CarpoolAnswerDto cadto);
	public CarpoolAnswerDto getCarpoolAnswer(String ca_num);
	public List<CarpoolAnswerDto> getListCarpoolAnswer(String cp_num);
	public void updateCarpoolAnswer(CarpoolAnswerDto cadto);
	public void deleteCarpoolAnswer(String ca_num);
}
