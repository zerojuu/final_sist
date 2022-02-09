package com.data.mapper;

import java.sql.Timestamp;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.data.dto.RentDto;

@Mapper
public interface RentMapper {
	public List<RentDto> getRezDate(String car_num);
	public void insertRez(String mem_num, String car_num, Timestamp start_day, Timestamp end_day, String total_price);
}
