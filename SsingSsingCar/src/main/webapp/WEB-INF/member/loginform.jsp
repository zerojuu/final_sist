<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.loginform-page{
	display: flex;
	justify-content: center;
	margin-top: 100px;
}
.loginform-body{
	display: flex;
	justify-content: center;
}
.loginform-section{
	
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	align-items: center;
	width: 600px;
	height: 550px;	
	margin: 70px 0 20px 0;
	padding: 20px;
}
.loginform-section-header{
	display: flex;
	justify-content: center;
	font-weight: 700;
}

.loginform-section-input{
	width: 500px;
}

.loginform-section-input>input{
	margin-top: 20px;
}

#loginform-section-signup,
#loginform-section-findid{
	color:black;
}

.loginbtn {
	width: 500px;
	height: 45px;
	background-color: #3F5AD4;
	color: white;
}

.loginform-section > hr{
	width: 500px;
}

.loginform-section-other{
	display: flex;
	justify-content: space-around;
	width: 250px;
}

/* modal 창이 회색으로 active 되어서 css로 세팅 */
.modal-backdrop {
    display: none;
    z-index: 1040 !important;
}

.modal-content {
    margin: 250px auto;
    z-index: 1100 !important;
   	
} 
</style>

<script type="text/javascript">
$(function(){
	
	//로그인 버튼 클릭시
	$(".loginbtn").click(loginBtnClick);
	
})




function loginBtnClick(){
	
	var id = $("#id").val();
	var pass = $("#pass").val();
	var save = $("#save").is(":checked");		// 체크시 true : 체크 아닐 시 false
	
	$.ajax({
		
		type:"post",
		//dataType:"text",
		url:"/member/login",
		data:{"id":id,"pass":pass,"save":save},
		success:function(data){
			
			//id, pass 넣지 않은경우
			if(data < 0)
				$("#loginInputModal").modal('show');
			
			//id, pass가 일치하는 경우
			else if(data==1){
				location.href="/";				
				
			}
			//id, pass가 일치하지 않는 경우
			else{
				$("#loginFailModal").modal('show');
				
			}
		}
		
	})
	
}
</script>
</head>
<body>
<!-- 아이디 저장을 체크했을 경우 true : 아니면 null -->
<c:set var="check" value="${sessionScope.save=='true'? 'checked':'' }"/>
<!-- 아이디 저장을 체크했을 경우 id : 아니면 빈값 -->
<c:set var="id" value="${check=='checked'?(sessionScope.id):''}"/>
<div class="loginform-page">
<form action="login" method="post" onsubmit="return false">
<div class="loginform-section">
<h1 class="loginform-section-header">로그인</h1>

<div class="loginform-section-input">
<div style="float: left; margin"><input type="checkbox" name="save" id="save" ${check}> 아이디 저장</div>
<input type="text" name="id" id="id" placeholder="아이디 입력" class="form-control" value="${id }">
<input type="password" name="pass" id="pass" placeholder="비밀번호 입력" class="form-control">
</div>
<br>

<button type="submit" class="btn loginbtn">로그인</button>
<br>
<div class="loginform-section-other">
<a id="loginform-section-findid" href="/member/findidform">아이디 찾기</a>
<a id="loginform-section-signup" href="memberform">회원가입</a>
</div>
<hr>
<div style="color:gray;">간편하게 로그인 하기</div>
<a href="${apiURL }"><img src="https://static.nid.naver.com/oauth/big_g.PNG?version=js-2.0.1" width="250" /></a>

</div>
</form>


<!-- 로그인 실패시 모달 창 -->
  <div class="modal fade" id="loginFailModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
        <h4 class="modal-title">Login</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          
        </div>
        <div class="modal-body">
          <p>아이디 또는 비밀번호가 틀립니다.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn" data-dismiss="modal">확인</button>
        </div>
      </div>
    </div>
  </div>


<!-- 입력 안했을시 모달 창 -->
  <div class="modal fade" id="loginInputModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
        <h4 class="modal-title">Login</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          
        </div>
        <div class="modal-body">
          <p>아이디 또는 비밀번호를 입력해주세요.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn" data-dismiss="modal">확인</button>
        </div>
      </div>
    </div>
  </div>

</div>

</body>

</html>