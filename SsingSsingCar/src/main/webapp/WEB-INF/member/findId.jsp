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
.findidform-page{
	width: 500px;
	height: 450px;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	padding: 20px;
	margin-top: 150px;
}

.findidform-content{
	display: flex;	
	margin-bottom: 30px;
}

.findidform-content >span{
	width: 80px;
}

.findIdBtn{
	width : 80px;
	float: center;
	margin-top: 20px;
	background-color: #3F5AD4;
 	color:white;
 	font-weight: 700;
}
.findIdBtn:hover{
	
	background-color: white;
 	color: #3F5AD4;
 	font-weight: 700;
 	
}
</style>
</head>
<body>
<div class="findidform-page">
<h1><b>아이디 찾기</b></h1>
<br><br>
<div>
회원 가입시 등록했던 이름과 전화번호를 입력 바랍니다.
</div>
<br>
<form action="findIdByHp" method="post">
<div class="findidform-content"><span>이름</span> <input type="text" class="form-control" name="name"></div>
<div class="findidform-content"><span>전화번호</span><input type="text" class="form-control" placeholder="010-0000-0000" name="hp"></div>

<div>
<input type="submit" class="btn btn-sm findIdBtn" value="확인">
</div>
</form>
</div>
</body>
</html>