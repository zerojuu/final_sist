package com.data.mapper;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.data.dto.ReviewDto;

@Mapper
public interface ReviewMapper {

	public int getTotalCountOfReview();
	public int getMaxNumOfReview();
	public void insertOfReview(ReviewDto rvdto);
	public ReviewDto getReview(String rv_num);
	public List<ReviewDto> getListOfReview();
	public List<ReviewDto> getListOfReviewByCar(String ci_num);
	public void updateOfReview(ReviewDto rvdto);
	public void deleteOfReview(String rv_num);
}
