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
		
		<!-- style -->
		<link href="${ pageContext.request.contextPath }/css/payment-style.css" rel="stylesheet">

		<!-- MAP API -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${ api_key }"></script>
		
		<!-- PAY API -->
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	</head>
	
	<body>
		<div class="wrapper" align="center">
			<h1 align="center">예약 정보</h1><br><br>
			<!-- 지도 표시 -->
			<div id="map"></div>
			<script type="text/javascript">
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				    mapOption = { 
				        center: new kakao.maps.LatLng(${ sdto.latitude }, ${ sdto.longtitude}), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };
		
				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: new kakao.maps.LatLng(${ sdto.latitude }, ${ sdto.longtitude})
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
				
				$("div#map").css("z-index", 0);
			</script>
			
			<!-- 예약 정보 표시 -->
			<div id="info" align="center">
				<h2>대여 일자</h2>
				<p>${ start_date }시   ~   ${ end_date }시</p>
				
				<hr>
				
				<h2>차량 정보</h2>
				<br>
				<table>
					<tr>
						<td rowspan="3" align="center">
							<img alt="${ cdto.name }" src="../carphoto/${ cdto.photo }">
						</td>
						<th>${ cdto.name } (${ cdto.year })</th>
					</tr>
					
					<tr>
						<td>
							<c:if test="${ cdto.car_size == 'gh' }">경형 / ${ cdto.type }</c:if>
							<c:if test="${ cdto.car_size == 'sh' }">소형 / ${ cdto.type }</c:if>
							<c:if test="${ cdto.car_size == 'jh' }">중형 / ${ cdto.type }</c:if>
							<c:if test="${ cdto.car_size == 'dh' }">대형 / ${ cdto.type }</c:if>
						</td>
					</tr>
					
					<tr>
						<td>차량 등급 : ${ sdto.grade }</td>
					</tr>
				</table>
				
				<br><hr><br>
				
				<h2>요금 정보</h2>
				<p>차량 기본 요금 : <fmt:formatNumber value="${ cdto.price }" type="currency"/> / 시간 당 요금 : <fmt:formatNumber value="${ cdto.time_price }" type="currency"/> / 대여 시간 : ${ total_hour }시간</p>
				<p><fmt:formatNumber value="${ cdto.price }" type="currency"/> + (<fmt:formatNumber value="${ cdto.time_price }" type="currency"/> * ${ total_hour })</p>
				<b>총 <fmt:formatNumber value="${ total_price }" type="currency"/></b>
			</div>
			
			<br><br><br><br><br><br><br><br><br><br><br><br>
			
			<!-- 결제 버튼 -->
			<button class="payment" onclick="requestPay()">
				결제하기
			</button>
			
			<!-- 버튼 클릭 이벤트 -->
			<script type="text/javascript">
				var IMP = window.IMP;
				IMP.init("${ aCode }");
				
				function requestPay() {
					// 결제 창 호출
					IMP.request_pay({
						pg: "html5_inicis",
						pay_method: "card",
						merchant_uid: 'sscar_' + new Date().getTime(),
						name: "씽씽카 렌트 예약",
						amount: ${ total_price },
						buyer_email: "${ mdto.mem_email }",
						buyer_name: "${ mdto.mem_name }",
						buyer_tel: "${ mdto.mem_hp }",
					}, function (rsp) {
						if (rsp.success) {
							// 결제 성공 -> 렌트 테이블에 데이터 등록
							insertRent('${ mdto.mem_num }', '${ car_num }', '${ start_date }', '${ end_date }', '${ total_price }');
							alert("결제되었습니다.");
							location.href = '/';
						} else {
							// 결제 실패
							alert("결제에 실패하였습니다. : " + rsp.error_msg);
							location.reload();
						}
					});
				}
			</script>
		</div>
		
		
		<!-- 사용자 함수 -->
		<script src="${ pageContext.request.contextPath }/js/payment-js.js" type="text/javascript"></script>
	</body>
</html>