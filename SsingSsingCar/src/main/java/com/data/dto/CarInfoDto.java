package com.data.dto;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("cidto")
public class CarInfoDto {
	private String ci_num;
	private String name;
	private String year;
	private String price;
	private String time_price;
	private String photo;
	private String type;
	private String car_size;
	
	public String getCi_num() {
		return ci_num;
	}
	public void setCi_num(String ci_num) {
		this.ci_num = ci_num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getTime_price() {
		return time_price;
	}
	public void setTime_price(String time_price) {
		this.time_price = time_price;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCar_size() {
		return car_size;
	}
	public void setCar_size(String car_size) {
		this.car_size = car_size;
	}
}
