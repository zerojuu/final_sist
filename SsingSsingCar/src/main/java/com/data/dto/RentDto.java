package com.data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("rdto")
public class RentDto {
	String rent_num, mem_num, car_num;
	Timestamp start_day, end_day;
	
	public String getRent_num() {
		return rent_num;
	}
	public void setRent_num(String rent_num) {
		this.rent_num = rent_num;
	}
	public String getMem_num() {
		return mem_num;
	}
	public void setMem_num(String mem_num) {
		this.mem_num = mem_num;
	}
	public String getCar_num() {
		return car_num;
	}
	public void setCar_num(String car_num) {
		this.car_num = car_num;
	}
	public Timestamp getStart_day() {
		return start_day;
	}
	public void setStart_day(Timestamp start_day) {
		this.start_day = start_day;
	}
	public Timestamp getEnd_day() {
		return end_day;
	}
	public void setEnd_day(Timestamp end_day) {
		this.end_day = end_day;
	}
}
