<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- style -->
<link href="${ pageContext.request.contextPath }/css/admin.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- MAP API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${ api_key }"></script>

<script type="text/javascript">
$(function(){
	$("li").click(function(){
	    $(this).addClass("active");
	 	$(this).siblings().finish("li").removeClass("active");	
	});
	$(".ciop").click(function(){
		$(".ci_num").val($(this).val());
		
	});
	$(".gop").click(function(){
		$(".grade").val($(this).text());
	});
	
})
</script>


<title>Insert title here</title>
</head>
<body>

<form action="ssinsert" method="post">
<input type="hidden" value="${car_num}">
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > ADMIN > <span class="sm-ttl">렌트차량등록</span></div></div>
<div class="wrapper">
<div class="car-ttl">
	<ul>
		<li class="tab-ttl1">차종</li>
		<li class="tab-ttl2">등급</li>
		<li class="tab-ttl3">차량위치</li>
	</ul>
</div>
<div class="scar">
	<!--차종 선택 -->
	<div class="carname">
		<div class="carnum">
			<input class="ci_num" name="ci_num" type="hidden" value="">
			 <ul>
		 		<c:forEach var="ci" items="${cilist}" varStatus="i">
					<li class="ciop" value="${ci.ci_num}">${ci.name}</li>	
				</c:forEach> 
			</ul>
		</div>
	</div>
	<!--등급 선택-->
	<div class="cargrade">
		<div class="grade">
				<input class="grade" name="grade" type="hidden" value="">
		 		<ul>
		 			<li class="gop" value="A">A</li>
		 			<li class="gop" value="B">B</li>
		 			<li class="gop" value="C">C</li>
		 			<li class="gop" value="D">D</li>
		 		</ul>
		</div>
	</div>
</div>
	<!--map-->
	<div class="map" id="map">
				<script type="text/javascript">
				
					var MARKER_WIDTH = 33, // 기본, 클릭 마커의 너비
					    MARKER_HEIGHT = 36, // 기본, 클릭 마커의 높이
					    OFFSET_X = 12, // 기본, 클릭 마커의 기준 X좌표
					    OFFSET_Y = MARKER_HEIGHT, // 기본, 클릭 마커의 기준 Y좌표
					    OVER_MARKER_WIDTH = 40, // 오버 마커의 너비
					    OVER_MARKER_HEIGHT = 42, // 오버 마커의 높이
					    OVER_OFFSET_X = 13, // 오버 마커의 기준 X좌표
					    OVER_OFFSET_Y = OVER_MARKER_HEIGHT, // 오버 마커의 기준 Y좌표
					    SPRITE_MARKER_URL = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markers_sprites2.png', // 스프라이트 마커 이미지 URL
					    SPRITE_WIDTH = 126, // 스프라이트 이미지 너비
					    SPRITE_HEIGHT = 146, // 스프라이트 이미지 높이
					    SPRITE_GAP = 10; // 스프라이트 이미지에서 마커간 간격
		
					var markerSize = new kakao.maps.Size(MARKER_WIDTH, MARKER_HEIGHT), // 기본, 클릭 마커의 크기
					    markerOffset = new kakao.maps.Point(OFFSET_X, OFFSET_Y), // 기본, 클릭 마커의 기준좌표
					    overMarkerSize = new kakao.maps.Size(OVER_MARKER_WIDTH, OVER_MARKER_HEIGHT), // 오버 마커의 크기
					    overMarkerOffset = new kakao.maps.Point(OVER_OFFSET_X, OVER_OFFSET_Y), // 오버 마커의 기준 좌표
					    spriteImageSize = new kakao.maps.Size(SPRITE_WIDTH, SPRITE_HEIGHT); // 스프라이트 이미지의 크기
		
					var selectedMarker = null; // 클릭한 마커를 담을 변수
					
		
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div
					    mapOption = { 
					        center: new kakao.maps.LatLng(37.499455216407554, 127.03316861047564), // 지도의 중심좌표
					        level: 3 // 지도의 확대 레벨
					    };
					
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
					// 지도 위에 마커를 표시합니다
			
					    var gapX = (MARKER_WIDTH + SPRITE_GAP), // 스프라이트 이미지에서 마커로 사용할 이미지 X좌표 간격 값
					        originY = (MARKER_HEIGHT + SPRITE_GAP), // 스프라이트 이미지에서 기본, 클릭 마커로 사용할 Y좌표 값
					        overOriginY = (OVER_MARKER_HEIGHT + SPRITE_GAP), // 스프라이트 이미지에서 오버 마커로 사용할 Y좌표 값
					        normalOrigin = new kakao.maps.Point(0, originY), // 스프라이트 이미지에서 기본 마커로 사용할 영역의 좌상단 좌표
					        clickOrigin = new kakao.maps.Point(gapX, originY), // 스프라이트 이미지에서 마우스오버 마커로 사용할 영역의 좌상단 좌표
					        overOrigin = new kakao.maps.Point(gapX * 2, overOriginY), // 스프라이트 이미지에서 클릭 마커로 사용할 영역의 좌상단 좌표
					        position = new kakao.maps.LatLng(37.499455216407554, 127.03316861047564);
					 
					    // 마커를 생성하고 지도위에 표시합니다
					    addMarker(position,normalOrigin, overOrigin, clickOrigin);
					
		
					// 마커를 생성하고 지도 위에 표시하고, 마커에 mouseover, mouseout, click 이벤트를 등록하는 함수입니다
					function addMarker(position, normalOrigin, overOrigin, clickOrigin) {
		
					    // 기본 마커이미지, 오버 마커이미지, 클릭 마커이미지를 생성합니다
					    var normalImage = createMarkerImage(markerSize, markerOffset, normalOrigin),
					        overImage = createMarkerImage(overMarkerSize, overMarkerOffset, overOrigin),
					        clickImage = createMarkerImage(markerSize, markerOffset, clickOrigin);
					    	
					    // 마커를 생성하고 이미지는 기본 마커 이미지를 사용합니다
					    var marker = new kakao.maps.Marker({
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
		
					    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
					        
					        // 클릭한 위도, 경도 정보를 가져옵니다 
					        latlng = mouseEvent.latLng; 
					        
					        // 마커 위치를 클릭한 위치로 옮깁니다
					        marker.setPosition(latlng);
					        
					        /* console.log(latlng); */
					        $("#lat").val(latlng.getLat());
					        $("#lng").val(latlng.getLng());
					    });
					  
					}
		
					// MakrerImage 객체를 생성하여 반환하는 함수입니다
					function createMarkerImage(markerSize, offset, spriteOrigin) {
					    var markerImage = new kakao.maps.MarkerImage(
					        SPRITE_MARKER_URL, // 스프라이트 마커 이미지 URL
					        markerSize, // 마커의 크기
					        {
					            offset: offset, // 마커 이미지에서의 기준 좌표
					            spriteOrigin: spriteOrigin, // 스트라이프 이미지 중 사용할 영역의 좌상단 좌표
					            spriteSize: spriteImageSize // 스프라이트 이미지의 크기
					        }
					    );
					    
					    return markerImage;
					}
					
					$("div#map").css("z-index", 0);
				</script>
			</div>
</div>
<input type="hidden" id="lat" name="latitude" value="">
<input type="hidden" id="lng" name="longtitude" value="">
<div class="btns">
		<button class="sm-btn" type="submit" style="color: #fff;" >차량등록</button>
		<button class="sm-btn" type="button" onclick="location.href='../admin/sscarlist'" style="color: #fff;">목록</button>
</div>
</form>
</body>
</html>