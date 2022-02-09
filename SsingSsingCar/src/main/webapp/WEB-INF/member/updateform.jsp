<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
	/* 중복아이디 존재하지 않는경우 */
	.id_input_re_1{
		color : green;
		display : none;
	}
	/* 중복아이디 존재하는 경우 */
	.id_input_re_2{
		color : red;
		display : none;
	}
	

div.box{
position:absolute;
}
</style>

<title>Insert title here</title>
</head>

<script type="text/javascript">
//비밀번호 체크
function check_pw(){
	 
    var pw = document.getElementById('pw').value;
    var SC = ["!","@","#","$","%"];
    var check_SC = 0;

/*     if(pw.length < 6 || pw.length>16){
        window.alert('비밀번호는 6글자 이상, 16글자 이하만 이용 가능합니다.');
        document.getElementById('pw').value='';
    }
    for(var i=0;i<SC.length;i++){
        if(pw.indexOf(SC[i]) != -1){
            check_SC = 1;
        }
    }
    if(check_SC == 0){
        window.alert('!,@,#,$,% 의 특수문자가 들어가 있지 않습니다.')
        document.getElementById('pw').value='';
    } */
    if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){
        if(document.getElementById('pw').value==document.getElementById('pw2').value){
            document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
            document.getElementById('check').style.color='blue';
        }
        else{
            document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
            document.getElementById('check').style.color='red';
            return false;
        }
    }
}

//이메일 정규식 체크
function email_check( email ) {    
    var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    return (email != '' && email != 'undefined' && regex.test(email)); 
}

function checkEmail(){
	var email = $('#mail').val();
	console.log(email);
	  if( email == '' || email == 'undefined') return;
	  if(! email_check(email) ) {
	  	$(".result-email").html("<font color='red'>이메일 형식으로 적어주세요</font>");
	    $(this).focus();
	    return false;
	  }else {
		$(".result-email").text('');
	  }
}
</script>
<body>
<div align="center" id="box">
<form action="update" method="post" style="width: 600px;">
<h2>회원정보 수정</h2>
  <input type="hidden" name="mem_num" value="${mem_num }">
  <input type="text" readonly="readonly" class="form-control" name="mem_name" 
  value="${dto.mem_name }" style="margin-top: 20px;" required="required">
  <input type="text" class="form-control" name="mem_id" id="id" readonly="readonly"
  value="${dto.mem_id}" style="margin-top: 20px;" required="required" maxlength="8">
  <b class="idmsg"></b>
  <input type="email" class="form-control" name="mem_email" id="mail" onkeyup="checkEmail()"
  value="${dto.mem_email }" style="margin-top: 20px;" required="required">
  <b><div id="error_mail" class="result-email result-check"></div></b>
  <input type="text" class="form-control" name="mem_hp"
  value="${dto.mem_hp }" style="margin-top: 20px;" required="required">
  <input type="password" class="form-control" name="mem_pass" id="pw" onchange="check_pw()"
  placeholder="비밀번호" style="margin-top: 20px;" required="required">
  <input type="password" class="form-control" name="mem_pass2" id="pw2" onchange="check_pw()"
  placeholder="비밀번호 확인" style="margin-top: 20px;" required="required">
  &nbsp;&nbsp;<b><span id="check"></span></b>
  <button type="submit" class="btn btn-info" style="margin-top: 30px; width: 600px;">수정</button>
</form>

</div>
</body>
</html>