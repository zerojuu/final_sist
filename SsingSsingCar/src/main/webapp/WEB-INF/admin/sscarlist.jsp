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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.tbl-wrapper{margin-top: 200px;}
.line{margin: auto; width: 800px; margin-top: 0px;}
.sm-menu { width:800px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0;} 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}
th{background: #f8fafd}
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
table.table{

	margin-top:100px;
	margin-left:auto;
	margin-right:auto;
	width: 800px;
}
.modal-backdrop {
    display: none;
    z-index: 1040 !important;
}

.modal-content {
    margin: 250px auto;
    z-index: 1100 !important;
   	
}
#insert_btn{
	cursor:pointer;
	display:inline-block;background:#ffbb12;height:35px;line-height: 35px;font-size: 14px; border-radius:20px;width: 80px;color:#fff; margin-top:10px; margin-bottom:10px;
	-webkit-box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
	-moz-box-shadow: 0 0 5px 1px rgba(0,0,0,.3);
	box-shadow: 0 0 5px 1px rgba(0,0,0,.3);}
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
<div class="tbl-wrapper">
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > ADMIN > <span class="sm-ttl">렌트차량목록</span></div></div>
	<table class="table table-bordered">
		<tr>
			<th rowspan="2" style="text-align: center;">차종</th>
			<th rowspan="2" style="text-align: center;">차량등록 번호</th>
			<th rowspan="2" style="text-align: center;">등급</th>
			<th colspan="2" style="text-align: center;">위치</th>
			<th rowspan="2"></th>
		</tr>
		<tr align="center">
			<th style="text-align: center;">위도</th>
			<th style="text-align: center;">경도</th>
		</tr>
			
			<c:forEach items="${sslist}" var="sdto">
				
					<tr align="center">
						<td>${sdto.ci_num}</td>
						<td>${sdto.car_num}</td>
						<td>${sdto.grade }</td>
						<td>${sdto.latitude }</td>
						<td>${sdto.longtitude}</td>
						<td>
							<a class="mod-btn" style="color: #fff;" onclick="location.href='ssupdateform?car_num=${sdto.car_num}'">수정</a>
							<a class="del-btn" style="color: #fff;" num="${sdto.car_num}">삭제</a>
						</td>
					</tr>
				
			</c:forEach>
			
	</table>

</div>

	<br>
	<a id="insert_btn" onclick="location.href='sscarinfo'">차량등록</a>

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
					data:{"car_num":num,"mem_pass":pass},
					url:"ssdelete",
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


</script>
<script type="text/javascript">
$(document).ready(function(){
	$(".del-btn").hover(function(){$(this).addClass('heartbeat')},
							function(){$(this).removeClass('heartbeat')});
	
})
</script>
</body>
</html>
