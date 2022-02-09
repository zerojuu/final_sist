<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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
		
		<!-- swiper-link -->
		<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
		<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
		

		<!-- footer style -->
		<style type="text/css">
			.mainbody {
				min-height: 950px;
				height: auto;
				margin-bottom: 5%;
				vertical-align: middle;
			}
		</style>
		
		<title>${ title }</title>
		</head>

		<body>
		
		<div class="header">
			<tiles:insertAttribute name="header"/>
		</div>
		
		<div class="mainbody" align="center">
			<tiles:insertAttribute name="body"/>
		</div>
		
		<div class="footer">
			<tiles:insertAttribute name="footer"/>
		</div>
		
		</body>
</html>