package com.data.dto;

import org.apache.ibatis.type.Alias;

@Alias("rvdto")
public class ReviewDto {

	private String rv_num,ci_num,mem_num,coment,myid;
	private int rating;

	
	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getRv_num() {
		return rv_num;
	}

	public void setRv_num(String rv_num) {
		this.rv_num = rv_num;
	}

	public String getCi_num() {
		return ci_num;
	}

	public void setCi_num(String ci_num) {
		this.ci_num = ci_num;
	}

	public String getMem_num() {
		return mem_num;
	}

	public void setMem_num(String mem_num) {
		this.mem_num = mem_num;
	}

	public String getComent() {
		return coment;
	}

	public void setComent(String coment) {
		this.coment = coment;
	}

	public String getMyid() {
		return myid;
	}

	public void setMyid(String myid) {
		this.myid = myid;
	}
}
