<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- jQuery -->
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		
		<!-- Bootstrap -->
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
		
		<!-- css style -->
		<link href="${ pageContext.request.contextPath }/css/header-style.css" rel="stylesheet">
		<title>TITLE</title>
	</head>
	
	<body>
		<script type="text/javascript">
			$(document).ready(function(){ $('.navbar-xbootstrap').click(function(){
				$('.nav-xbootstrap').toggleClass('visible');
				$('body').toggleClass('cover-bg'); }); 
			});
		</script>
		
		<!-- 로그인/로그아웃일 때 메뉴 변경됨  -->
		<c:if test="${sessionScope.loginok=='true' }">
			<c:set var="location" value="/member/logout"/>
			<c:set var="menu" value="${sessionScope.id } 님"/>
		</c:if>
		<c:if test="${sessionScope.loginok!='true' }">
			<c:set var="location" value="/member/loginform"/>
			<c:set var="menu" value="로그인"/>
		</c:if>
		
									

		<div id="main">
			<div class="container">
				<nav>
					<div class="nav-xbootstrap">
						<ul>
							<li style="margin-right: 50%;"><a href="/">Home</a></li>
														
							<li><a href="/rent/rentForm">렌트<span class="glyphicon glyphicon-chevron-down iconsize"></span></a>
								<ul class="dropdown">
									<li><a href="/car/list">차량 정보</a></li>
									<li><a href="/rent/rentForm">렌트 예약</a></li>
								</ul>
							</li>
							
							<li><a href="javascript:void(0)" >커뮤니티<span class="glyphicon glyphicon-chevron-down iconsize"></span></a>
								<ul class="dropdown">
									<li><a href="/board/list">공지사항</a></li>
									<li><a href="/review/list">차량 리뷰</a></li>
									<li><a href="/carpool/list">카풀</a></li>
								</ul>
							</li>
							
							<c:if test="${sessionScope.loginok=='true' }">
								<c:if test="${ sessionScope.id == 'admin'&&sessionScope.loginok == 'true' }">
									<li><a href="/">관리자 메뉴<span class="glyphicon glyphicon-chevron-down iconsize"></span></a>
										<ul class="dropdown">
											<li><a href="/admin/carlist">차량 정보 관리</a></li>
											<li><a href="/admin/sscarlist">렌트 차량 관리</a></li>
										</ul>
									</li>
								</c:if>
							</c:if>
							
							<c:if test="${sessionScope.loginok=='true' }">
							<li><a href="javascript:void(0)" >${menu }<span class="glyphicon glyphicon-chevron-down iconsize"></span></a>
								<ul class="dropdown">
									<li style="text-align: center;"> 환영합니다!  <img src="${ pageContext.request.contextPath }/img/car_logo.png" width="55"></li>
									<li><a href="${location }">로그아웃</a></li>
									<li><a href="/member/updatepass">회원정보 수정</a></li>
									<li><a href="/member/reservationlist">My 예약</a></li>
								</ul>
							</li>
							</c:if>
							
							<c:if test="${sessionScope.loginok!='true' }">
							<li><a href="${location }" >로그인<span class="glyphicon glyphicon-chevron-down iconsize"></span></a>
							<ul class="dropdown">
									<li style="height: 40px; text-align: center; margin-top: 15px; font-style: italic;">로그인이 필요합니다.</li>
									<li><a href="${location }">${menu }</a></li>
									<li><a href="/member/memberform">회원가입</a></li>
								</ul>
							</li>
							</c:if>
							
							
							
						</ul>
					</div>
				</nav>
			</div>
		</div>
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	</body>
</html>