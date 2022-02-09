<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.2/css/bootstrap-responsive.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.js"></script>

<title>Insert title here</title>
<style type="text/css">
.rbody{
	margin-top: 120px;
}
.period-serach
{
    display: flex;
	flex-direction: column;
	justify-content: flex-start;
	width:90%;
	height:90%;	
	max-width:1000px;
	max-height:700px;
	margin: auto;
}


</style>

</head>
<body class="rbody">
<form action="inquiry" method="post" class="form-inline">
  <input type="hidden" id="selectedMonth" name="selectedMonth" value=""/>
  <div class="period-serach">
      <hr style="margin-bottom:10px; height : 2px; border: none; background-color: gray;">
      
      <div class="period-calendar">
        <span style="float: left;">
        <b>조회기간</b>&nbsp;&nbsp;&nbsp;
      
        <button class="btn btn-line4" type="button"
        onclick="selectMonth(this)" data-value="1" style="border: 1px solid gray;">1개월</button>
        <button class="btn btn-line4" type="button"
        onclick="selectMonth(this)" data-value="3" style="border: 1px solid gray;">3개월</button>
        <button class="btn btn-line4" type="button"
        onclick="selectMonth(this)" data-value="6" style="border: 1px solid gray;">6개월</button>
        </span>
        <span class="date" style="float: right;">
          <input type="date" id="datepicker-start" name="fromDate" value="${today }">
          <span class="text"><b>-</b></span>
          <input type="date" id="datepicker-end" name="toDate" value="${tmonth }">
          &nbsp;&nbsp;&nbsp;&nbsp;	    
          <button onclick="search()" class="btn btn-outline-secondary" type="button" style="border: 1px solid gray;">조회하기</button>
        </span>
  </div>
  <hr style="margin-top:10px; height : 2px; border: none; background-color: gray;">
  <div class="period-list">
    <table id="tb" class="table table-striped">
      <thead>
        <tr bgcolor="#EFEFFB">
          <th scope="col" width="50">번호</th>
          <th scope="col" width="60">예약번호</th>
          <th scope="col" width="200">차량이름</th>
          <th scope="col" width="300">예약일</th>
        </tr>
      </thead>
      <tbody id="period-tbody"></tbody>
    </table>
  </div>
</div>
</form>

<script type="text/javascript">
$(document).ready(function(){
	//조회기간 클릭유지
	var selectedMonth = $("#selectedMonth").val();
	$(".btn.btn-line4").each(function(){
		var dataValue = $(this).attr("data-value");
		if(selectedMonth == dataValue){
			$(this).addClass("selected");
		}
	});
});

//페이징 처리 함수
function getPList(pageNo, rowPerPage){
	showloading(); //로딩이미지 보이기
	var frm = document.frm;
	$("#pageNo").val(pageNo);
	$("#rowPerPage").val(rowPerPage);
	frm.action = '/billycar/myrnt/short/short_list.do';
	frm.submit();
}

//조회하기 버튼클릭
function search(){
	var fromDate = $("#datepicker-start").val();
    var toDate = $("#datepicker-end").val();
    var table=document.getElementById('period-tbody');
 
    var html="";
    
    $.ajax({
        url:'inquiry',
        dataType:"json",
        type:'post',
        data:{"fromDate":fromDate, "toDate":toDate},
        success:function(mlist){ //컨트롤러에서 넘어온 list
        	for(var index=0; index<mlist.length; index++){
        		
        		var i=index+3;
        		
        		if(i%3==0)
        			{
            	    html += '<tr>';
            	    html += '<td>'+(index+1)+'</td>';
            	    html += '<td>'+'<a href="rentcheck?num='+mlist[index]+'">'+mlist[index]+'</a>'+'</td>';
            	    html += '<td>'+mlist[index+1]+'</td>';
            	    html += '<td>'+mlist[index+2]+'</td>';
            	    html += '</tr>';	
        			}
        	}

        if(mlist.length==0)
        	{
        	html+='<tr>';
        	html+='<td colspan=4 style="text-align: center;">'+"에약된 정보가 없습니다"+'</td>';
        	html+='</tr>';
        	}
        
        	$("#period-tbody").empty();
    		$("#period-tbody").append(html);
   	    }    
   	});
}	

// 1,3,6개월 클릭 시 날짜 처리
function selectMonth(e){
	var selectedMonth = $(e).attr("data-value");
	$("#selectedMonth").val(selectedMonth);
	$(e).siblings("a").removeClass("selected");
	$(e).addClass("selected");
	
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	
	if(dd < 10){
		dd = '0' + dd;
	}
	
	if(mm < 10){
		mm = '0' + mm;
	}
	
	$("input[name='fromDate']").val("");
	$("input[name='fromDate']").val(yyyy+"-"+mm+"-"+dd);
	
	var fromDate = $("input[name='fromDate']").val();
	var splitToDate = fromDate.split("-");
	var pDate, year, month, date;
	
	pDate = new Date(splitToDate[0], splitToDate[1] - selectedMonth, splitToDate[2]);
	year = pDate.getFullYear();
	month = pDate.getMonth();
	
	if(String(month) == "0"){
		year = year-1;
		month = "12";
	}
	if(String(month).length == 1){
		month = "0"+month;
	}
	date = pDate.getDate();
	if(String(date).length == 1){
		date = "0"+date;
	}
	
	$("input[name='fromDate']").val("");
	$("input[name='fromDate']").val(year+"-"+month+"-"+date);
	
	//윤달 및 날짜 유효성 체크
	var fDate = $("input[name='fromDate']").val();
	var afDate = fDate.split('-'); 
	
	var yYear = afDate[0];
	var yMonth = afDate[1];
	var yDate = afDate[2];
		
	if(yMonth == '02'){
		if(yDate == '29' || yDate == '30' || yDate == '31'){
			yDate = '28';
			date = yDate; 
		}			
	}else if(yMonth == '04' || yMonth == '06' || yMonth == '09' || yMonth == '11'){
		if(yDate == '31'){
			yDate = yDate - 1;
			date = yDate;
		}
	}
	
	$("input[name='fromDate']").val("");
	$("input[name='fromDate']").val(year+"-"+month+"-"+date);
}

function dateValue() {
	var time = new Date();
	var year = time.getFullYear() + "";
	var month = time.getMonth() + 1;
	var date = time.getDate();
	var hour = time.getHours();
	var minute = time.getMinutes();
	if (month < 10) {
		month = "0" + month;
	}
	if (date < 10) {
		date = "0" + date;
	}
	if (hour < 10) {
		hour = "0" + hour;
	}
	return year + month + date + hour + minute;
}

function detailMyShortRentalObj(cntrId, division){
	$("#cntrId").val(cntrId);    
	$("#division").val(division);
	var frm = document.frm;
	frm.action = "/billycar/myrnt/short/short_detail.do";
	frm.submit();
}

//날짜 input box에 직접 날짜 넣어서 검색했을 때 1,3,6개월 selected 초기화
function initSelectedMonth(){
	$(".btn.btn-line4").removeClass('selected');
}

// 날짜 형식 체크 (ex.YYYY-MM-DD)
function dateCheck(date){
	var checkValue = false;
	var pattern = /^\d{4}\-\d{2}\-\d{2}$/;
	if(pattern.test(date)){
		checkValue = true; 
	}else{
		checkValue = false;
	}
	return checkValue;
}
</script>

</body>
</html>