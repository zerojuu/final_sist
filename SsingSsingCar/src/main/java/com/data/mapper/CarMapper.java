package com.data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.data.dto.CarInfoDto;


@Mapper
public interface CarMapper {
	public List<CarInfoDto> getAllCarInfo();
	public CarInfoDto getInfoOfCar(String ci_num);
	public String getNameOfCar(String ci_num);
	public void insertCarList(CarInfoDto dto);
	public void updateCarList(CarInfoDto dto);
	public void deleteCarList(String ci_num);
}
