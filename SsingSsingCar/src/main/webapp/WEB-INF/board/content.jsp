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
}
button {
	text-align: center;
}
</style>

</head>
<body>
<br><br>
<h1 align="center">공지사항</h1>
<br><br><br>

<table class="table" style="width: 1100px;">
  <tr>
    <td>
      <b>${dto.subject }</b>
      <hr>
      <br>
      <pre>${dto.content }</pre>
      <br>
      <p style="float: right;"><fmt:formatDate value="${dto.writeday }" pattern="yyyy-MM-dd"/></p>
    <br>
    <button type="button" class="btn btn-big btn-default" onclick="location.href='list?currentPage=${currentPage}'">목록</button>
    <!-- admin으로 로그인할 때만 수정,삭제 버튼 -->
<c:if test="${sessionScope!=null and sessionScope.id == 'admin'}">
  <button type="button" class="btn btn-default" onclick="location.href='updateform?board_num=${dto.board_num}&currentPage=${currentPage}'">수정</button> 
  <button type="button" class="btn btn-default" onclick="location.href='delete?board_num=${dto.board_num}&currentPage=${currentPage}'">삭제</button>
</c:if>
    </td>
  </tr>
</table> 
</body>
</html>