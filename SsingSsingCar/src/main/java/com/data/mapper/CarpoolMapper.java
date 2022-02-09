package com.data.mapper;

import java.util.HashMap;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.data.dto.CarpoolDto;

@Mapper
public interface CarpoolMapper {
    
	public int getTotalCountOfCarpool();
	public int getMaxNumOfCarpool();
	public void insertCarpool(CarpoolDto cpdto);
	public CarpoolDto getDataOfCarpool(String cp_num);
	public List<CarpoolDto> getListOfCarpool(HashMap<String, Integer> map);
	public void updateCarpool(CarpoolDto cpdto);
	public void deleteCarpool(String cp_num);
	public void updateReadCount(String cp_num);
}
