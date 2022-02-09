package com.data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

@Alias("cadto")
public class CarpoolAnswerDto {

	private String ca_num;
	private String cp_num;
	private String mem_num;
	private String coment;
	private Timestamp answerday;
	private String name,myid;
	
	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCa_num() {
		return ca_num;
	}
	public void setCa_num(String ca_num) {
		this.ca_num = ca_num;
	}
	public String getCp_num() {
		return cp_num;
	}
	public void setCp_num(String cp_num) {
		this.cp_num = cp_num;
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
	public Timestamp getAnswerday() {
		return answerday;
	}
	public void setAnswerday(Timestamp answerday) {
		this.answerday = answerday;
	}
}
