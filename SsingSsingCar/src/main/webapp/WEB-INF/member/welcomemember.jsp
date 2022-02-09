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
.welcomemember-page{
	height:500px;
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	align-items: center;
	margin-bottom: 100px;
}

.welcomemember-title{
	font-weight: 700;
}

.welcomemember-content{
	width: 700px;
	text-align: center;
	font-size: 1.2em;
}

.welcomemember-content > span{
	font-size: 1.3em;
}

.welcomemember-btn{
	width: 300px;
	display: flex;
	justify-content: space-around;
	margin-top: 20px;
}

</style>
</head>
<body>
<div class="welcomemember-page">
<h1 class="welcomemember-title">환영합니다</h1>

<div class="welcomemember-content">
<span><span style="color:#1e90ff;">${id }</span>님, 회원가입을 축하합니다.</span><br><br>
씽씽카에서 다양한 렌터카를 경험해보세요.
</div>
<div class="welcomemember-btn">
<button type="button" class="btn btn-default btn-lg" onclick="location.href='/'">홈으로</button>
<button type="button" class="btn btn-default btn-lg" onclick="location.href='/member/loginform'">로그인</button>
</div>
</div>
</body>
</html>