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
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
div.confirm{
position: relative;
left:0px;
right:0px;
margin-right:auto;
margin-left:auto;
width: 600px;
}
</style>
<title>Insert title here</title>
</head>
<body>
<div class="confirm" align="center">
<form action="updateform" method="post">
<H2>비밀번호확인</H2><br>
<h4>개인정보 보호를 위해 비밀번호를 다시 한번 입력해주세요</h4>
<input type="password" class="form-control" name="mem_pass" id="pw"
  placeholder="비밀번호" style="margin-top: 20px;" required="required">
<button type="submit" class="btn btn-info" style="margin-top: 30px; width: 600px;">확인</button>
</form>
</div>
</body>
</html>