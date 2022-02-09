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
<form action="insert" method="post">
<input type="hidden" name="ci_num" value="${ci_num}">
  <table class="borderless" style="width: 500px; height: 500px;">
    <tr>
      <td>
        <b>별점</b>
        <select name="rating" class="form-control" style="width: 120px; height: 40px;">
          <option value="0">☆☆☆☆☆</option>
          <option value="1">★☆☆☆☆</option>
          <option value="2">★★☆☆☆</option>
          <option value="3">★★★☆☆</option>
          <option value="4">★★★★☆</option>
          <option value="5">★★★★★</option>
        </select>
      </td>
    </tr>
    
    <tr>
      <td colspan="2" align="center">
        <b>한줄평</b><br><br>
        <input type="text" name="coment" style="width: 500px;" class="form-control" required="required" autofocus="autofocus">
      </td>
    </tr>
   
    <tr>
      <td colspan="2" align="center">
        <button type="submit" class="btn btn-default">등록</button>
      </td>
    </tr>
  </table>
</form>
</body>
</html>