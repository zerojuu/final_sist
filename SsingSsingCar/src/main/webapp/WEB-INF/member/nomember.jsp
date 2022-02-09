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
	
	$("#notFindMemberModal").modal();
	//모달 없어지면 해당 url로 이동
	$("#notFindMemberModal").on('hidden.bs.modal',function(){
		
		history.back();
	});
})

</script>

</head>
<body>
<!-- 아이디 없음 모달 창 -->
<div class="modal fade" id="notFindMemberModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
        <h4 class="modal-title">아이디 찾기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          
        </div>
        <div class="modal-body">
          <p><b>해당 정보를 갖는 회원이 없습니다.</b><br><br>
          다시 확인 후 입력 바랍니다.
          </p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn" data-dismiss="modal">확인</button>
        </div>
      </div>
    </div>
  </div>
  
</body>
</html>