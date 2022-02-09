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
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
		
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		
		<!-- footer-style css -->
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/footer-style.css">
		<title>TITLE</title>
	</head>
	
	<body>
		<!-- Site footer -->
		<footer class="site-footer">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 col-md-6">
						<h6>About</h6>
						<p class="text-justify">
							쌍용교육센터 교육과정 최종 프로젝트로 만들어진 페이지입니다.<br>
							JAVA 기반 SpringBoot 프레임워크를 통해 렌트카를 예약할 수 있도록 했습니다.<br>
							관리자 계정을 통해 차량 관리가 가능합니다.
						</p>
					</div>
	
					<div class="col-xs-6 col-md-3">
						<h6>Language</h6>
						<ul class="footer-links">
							<li>JAVA</li>
							<li>HTML / CSS</li>
							<li>SpringBoot</li>
							<li>MyBatis</li>
						</ul>
					</div>
	
					<div class="col-xs-6 col-md-3">
						<h6>References</h6>
						<ul class="footer-links">
							<li><a href="https://www.sist.co.kr/index.jsp" target="_blank">Education Center</a></li>
							<li><a href="https://spring.io/projects/spring-boot" target="_blank">SpringBoot</a></li>
							<li><a href="https://apis.map.kakao.com/web/guide/" target="_blank">Kakao Open API</a></li>
							<li><a href="https://www.billycar.co.kr/billycar/index.do" target="_blank">BillyCar</a></li>
						</ul>
					</div>
				</div>
				<hr>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-sm-6 col-xs-12">
						<p class="copyright-text">
							Copyright &copy; 2021 All Rights Reserved by <a href="/">SsingSsingCar</a>.
						</p>
					</div>
				</div>
			</div>
		</footer>
	</body>
</html>