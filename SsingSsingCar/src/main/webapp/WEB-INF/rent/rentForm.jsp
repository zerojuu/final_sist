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
		
		<!-- style -->
		<link href="${ pageContext.request.contextPath }/css/rent-style.css" rel="stylesheet">
		
		<!-- MAP API -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${ api_key }"></script>
	</head>
	
	<body>
		<div id="wrapper">
			<h1 align="center">렌트 예약</h1>
			<!-- 지도에서 차량 선택 -->
			<div align="center" id="map">
				<h2>차량 및 위치 선택</h2>
				<script type="text/javascript">
					var car_num = '${ car_num }';
				
					var MARKER_WIDTH = 36, // 기본, 클릭 마커의 너비
					    MARKER_HEIGHT = 39, // 기본, 클릭 마커의 높이
					    OFFSET_X = 12, // 기본, 클릭 마커의 기준 X좌표
					    OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
					    OVER_MARKER_WIDTH = 40, // 오버 마커의 너비
					    OVER_MARKER_HEIGHT = 42, // 오버 마커의 높이
					    OVER_OFFSET_X = 13, // 오버 마커의 기준 X좌표
					    OVER_OFFSET_Y = OVER_MARKER_HEIGHT, // 오버 마커의 기준 Y좌표
					    SPRITE_MARKER_URL = '${ pageContext.request.contextPath }/img/marker_img.png', // 스프라이트 마커 이미지 URL
					    SPRITE_WIDTH = 126, // 스프라이트 이미지 너비
					    SPRITE_HEIGHT = 146, // 스프라이트 이미지 높이
					    SPRITE_GAP = 10; // 스프라이트 이미지에서 마커간 간격
		
					var markerSize = new kakao.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
					    markerOffset = new kakao.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
					    overMarkerSize = new kakao.maps.Size(OVER_MARKER_WIDTH, OVER_MARKER_HEIGHT), // 오버 마커의 크기
					    overMarkerOffset = new kakao.maps.Point(OVER_OFFSET_X, OVER_OFFSET_Y), // 오버 마커의 기준 좌표
					    spriteImageSize = new kakao.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기
		
					var positions = [],
						car_nums = [],
					    selectedMarker = null; // 클릭한 마커를 담을 변수
					
					var latitude_list = ${ latitude_list },
						longtitude_list = ${ longtitude_list};
						car_num_list = ${ car_num_list };
						
					for (var i = 0; i < ${ sscar_count }; i++) {
						positions.push(new kakao.maps.LatLng(latitude_list[i], longtitude_list[i]));
						car_nums.push(car_num_list[i]);
					}
		
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div
					    mapOption = { 
					        center: new kakao.maps.LatLng(latitude_list[0], longtitude_list[0]), // 지도의 중심좌표
					        level: 3 // 지도의 확대 레벨
					    };
					
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
					// 지도 위에 마커를 표시합니다
					for (var i = 0, len = positions.length; i < len; i++) {
					    var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
					        originY = (MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
					        overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP) * i, // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
					        normalOrigin = new kakao.maps.Point(0, originY), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
					        clickOrigin = new kakao.maps.Point(gapX, originY), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
					        overOrigin = new kakao.maps.Point(gapX * 2, overOriginY); // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표
					        
					    // 마커를 생성하고 지도위에 표시합니다
					    addMarker(positions[i], normalOrigin, overOrigin, clickOrigin, car_nums[i]);
					}
		
					// 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
					function addMarker(position, normalOrigin, overOrigin, clickOrigin, car_num) {
		
					    // 기본 마커이미지, 오버 마커이미지, 클릭 마커이미지를 생성합니다
					    var normalImage = createMarkerImage(markerSize, markerOffset, normalOrigin),
					        overImage = createMarkerImage(overMarkerSize, overMarkerOffset, overOrigin),
					        clickImage = createMarkerImage(markerSize, markerOffset, clickOrigin);
					    
					    // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
					    var marker = new kakao.maps.Marker({
					    	title: car_num,
					        map: map,
					        position: position,
					        image: normalImage
					    });
		
					    // 마커 객체에 마커아이디와 마커의 기본 이미지를 추가합니다
					    marker.normalImage = normalImage;
		
					    // 마커에 mouseover 이벤트를 등록합니다
					    kakao.maps.event.addListener(marker, 'mouseover', function() {
					    	marker.setImage(overImage);
					    });
		
					    // 마커에 mouseout 이벤트를 등록합니다
					    kakao.maps.event.addListener(marker, 'mouseout', function() {
					    	marker.setImage(normalImage);
					    });
		
					    // 마커에 click 이벤트를 등록합니다
					    kakao.maps.event.addListener(marker, 'click', function() {
					        // 클릭된 마커를 현재 클릭된 마커 객체로 설정합니다
					        selectedMarker = marker;
					        
					        // 차량 선택 이벤트 발생시킴
					        $("tbody#" + selectedMarker.getTitle()).trigger("click");
					        
					        // 지도의 좌표를 차량 위치로 변경
					        map.panTo(position);
					    });
					}
		
					// MakrerImage 객체를 생성하여 반환하는 함수입니다
					function createMarkerImage(markerSize, offset, spriteOrigin) {
					    var markerImage = new kakao.maps.MarkerImage(
					        SPRITE_MARKER_URL, // 스프라이트 마커 이미지 URL
					        markerSize, // 마커의 크기
					        {
					            offset: offset, // 마커 이미지에서의 기준 좌표
					        }
					    );
					    
					    return markerImage;
					}
					
					$("div#map").css("z-index", 0);
				</script>
			</div>
			
			
			<!-- 차량 목록 -->
			<div align="center" class="cardiv">
				<h2>차량 선택</h2>
				<table id="car_table" class="table">
					<!-- sscar 테이블과 carinfo 테이블 데이터를 반복하면서 정보를 출력 -->
					<c:forEach items="${ sscar_list }" var="i">
						<c:forEach items="${ car_list }" var="j">
							<c:if test="${ j.ci_num == i.ci_num }">
								<!-- 차량 정보 출력 -->
								<tbody class="car_select" id="${ i.car_num }">
									<!-- 차량 정보 출력 -->
									<tr class="btn_tr">
										<th rowspan="3" width="150px">
											<img alt="${ j.name }" src="../carphoto/${ j.photo }" style="width: 150px; height: 120px;">
										</th>
										<th>${ j.name }(${ j.year })</th>
										<th>${ j.type }</th>
									</tr>
									
									<tr class="btn_tr">
										<th>기본 가격</th>
										<td><fmt:formatNumber value="${ j.price }" type="currency"/></td>
									</tr>
									
									<tr class="btn_tr">
										<th>차량 상태</th>
										<td>${ i.grade }</td>
									</tr>
								</tbody>
							</c:if>
						</c:forEach>
					</c:forEach>
				</table>
			</div>
			
			<!-- 대여 일자 선택 -->
			<div align="center" class="date">
				<h2>대여 일자</h2>
				<input type="date" name="start_day">
				<select id="start_time">
					<option value="none">시간 선택</option>
				</select>
				
				<br><br><br><br><br><br><br>
				
				<h2>반납 일자</h2>
				<input type="date" name="end_day">
				<select id="end_time">
					<option value="none">시간 선택</option>
				</select>
				
				<!-- option 추가 스크립트 -->
				<script type="text/javascript">
					for(var i = 0; i <= 23; i++) {
						if (i <= 9) {
							$("#start_time").append("<option value='" + i + "'>0" + i + " : 00</option>");
							$("#end_time").append("<option value='" + i + "'>0" + i + " : 00</option>");
						} else {
							$("#start_time").append("<option value='" + i + "'>" + i + " : 00</option>");
							$("#end_time").append("<option value='" + i + "'>" + i + " : 00</option>");
						}
					}
				</script>
				
				<br><br><br><br><br><br><br><br><br><br>
				
				<!-- 예약 버튼 -->
				<button id="reserve" disabled>예약</button>
			</div>
		</div>
		
		<!-- 사용자 함수들 -->
		<script src="${ pageContext.request.contextPath }/js/rent-js.js" type="text/javascript"></script>
		
		<!-- 이전 페이지에서 차량 선택시 해당 차량 선택 이벤트 발생 -->
		<c:if test="${ car_num != null }">
			<script type="text/javascript">
				// 차량 선택 이벤트 발생시킴
			    $("tbody#" + car_num).trigger("click");
			</script>
		</c:if>
	</body>
</html>