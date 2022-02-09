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
th {
	text-align: center;
}
button {
  background-color: white;
  color: black;
  border: 2px solid #4CAF50; /* Green */
}
.sm-menu {  width:1000px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0; } 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}
</style>
</head>
<body>
<br><br><br><br><br>
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > 커뮤니티 > <span class="sm-ttl">Carpool</span></div></div>
<br><br><br>

 <select onchange="if(this.value) location.href=(this.value);" style="width: 80px; height: 30px; text-align: center; margin-right: 900px;">
   <option>전체</option>
   <option value="출퇴근">출퇴근</option>
   <option value="명절">명절</option>
   <option value="여행,레저">여행,레저</option>
   <option value="제주도">제주도</option>
 </select> 
 <br><br>

<table class="table table-hover" style="width: 1000px;">
  <tr>
    <th width="100" style="text-align: center;">번호</th>
    <th width="200" style="text-align: center;">분야</th>
    <th style="text-align: center;">내용</th>
    <th width="150" style="text-align: center;">작성자</th>
    <th width="150" style="text-align: center;">작성일</th>
  </tr>
  
  <c:if test="${totalCount==0 }">
    <tr>
      <td colspan="5" align="center">
        <h4>등록된 글이 없습니다</h4>
      </td>
    </tr>
  </c:if>
  
  <c:if test="${totalCount>0}">
    <c:forEach var="c" items="${list }">
      <tr>
        <td align="center">${c.cp_num }</td>
        <td align="center">${c.type }</td>
        <td align="center"><a href="content?cp_num=${c.cp_num}&currentPage=${currentPage}">${c.subject }</a>
        <!-- 댓글개수 -->
          <c:if test="${c.acount>0 }">
            <a style="color: red;" href="content?cp_num=${c.cp_num}&currentPage=${currentPage}">[${c.acount}]</a>
          </c:if>
        </td>
        <td align="center">${c.name}</td>
        <td align="center"><fmt:formatDate value="${c.writeday }" pattern="yyyy-MM-dd"/></td>
      </tr>
    </c:forEach>
  </c:if>
  
  <tr>
    <td align="right" colspan="5">
      <c:if test="${sessionScope.loginok!=null }">
        <button type="button" class="btn" style="width: 80px;" onclick="location.href='form'">작성</button>
      </c:if>
    </td>
  </tr>  
</table>

<!-- 페이징 처리 -->
<c:if test="${totalCount>0}">
	<div style="width: 100px; text-align: center;" class="container">
  		<ul class="pagination">
  			 <!-- 이전 -->
				<c:if test="${startPage>1}">
				<li><a href="list?currentPage=${startPage-1}">이전</a></li>
				</c:if>
			
   			<c:forEach var="pp" begin="${startPage}" end="${endPage}">
				<c:if test="${currentPage==pp}">
					<li class="active"><a href="list?currentPage=${pp}">${pp}</a></li>
				</c:if>
				<c:if test="${currentPage!=pp}">
					<li><a href="list?currentPage=${pp}">${pp}</a></li>
				</c:if>
			</c:forEach>
   
	    	<!-- 다음 -->
			<c:if test="${endPage<totalPage}">
				<li><a href="list?currentPage=${endPage+1}">다음</a></li>
			</c:if>
      </ul>
  </div>
</c:if>
</body>
</html>