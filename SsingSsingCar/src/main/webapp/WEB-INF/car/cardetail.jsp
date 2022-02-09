<%@page import="com.data.dto.SsCarDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<!-- MAP API -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${api_key}&libraries=services"></script>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
.bg-container{
	margin-top: 45px;
	background: url(../mainimg/tit_bg_new.png) no-repeat;
	background-position: center;
	height: 200px;
}
.carphoto img{
	width:450px;
	height: 250px;
	margin-left: 125px;
	margin-top: 50px;
	margin-bottom: 50px;
	margin-right: 125px;
}
.addr{margin-top: 50px;}
.addr .div-ttl{
	font-weight: 700;
}

th{
	background: #f8fafd
}

.tbl-pos tr:hover{
	background-color: #65bafe;
	
}
.heartbeat {
	animation: heartbeat 1.5s ease-in-out infinite both;
}
@keyframes heartbeat {
  from {
    transform: scale(1);
    transform-origin: center center;
    animation-timing-function: ease-out;
  }
  10% {
    transform: scale(0.91);
    animation-timing-function: ease-in;
  }
  17% {
    transform: scale(0.98);
    animation-timing-function: ease-out;
  }
  33% {
    transform: scale(0.87);
    animation-timing-function: ease-in;
  }
  45% {
    transform: scale(1);
    animation-timing-function: ease-out;
  }
}

.tbl-wrapper{margin-top:150px;}
.tbl-info {
	border: 1px solid white;
	margin: auto;
}
.tbl-pos{width: 800px; }
.tbl-pos th{ border-top: 1px solid #0764d4; height: 40px;}
.tbl-pos tr{ border-bottom: 1px solid #EAEAEA;}
.caption h3{font-weight: 700; font-size:28px;}
.caption  span{color:#0764d4; font-size:14px; border-radius:20px; border:1px solid #0764d4; padding:2px 5px; margin-right:5px; font-weight:400;}
#reserve_btn {
	cursor:pointer;
	display:inline-block;background: #0764d4;height:35px;line-height: 35px;font-size: 14px; border-radius:20px;width: 80px;color:#fff; margin-top:10px; margin-bottom:10px;
	-webkit-box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
	-moz-box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
	box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
}
.box{margin: 0 ; padding: 0px; height: 350px; width: 700px;}
.carbg{z-index: 1; position: absolute;}
.carphoto{z-index: 2; position: absolute;}
.sm-menu {  width:1000px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0;} 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}
</style>
<title>Insert title here</title>
</head>
<body>
 <input type="hidden" name="ci_num" value="${ci_num}">
<div class="bg-container"></div>
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > 렌트 > <span class="sm-ttl">차량상세보기</span></div></div>
<div class="tbl-wrapper">
<table class="tbl-info">
	<tr>
		<td align="center">
			<div class="box">
				<div class="carbg">
					<img alt="" src="../carphoto/carbg.png">	
				</div>
				<div class="carphoto">	
					<img alt="" src="../carphoto/${dto.photo}" >
				</div>
			</div>
			<br>
			
			<div class="caption">
				<c:if test="${dto.car_size=='gh'}"><h3>${dto.name} <span>경형</span></h3></c:if>
				<c:if test="${dto.car_size=='sh'}"><h3>${dto.name} <span>소형</span></h3></c:if>
				<c:if test="${dto.car_size=='jh'}"><h3>${dto.name} <span>중형</span></h3></c:if>
				<c:if test="${dto.car_size=='dh'}"><h3>${dto.name} <span>대형</span></h3></c:if>
			</div>
		</td>
	</tr>
</table>
<div class="addr">
<h4 style="color: gray;">렌트 가능 차량</h4>
<% List<SsCarDto> s =(List<SsCarDto>)request.getAttribute("slist");
%>
<table class="tbl-pos">
<tr>
	<th  style="text-align: center;">차량 등록번호</th>
	<th  style="text-align: center;">차량 등급</th>
	<th  style="text-align: center;">렌트 위치</th>
	<th></th>
</tr>
<% for(int i=0;i<s.size() ;i++){%>
<tr  align="center">
	<td>
		<%=s.get(i).getCar_num() %>
	</td>
	<td>
		<%=s.get(i).getGrade() %>
	</td>
	<td id="addr<%=i %>">
	</td>
	<td>
		<div class="resv">
			<a id="reserve_btn" onclick="location.href='../rent/rentForm?car_num=<%=s.get(i).getCar_num() %>'">
				예약하기	
			</a>
		</div>
	</td>
</tr>
<%} %>
</table>
</div>
</div>

<script type="text/javascript">
var lat1= ${ latitude_list };
addrArray = new Array();

for (var i = 0; i < lat1.length; i++) {
	(function(i){
		var lat= ${ latitude_list },
			lon= ${ longtitude_list};
		
		$.ajax({
	
				url: 'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=' + lon[i] +'&y=' + lat[i],
				headers:{ 'Authorization': 'KakaoAK b72e41eb28a5d11141c3396ddb96e0b7'},
				type:'GET',
				async: false,
				success :function(data){

				  		h = data.documents[0].address.address_name;
						 addrArray[i]=h; 
				 
						 }		
			
		})

		return addrArray[i];
	})
(i)
}

for (var i = 0; i < lat1.length; i++) {
	$("#addr"+i).append(addrArray[i]);
}


</script>
<script type="text/javascript">
$(document).ready(function(){
	$("div.resv").hover(function(){$(this).addClass('heartbeat')},
							function(){$(this).removeClass('heartbeat')});
	
})
</script>
</body>
</html>