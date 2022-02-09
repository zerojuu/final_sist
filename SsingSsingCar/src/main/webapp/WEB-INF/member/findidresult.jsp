<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.findidresult-page{
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	height: 400px;
	margin-top: 150px;
}

.findidresult-page .btn{
	width: 100px;
	margin: 20px;
	background-color: #3F5AD4;
 	color:white;
}

.findidresult-page .btn:hover{
	width: 100px;
	margin: 20px;
	background-color: white;
 	color:#3F5AD4;
}

</style>
</head>
<body>

<div class="findidresult-page">
<h1><b>회원 아이디</b></h1>
<div>
<h4>검색된 회원님의 아이디는 <b>${id }</b> 입니다.</h4><br><br>
해당 아이디로 로그인 하실 수 있습니다.
</div>
<div>
<button class="btn" onclick="location.href='/'"><b>홈으로</b></button>
<button class="btn" onclick="location.href='loginform'"><b>로그인하기</b></button>
</div>
</div>
</body>
</html>