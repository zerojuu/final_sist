<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
      <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
table{
	width: 800px;
	border-top: 1px solid #0764d4;
}
table th{
	background: #f8fafd
}
.carlist {
	margin-top: 100px;
}
.carlist_container{margin-top: 100px;}
#go_detail_btn{
	cursor:pointer;
	display:inline-block;background: #0764d4;height:35px;line-height: 35px;font-size: 14px; border-radius:20px;width: 80px;color:#fff; margin-top:10px; margin-bottom:10px;
	-webkit-box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
	-moz-box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
	box-shadow: 0 0 5px 1px rgba(0,0,0,.3);}
.sm-menu {  width:800px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0;} 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}
</style>
<title>Insert title here</title>
</head>
<body>
<div class="carlist_container">
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > 렌트 > <span class="sm-ttl">차량요금정보</span></div></div>
<div class="carlist">
<h3><경형></h3>
<table class="table table-bordered" style="width:800px;">
	<tr>
		<th rowspan="2" style="text-align: center;">차종</th>
		<th rowspan="2" style="text-align: center;">연료</th>
		<th colspan="2" style="text-align: center;">
			요금
		</th>
		<th rowspan="2" style="text-align: center;"></th>	
	</tr>
	<tr align="center">
		<th style="text-align: center;">1시간</th>
		<th style="text-align: center;">1일(24시간)</th>
	</tr>

<c:forEach items="${list}"  var="dto">
	<c:if test="${dto.car_size=='gh' }">
	<tr align="center">
		<td style="font-weight: bold">${dto.name }</td>
		<td>${dto.type }</td>
		<td style="color: #0764d4"><fmt:formatNumber value="${dto.time_price}" type="currency"></fmt:formatNumber></td>
		<td style="color: #0764d4"><fmt:formatNumber value="${dto.price}" type="currency"></fmt:formatNumber></td>
		<td>
			<a id="go_detail_btn" onclick="location.href='cardetail?ci_num=${dto.ci_num}'">
				상세보기
			</a>
		</td>
	</tr>
	</c:if>
</c:forEach>
</table>
</div>

<div class="carlist">
<h3><소형></h3>
<table class="table table-bordered" style="width:800px;">

	<tr>
		<th rowspan="2" style="text-align: center;">차종</th>
		<th rowspan="2" style="text-align: center;">연료</th>
		<th colspan="2" style="text-align: center;">
			요금
		</th>
		<th rowspan="2" style="text-align: center;"></th>	
	</tr>
	<tr align="center">
		<th style="text-align: center;">1시간</th>
		<th style="text-align: center;">1일(24시간)</th>
	</tr>
	<c:forEach items="${list}" var="dto">
		<c:if test="${dto.car_size=='sh' }">
		<tr align="center">
			<td style="font-weight: bold">${dto.name }</td>
			<td>${dto.type }</td>
			<td style="color: #0764d4"><fmt:formatNumber value="${dto.time_price}" type="currency"></fmt:formatNumber></td>
			<td style="color: #0764d4"><fmt:formatNumber value="${dto.price}" type="currency"></fmt:formatNumber></td>
			<td>
				<a id="go_detail_btn" onclick="location.href='cardetail?ci_num=${dto.ci_num}'">
				상세보기
			</a>
			</td>
		</tr>
		</c:if>
	</c:forEach>
</table>
</div>

<div class="carlist">
<h3><중형></h3>
<table class="table table-bordered" style="width:800px;">

	<tr>
		<th rowspan="2" style="text-align: center;">차종</th>
		<th rowspan="2" style="text-align: center;">연료</th>
		<th colspan="2" style="text-align: center;">
			요금
		</th>
		<th rowspan="2" style="text-align: center;"></th>	
	</tr>
	<tr align="center">
		<th style="text-align: center;">1시간</th>
		<th style="text-align: center;">1일(24시간)</th>
	</tr>
	<c:forEach items="${list}" var="dto">
		<c:if test="${dto.car_size=='jh' }">
		<tr align="center">
			<td style="font-weight: bold">${dto.name }</td>
			<td>${dto.type }</td>
			<td style="color: #0764d4"><fmt:formatNumber value="${dto.time_price}" type="currency"></fmt:formatNumber></td>
			<td style="color: #0764d4"><fmt:formatNumber value="${dto.price}" type="currency"></fmt:formatNumber></td>
			<td>
				<a id="go_detail_btn" onclick="location.href='cardetail?ci_num=${dto.ci_num}'">
				상세보기
			</a>
			</td>
		</tr>
		</c:if>
	</c:forEach>
</table>
</div>

<div>
<h3 class="carlist"><대형></h3>
<table class="table table-bordered" style="width:800px;">

	<tr>
		<th rowspan="2" style="text-align: center;">차종</th>
		<th rowspan="2" style="text-align: center;">연료</th>
		<th colspan="2" style="text-align: center;">
			요금
		</th>
		<th rowspan="2" style="text-align: center;"></th>	
	</tr>
	<tr align="center">
		<th style="text-align: center;">1시간</th>
		<th style="text-align: center;">1일(24시간)</th>
	</tr>
	<c:forEach items="${list}" var="dto">
		<c:if test="${dto.car_size=='dh' }">
		<tr align="center">
			<td style="font-weight: bold">${dto.name }</td>
			<td>${dto.type }</td>
			<td style="color: #0764d4"><fmt:formatNumber value="${dto.time_price}" type="currency"></fmt:formatNumber></td>
			<td style="color: #0764d4"><fmt:formatNumber value="${dto.price}" type="currency"></fmt:formatNumber></td>
			<td>
				<a id="go_detail_btn" onclick="location.href='cardetail?ci_num=${dto.ci_num}'">
				상세보기
			</a>	
			</td>
		</tr>
		</c:if>
	</c:forEach>
</table>
</div>
</div>
</body>
</html>
