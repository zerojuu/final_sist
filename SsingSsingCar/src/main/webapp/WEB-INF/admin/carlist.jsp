Carlist

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
      <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
table{
	margin:auto;
	width: 800px;
}
th{background: #f8fafd}
h3{margin: auto;}

.carlist1{margin-top: 100px;}
.carlist2,.carlist3,.carlist4
{
	margin-top: 55px;
	overflow: auto;
}
.buttons{width:800px; margin-top:100px; height: 100px;}
.buttons .insert-btn{
	cursor:pointer;
	display:inline-block;background:#ffbb12; height: 40px;border-radius:20px; line-height: 38px;font-size: 14px; width: 100px;color:#fff;margin-top:20px; 
	-webkit-box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
	-moz-box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
	box-shadow: 0 0 5px 1px rgba(0,0,0,.3);}
.sm-menu { width:800px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0;} 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}
.mod-btn{
	cursor:pointer;
	display:inline-block;background:#0764d4; height: 25px;border-radius:5px; line-height: 22px;font-size: 8px; width: 40px;color:#fff;
	-webkit-box-shadow: 0 0 1px 1px rgba(0,0,0,.3);
	-moz-box-shadow: 0 0 1px 1px rgba(0,0,0,.3);
	box-shadow: 0 0 1px 1px rgba(0,0,0,.3);}
.del-btn{
	cursor:pointer;
	display:inline-block;background:#ffbb12; height: 25px;border-radius:5px; line-height: 22px;font-size: 8px; width: 40px;color:#fff;
	-webkit-box-shadow: 0 0 1px 1px rgba(0,0,0,.3);
	-moz-box-shadow: 0 0 1px 1px rgba(0,0,0,.3);
	box-shadow: 0 0 1px 1px rgba(0,0,0,.3);}
}
</style>
<style type="text/css">
.modal-backdrop {
    display: none;
    z-index: 1040 !important;
}

.modal-content {
    margin: 250px auto;
    z-index: 1100 !important;
   	
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


</style>
<title>Insert title here</title>
</head>
<body>
<div class="buttons"><a class="insert-btn" style="float: right;  color: #fff;" onclick="location.href='caraddform'">차량 등록하기</a></div>
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > ADMIN > <span class="sm-ttl">차량정보관리</span></div></div>
<div class="carlist1">
<h3 style="color:#0764d4;">경형</h3>
<table class="table table-bordered" style="width:800px;">
	<tr>
		<th rowspan="2" style="text-align: center; vertical-align: middle;">차종</th>
		<th rowspan="2" style="text-align: center; vertical-align: middle;">연료</th>
		<th colspan="2" style="text-align: center;">
			요금
		</th>
		<th rowspan="2" style="text-align: center;"></th>	
	</tr>
	<tr align="center">
		<th style="text-align: center;">1시간</th>
		<th style="text-align: center;">1일(24시간)</th>
	</tr>

<c:forEach items="${list}"  var="dto">
	<c:if test="${dto.car_size=='gh' }">
	<tr align="center">
		<td>${dto.name }</td>
		<td>${dto.type }</td>
		<td><fmt:formatNumber value="${dto.time_price}" type="currency"></fmt:formatNumber></td>
		<td><fmt:formatNumber value="${dto.price}" type="currency"></fmt:formatNumber></td>
		<td>
			<a class="mod-btn" style="color: #fff;" onclick="location.href='updatecarform?ci_num=${dto.ci_num}'">수정</a>
			<a class="del-btn" style="color: #fff;"  num="${dto.ci_num}">삭제</a>
		</td>
	</tr>
	</c:if>
</c:forEach>
</table>
</div>

<div class="carlist2">
<h3 style="color:#0764d4;">소형</h3>
<table class="table table-bordered" style="width:800px;">

	<tr>
		<th rowspan="2" style="text-align: center; vertical-align: middle;">차종</th>
		<th rowspan="2" style="text-align: center; vertical-align: middle;">연료</th>
		<th colspan="2" style="text-align: center;">
			요금
		</th>
		<th rowspan="2" style="text-align: center;"></th>	
	</tr>
	<tr align="center">
		<th style="text-align: center;">1시간</th>
		<th style="text-align: center;">1일(24시간)</th>
	</tr>
	<c:forEach items="${list}" var="dto">
		<c:if test="${dto.car_size=='sh' }">
		<tr align="center">
			<td>${dto.name }</td>
			<td>${dto.type }</td>
			<td><fmt:formatNumber value="${dto.time_price}" type="currency"></fmt:formatNumber></td>
			<td><fmt:formatNumber value="${dto.price}" type="currency"></fmt:formatNumber></td>
			<td>
				<a class="mod-btn" style="color: #fff;" onclick="location.href='updatecarform?ci_num=${dto.ci_num}'">수정</a>
				<a class="del-btn" style="color: #fff;"  num="${dto.ci_num}">삭제</a>
			</td>
		</tr>
		</c:if>
	</c:forEach>
</table>
</div>

<div class="carlist3">
<h3 style="color:#0764d4;">중형</h3>
<table class="table table-bordered" style="width:800px;">

	<tr>
		<th rowspan="2" style="text-align: center; vertical-align: middle;">차종</th>
		<th rowspan="2" style="text-align: center; vertical-align: middle;">연료</th>
		<th colspan="2" style="text-align: center;">
			요금
		</th>
		<th rowspan="2" style="text-align: center;"></th>	
	</tr>
	<tr align="center">
		<th style="text-align: center;">1시간</th>
		<th style="text-align: center;">1일(24시간)</th>
	</tr>
	<c:forEach items="${list}" var="dto">
		<c:if test="${dto.car_size=='jh' }">
		<tr align="center">
			<td>${dto.name }</td>
			<td>${dto.type }</td>
			<td><fmt:formatNumber value="${dto.time_price}" type="currency"></fmt:formatNumber></td>
			<td><fmt:formatNumber value="${dto.price}" type="currency"></fmt:formatNumber></td>
			<td>
				<a class="mod-btn" style="color: #fff;" onclick="location.href='updatecarform?ci_num=${dto.ci_num}'">수정</a>
				<a class="del-btn" style="color: #fff;"  num="${dto.ci_num}">삭제</a>
			</td>
		</tr>
		</c:if>
	</c:forEach>
</table>
</div>

<div class="carlist4">
<h3 style="color:#0764d4;" >대형</h3>
<table class="table table-bordered" style="width:800px;">

	<tr>
		<th rowspan="2" style="text-align: center; vertical-align: middle;">차종</th>
		<th rowspan="2" style="text-align: center; vertical-align: middle;">연료</th>
		<th colspan="2" style="text-align: center;">
			요금
		</th>
		<th rowspan="2" style="text-align: center;"></th>	
	</tr>
	<tr align="center">
		<th style="text-align: center;">1시간</th>
		<th style="text-align: center;">1일(24시간)</th>
	</tr>
	<c:forEach items="${list}" var="dto">
		<c:if test="${dto.car_size=='dh' }">
		<tr align="center">
			<td>${dto.name }</td>
			<td>${dto.type }</td>
			<td><fmt:formatNumber value="${dto.time_price}" type="currency"></fmt:formatNumber></td>
			<td><fmt:formatNumber value="${dto.price}" type="currency"></fmt:formatNumber></td>
			<td>
				<a class="mod-btn" style="color: #fff;" onclick="location.href='updatecarform?ci_num=${dto.ci_num}'">수정</a>
				<a class="del-btn" style="color: #fff;" num="${dto.ci_num}"<%-- onclick="location.href='deletecar?ci_num=${dto.ci_num}'" --%>>삭제</a>
			</td>
		</tr>
		</c:if>
	</c:forEach>
</table>
</div>

<div class="modal fade" id="deleteCheckModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
        <h4 class="modal-title">password</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          
        </div>
        <div class="modal-body">
        	 <input type="hidden" id="delnum">
        	<input type="password" id="mem_pass" name="mem_pass">
        </div>
        <div class="modal-footer">
          <button type="submit" id="chkbtn" class="btn btn-default delbtn" data-dismiss="modal">확인</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" >닫기</button>
        </div>
      </div>
    </div>
  </div>

<script type="text/javascript">
$("a.del-btn").click(function()
		{
			var num = $(this).attr("num");
			$("#delnum").val(num);
			$("#deleteCheckModal").modal();
			
			$("#chkbtn").click(function()
			{
				var num = $("#delnum").val();
				var pass = $("#mem_pass").val();
				
				$.ajax
				({
					type:"get",
					dataType:"json",
					data:{"ci_num":num,"mem_pass":pass},
					url:"deletecar",
					success:function(data)
					{	
						if(data.check==1)
						{	//비밀번호가 일치한 경우 현재페이지 새로고침
							location.reload();
						}
						else
						{
							alert("비밀번호가 일치하지 않습니다");
						}
					}
				})
			});
			
		});

$(document).ready(function(){
	$(".del-btn").hover(function(){$(this).addClass('heartbeat')},
							function(){$(this).removeClass('heartbeat')});
	
})
</script>

</body>
</html>
