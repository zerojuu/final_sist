<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=Gaegu&family=Gugi&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
function calprice(){
	tprice = $("#tprice").val();
	dprice = (tprice * 24)/1.5;
	/* alert(dprice); */
	$("#dprice").val(dprice);
}
</script>
<title>Insert title here</title>
</head>
<body>
<form action="update" method="post" enctype="multipart/form-data">
<table class="table table-bordered" style="margin-top: 100px; width: 800px;">
	<tr>
		<th>차종</th>
		<td>
			<input type="hidden" name="ci_num" value="${dto.ci_num}">
			<input type="text" name="name" class="form-control" value="${dto.name}">
		</td>
	</tr>
	<tr>
		<th>연식</th>
		<td>
			<input type="text" name="year" class="form-control" value="${dto.year}">
		</td>
	</tr>
	<tr>
		<th>연료</th>
		<td>
			<input type="text" name="type" class="form-control" value="${dto.type}"> 
		</td>
	</tr>
	<tr>
		<th>사진</th>
		<td>
			<input type="file" name="upload" class="form-control">
		</td>
	</tr>
	<tr>
		<th>시간당 요금</th>
		<td>
			<input type="text" name="time_price" id="tprice" class="form-control" value="${dto.time_price }">
			<input type="hidden" name="price" id="dprice" value="">
		</td>
	</tr>
	<tr>
		<th>분류</th>
		<td>
			<select name="car_size" class="form-control" >
				<option value="gh">경형</option>
				<option value="sh">소형</option>
				<option value="jh">중형</option>
				<option value="dh">대형</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="submit" class="btn btn-default" onclick="return calprice();">수정하기</button>
		</td>
	</tr>
	</table>
</form>
</body>
</html>
