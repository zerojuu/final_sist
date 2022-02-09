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
    line-height: 35px;
}
th, td {
  border-bottom: 1px solid #ddd;
}
.sm-menu {  width:1000px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0; } 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}
</style>
</head>
<body>
<br><br><br><br><br>
<div id="wrapper"">
<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > 커뮤니티 > <span class="sm-ttl">공지사항</span></div></div>
<br><br><br>
 
<table style="width: 1000px; text-align: center; font-size: 1.2em;">   
  <tr style="margin-left: auto; margin-right: auto;">
    <th width="100" style="text-align: center; font-size: 1.1em; color: #778899;">번호</th>
    <th style="text-align: center; font-size: 1.1em; color: #778899;">제목</th>
    <th width="200" style="text-align: center; font-size: 1.1em; color: #778899;">등록일</th>
  </tr>
  
  <c:if test="${totalCount==0 }">
    <tr>
      <td colspan="3" align="center">
        <h4>등록된 공지사항이 없습니다</h4>
      </td>
    </tr>
  </c:if>
  
  <c:if test="${totalCount>0 }">
    <c:forEach var="a" items="${list }">          
      <tr style="height: 20px;">
        <td>${a.board_num }</td>
        <td>
          <a style="color: black;" href="content?board_num=${a.board_num}&currentPage=${currentPage}">${a.subject }</a>
        </td>
        <td>
          <fmt:formatDate value="${a.writeday }" pattern="yyyy-MM-dd"/>
        </td>
      </tr>
    </c:forEach>
  </c:if>
  
    <!-- admin으로 로그인한 경우에만 작성 버튼 나타남 -->
 <c:if test="${sessionScope!=null and sessionScope.id == 'admin'}">
   <tr>
     <td colspan="3" align="right">
     <button type="button" class="btn btn-default" onclick="location.href='form'">작성</button>
     </td>
   </tr>
 </c:if>
</table>
    
<!-- 페이징 처리 -->
<c:if test="${totalCount>0}">
	<div style="width: 100px; text-align: center;" class="paging">
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
</div>
</body>
</html>