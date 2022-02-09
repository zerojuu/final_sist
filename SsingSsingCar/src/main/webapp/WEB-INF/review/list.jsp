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
#wrap{
    width: 1100px;
    margin: 0 auto;
    overflow: hidden;
    padding-top: 10px;
}
div>a{
    float: left;
    margin-left: 10px;
    margin-bottom: 10px;
}
.sm-menu {  width:1000px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0; } 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}
</style>
</head>
<body>
<br><br><br><br><br>
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > 커뮤니티 > <span class="sm-ttl">차량리뷰</span></div></div>
<br><br>
<div style="width: 1000px;">
<select onchange="if(this.value) location.href=(this.value);" style="height: 30px; text-align: center; float: right;">
  <option value="list">전체
<c:forEach var="c" items="${carlist}">
  <option value="content?ci_num=${c.ci_num}&currentPage=${currentPage}">${c.name}</option>
</c:forEach>
</select>
<br><br><br><br>
<div id="wrap">
<c:forEach var="c" items="${carlist }">
<div style="background-color: gray;">
<a href="content?ci_num=${c.ci_num}&currentPage=${currentPage}"><img alt="${c.name }" src="../carphoto/${ c.photo }" width="250" height="200"><br>${c.name}</a>
</div>
</c:forEach>
</div>
</div>
</body>
</html>