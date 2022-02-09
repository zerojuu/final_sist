<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
table{
    margin-left: auto;
    margin-right: auto;
    font-size: 1.1em;
}
</style>

<script type="text/javascript">
$(function() {
	
	cp_num=$("#cp_num").val();
	loginok="${sessionScope.loginok}";
	myid="${sessionScope.id}";
	
	list();
	

	//버튼 클릭시 insert
	$("#btnansweradd").click(function() {
	var coment=$("#coment").val();
	
	if(coment.trim().length==0){
		alert("댓글을 입력해주세요");
		return;
	}
	
	$.ajax({
		type:"post",
		url:"ainsert",
		data:{"cp_num":cp_num,"coment":coment},
		success:function(data){
			list();
		}
	});
});
	
	//댓글삭제
	$(document).on("click","span.adel",function(){
		
		var ca_num=$(this).attr("ca_num");
		var a=confirm("해당 댓글을 삭제할까요?");
		
		if(a==true){
			$.ajax({
				type:"get",
				url:"adelete",
				data:{"ca_num":ca_num},
				success:
					function(data) {
						list();
					}
			});
		}
	});
	
	
	//수정 다이얼로그
	$(document).on("click","span.amod",function(){
		var ca_num=$(this).attr("ca_num");
		
		$.ajax({
			type:"get",
			dataType:"json",
			url:"adata",
			data:{"ca_num":ca_num},
			success:
				function(data) {
					$("#ucoment").val(data.coment);
				}
		});
		$("#myModal").modal();
	});
	
	//수정
	$(document).on("click","#btnaupdate",function(){
		
		var content=$("#ucoment").val();
		
		$.ajax({
			type:"post",
			dataType:"text",
			url:"aupdate",
			data:{"ca_num":ca_num,"coment":coment},
			success:
				function(data) {
					list();
				}
		});
	});
});

//리스트 ajax
function list() {
	$.ajax({
		type:"get",
		dataType:"json",
		url:"alist",
		data:{"cp_num":cp_num},
		success:function(data){
			
			$("span.acount").text(data.length);  //댓글 개수
			
			var s="";
			$.each(data, function(i,dto) {
				s+="<br>";
				s+="<b><span class='glyphicon glyphicon-user'></span>"+dto.name+"</b>&nbsp;&nbsp;&nbsp;"+dto.coment;
				s+="&nbsp;&nbsp;<span class='day'>("+dto.answerday+")</span>";
				
				//본인 글만 수정,삭제 가능
				if (loginok!=null && myid==dto.myid) {
					s+="&nbsp;&nbsp;<span class='glyphicon glyphicon-pencil amod' style='color: red;' ca_num='"+dto.ca_num+"'></span>&nbsp;";
					s+="<span class='glyphicon glyphicon-trash adel' style='color: red;' ca_num='"+dto.ca_num+"'></span>";
				}
				s+="<br>";
			});
			
			$("div.alist").html(s);
		}
	});
}
</script>
</head>
<body>
<br><br>
<h1 align="center">Carpool</h1>
<br><br><br>
<table class="table" style="width: 1100px;">
  <tr>
    <td style="background: #f0f8ff;"><b>[${dto.type}]</b>  ${dto.subject }</td>
  </tr> 
  <tr>
    <td>
      <pre style="height: 150px; background-color: white; border: 0px; font-size: 1.1em;">${dto.content }</pre>
    </td>
  </tr>
  <tr>
    <td>${dto.name }  (<fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd HH:mm"/>)</td>

  </tr>
  
<!-- 댓글 -->
   <tr>
   <td>
   <b>조회 ${dto.readcount}&nbsp;&nbsp;|&nbsp;&nbsp;댓글 <span class="acount"></span></b>
     <div class="alist"></div>
<input type="hidden" id="cp_num" value="${dto.cp_num }">
      <br>
      <c:if test="${sessionScope.loginok!=null }">
        <div class="aform">
          <div class="form-inline">
            <input type="text" class="form-control" style="width: 400px;" id="coment">&nbsp;&nbsp;
            <button type="button" class="btn btn-default btn-sm" style="width: 40px; text-align: center;" id="btnansweradd">등록</button>
          </div>
        </div>
      </c:if>
   </td> 
  </tr>
  
  <!-- 버튼..로그인중이며 본인글일 때만 가능 -->
  <tr>
    <td align="center">
      <c:if test="${sessionScope.loginok!=null }">
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='form'">작성</button>
      </c:if>
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='list?currentPage=${currentPage}'">목록</button>
      <c:if test="${sessionScope.loginok!=null and sessionScope.id==dto.myid }">
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='updateform?cp_num=${dto.cp_num}&currentPage=${currentPage}'">수정</button>
        <button type="button" class="btn btn-default" style="width: 100px;" onclick="location.href='delete?cp_num=${dto.cp_num}&currentPage=${currentPage}'">삭제</button>
      </c:if>
    </td>
  </tr> 
</table>

<!-- 댓글 수정 Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">댓글</h4>
      </div>
      <div class="modal-body">
        <input type="text" id="ucoment" class="form-control">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnaupdate">수정</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>