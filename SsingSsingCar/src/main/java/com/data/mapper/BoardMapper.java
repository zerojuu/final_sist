package com.data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.data.dto.BoardDto;

@Mapper
public interface BoardMapper {
  
	public int getTotalCountOfBoard();
	public int getMaxNumOfBoard();
	public void insertBoard(BoardDto dto);
	public BoardDto getDataOfBoard(String board_num);
	public List<BoardDto> getListOfBoard(HashMap<String, Integer> map);
	public void updateBoard(BoardDto dto);
	public void deleteBoard(String board_num);
}
