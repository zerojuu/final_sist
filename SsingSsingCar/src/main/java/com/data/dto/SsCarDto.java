package com.data.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("sdto")
public class SsCarDto {
	String car_num, ci_num, grade, latitude, longtitude;

	public String getCar_num() {
		return car_num;
	}

	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}

	public String getCi_num() {
		return ci_num;
	}

	public void setCi_num(String ci_num) {
		this.ci_num = ci_num;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(String longtitude) {
		this.longtitude = longtitude;
	}
}