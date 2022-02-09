package com.data.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.data.dto.SsCarDto;

@Mapper
public interface SsCarMapper {
	public List<SsCarDto> getAllDatasOfSsCar();
	public SsCarDto getOneDataOfSsCar(String car_num);
	public List<String> getCinumOfCar();
	public void ssCarInsert(SsCarDto dto);
	public void ssCarUpdate(SsCarDto dto);
	public void ssCarDelete(String car_num);
	public List<SsCarDto> getDatasOfCarInfoNum(String ci_num);
}
