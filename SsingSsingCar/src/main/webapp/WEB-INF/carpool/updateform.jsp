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
</style>
  
</head>
<body>
<br><br><br><br>
<form action="update" method="post">
<!-- hidden -->
<input type="hidden" name="cp_num" value="${dto.cp_num }">
<input type="hidden" name="currentPage" value="${currentPage }">

  <table class="borderless" style="width: 700px; height: 500px;">
    <tr>
      <td align="left">
        <select name="type" class="form-control" style="width: 100px; height: 40px;">
          <option value="출퇴근">출퇴근</option>
          <option value="명절">명절</option>
          <option value="여행,레저">여행,레저</option>
          <option value="제주도">제주도</option>
        </select>
      </td>
    </tr>
    
    <tr>
      <td colspan="3" align="center">
        <b>제목</b><br><br>
        <input type="text" name="subject" style="width: 500px;" class="form-control" required="required" autofocus="autofocus" value="${dto.subject }">
      </td>
    </tr>

    <tr>
      <td colspan="3" align="center">
        <b>내용</b><br><br>
        <textarea style="width: 500px; height: 300px;" name="content" class="form-control" required="required">${dto.content}</textarea>         
      </td>
    </tr>
    
    <tr>
      <td colspan="3" align="center">
        <button type="submit" class="btn btn-default">수정</button>
      </td>
    </tr>
  </table>
</form>
</body>
</html>