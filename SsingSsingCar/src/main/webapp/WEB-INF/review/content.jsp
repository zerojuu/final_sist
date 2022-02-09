<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
button.btnadd {
	position: relative;
	left: 500px;
}
.sm-menu {  width:1000px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0; } 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}
</style>
</head>
<body>
<br><br><br><br><br>
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > 커뮤니티 > <span class="sm-ttl">차량리뷰 > 상세페이지</span></div></div>
<br><br><br>
<input type="hidden" id="ci_num" value="${ci_num}">
 <c:if test="${sessionScope.loginok!=null }">
<button type="button" class="btn btn-default btnadd" style="width: 100px; height: 40px;" onclick="location.href='form?ci_num=${ci_num }'">작성</button>
</c:if> 

<!-- <table style="width: 1100px; border-top-style: hidden;" class="table">  -->
<table style="width: 1100px;" class="table table-bordered"> 
  <tr>
  <td align="center" rowspan="2" style="width: 300px;">
    <img alt="" src="../carphoto/${cardto.photo}" width="450" height="350"><br>
    <h2><b>${cardto.name }</b><c:if test="${sessionScope.loginok!=null }"> 
    <button type="button" class="btn btn-default btnrent btn-sm" onclick="location.href='../rent/rentForm'">예약</button>
     </c:if></h2> 
  </td>
  
  <td style="height: 160px;">    
    연료 : ${cardto.type } <br>
    연식 : ${cardto.year }<br>
    시간당 가격 : ${cardto.time_price }<br>
 </tr>
 
 <tr>
  <td style="width: 500px; font-size: 1.5em; color: #ffd700;">
    <c:forEach var="rv" items="${list }">
      <c:if test="${rv.rating==0 }">☆☆☆☆☆</c:if>
      <c:if test="${rv.rating==1 }">★☆☆☆☆</c:if>
      <c:if test="${rv.rating==2 }">★★☆☆☆</c:if>
      <c:if test="${rv.rating==3 }">★★★☆☆</c:if>
     <c:if test="${rv.rating==4 }">★★★★☆</c:if>
      <c:if test="${rv.rating==5 }">★★★★★</c:if>
    
      <b style="color: black;">${rv.coment}&nbsp;&nbsp;(${rv.myid})&nbsp;&nbsp;&nbsp;</b>   
      
      <c:if test="${sessionScope.loginok!=null and sessionScope.id==rv.myid }">
        <button type="button" class="btn btn-default btn-xs" onclick="location.href='delete?rv_num=${rv.rv_num}&currentPage=${currentPage}'">삭제</button><br>       
      </c:if>     
      <c:if test="${sessionScope.id!=rv.myid }"><br></c:if>
    </c:forEach>
  </td>
  </tr>
</table>
</body>
</html>