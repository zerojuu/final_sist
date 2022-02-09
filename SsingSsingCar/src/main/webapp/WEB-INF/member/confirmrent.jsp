<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href='${ pageContext.request.contextPath }/calendar/main.css' rel='stylesheet' />
<script src='${ pageContext.request.contextPath }/calendar/main.js'></script>

<style type="text/css">
.confirmrent-page{
	display: flex;
	flex-direction:column;
	align-items: center;
	margin-top: 100px;
}

.confirmrent-title{
	
	font-weight: 700;
	margin-bottom: 70px;
}

.confirmrent-back{
 	width: 1000px; 
 	display: flex;
 	justify-content: space-between;
 
}
.confirmrent-back > .btn{
 	background-color: #3F5AD4;
 	color:white;
}

.confirmrent-table{
	width: 1000px;
	text-align: center;
	margin: 20px 0 20px 0;
}
.confirmrent-subtitle,
.confirmrent-content {
	width:500px;
	
}

.confirmrent-subtitle{
	font-weight:700;
	color:black;
	background-color: #E6E6E6;
	height: 40px;
}

.confirmrent-content {
	padding-top: 10px;
	padding-bottom: 20px;
	font-size: 1.3em;
	
}

.confirmrent-info{
	font-size:0.7em;
	margin-top: 70px;
}


#calendar {
    max-width: 510px;
    max-height: 380px;
    margin: 20px;
    
 }
 
 .sm-menu {  width:1000px; font-weight: 500; color: gray; margin-bottom: 0px; height: 18px; border-bottom: 1px solid #B0B0B0;} 
.sm-menu .ttl{float: left; font-size: 12px;}
.sm-menu .sm-ttl{ color:#0764d4}

</style>

<script>

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: '',
        center: 'title',
        right: 'prev,next'
      },
      selectable: true,
      editable:true,
      initialDate: '${list.startDay}',
      
      
      //이벤트 날짜가 적용이 안됨, background color로 적용
      /* events: [
        {
          "start": "2021-11-11",
          "end": "2021-11-15",
          "display": "background",
          "color": "#ff9f89"
        },
        {
        	"title":"test2",
          "start": "2021-11-24",
          "end": "2021-11-28"
        }
    ], */
      
     
      // 날짜 클릭시 색깔 바뀌게 (예약 수정시 사용할 예정)
      dateClick:function(info){
    	  //console.log(info);
    	  console.log("click day: "+info.dateStr);
    	  var clickEl = info.dayEl;
    	  console.log(clickEl);
    	
    	  $(clickEl).attr("bgColor", "#74b9ff");	 	//$(clickEl).css("background", "#74b9ff")
    	  
    	  var str = calendar.formatDate(info.dateStr,{
    	  	  
    	  	  month:'long',
    	  	  year:'numeric',
    	  	  day:'numeric',
    	  	  timeZomeName:'short',
    	  	  timeZone:'local',
    	  	  locale:'us'
    	    })
    	  
    	 //console.log(str);
      },
      
      
   	// 날짜 드래그시 색깔 바뀌게 (예약 수정시 사용할 예정?)
      select:function(arg){
    	 
    	 	console.log(arg.start+","+arg.end+","+arg.allDay);
    	 	
    	 	//console.log(arg.view);
    	 	/* calendar.addEvent({
    	 		
    	 		title:"testttt",
    	 		start: arg.start,
    	 		end: arg.end,
    	 		allDay: arg.allDay,
    	 		
    	 	}); */
    	 	
    	 	var date1 = new Date(arg.startStr);
    	 	var date2 = new Date(arg.endStr);
    	 	var endDate = getFormatDate(date2);
    	 	var day = getInterval(date1, date2);
    	 	console.log(date1);
    	 	console.log("총 예약한 날: "+ day);
    	 	
    	 	for(var i = 0; i < day; i++){
    	 		
    	 		var date = getFormatDate(date1);
    	 		var el1 = $("[data-date="+date+"]");
    	 		$(el1).attr("bgColor","red");
    	 		date1.setDate(date1.getDate()+1);
    	 	}
    	 	    	 	
      },
      
   	//있는 일정 클릭시 삭제
      eventClick: function(arg) { 
    	  console.log("#등록된 일정 클릭#"); 
      console.log(arg.event); 
      if (confirm('Are you sure you want to delete this event?')) 
      { arg.event.remove() } 
      }

     
    });
  
    calendar.render();
    
    
    //예약 날짜 받아와서 뿌려주기
    var startDay = new Date("${list.startDay}");
    var endDay = new Date("${list.endDay}");
    
   	setCalendarBgColor(startDay,endDay);

   	//이전, 다음달 버튼 누르면 bgColor 받아와야됨
   	$(".fc-toolbar-chunk button").on('click',function(){
   		setCalendarBgColor(startDay,endDay);
   		
   	}) 
    
  });
  


  
//시작 날짜~끝 날짜 색칠하기
function setCalendarBgColor(dateStart, dateEnd){
	
	var start = new Date(dateStart);
	var end = new Date(dateEnd);
	var day = getInterval(start, end);
	console.log("총 예약한 날: "+ day);
 	
 	for(var i = 0; i <= day; i++){
 		
 		var date = getFormatDate(start);
 		var el1 = $("td[data-date='"+date+"']");
 		$(el1).attr("bgColor","#3F5AD4");
 		$(el1).css("color","white");
 		start.setDate(start.getDate()+1);
 	} 	
}

// yyyy-MM-dd 형식으로 만들기
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

// start~end 까지 몇일인지 구하기
function getInterval(start, end){
	
	var interval;

	interval = end.getTime()-start.getTime();
	
	return Math.floor(interval / (1000*60*60*24));
}
</script>


</script>
</head>
<body>
	
	<div class="confirmrent-page">

	
	<h2 class="confirmrent-title">예약 상세 정보</h2>
	
	<div class="sm-menu"><div class="ttl"><span class="glyphicon glyphicon-home"></span> > 사용자 > <span class="sm-ttl">My 예약</span></div></div>
	<br>
	
	<div class="confirmrent-back">
	<button class="btn" onclick="history.back()"><span class="glyphicon glyphicon-chevron-left"></span></button>
	<button class="btn" onclick="window.print()"><span class="glyphicon glyphicon-print"></span></button>
	</div>
	<table class="confirmrent-table">
	<tr>
	<td class="confirmrent-subtitle">예약자 이름</td>
	<td class="confirmrent-subtitle">예약자 핸드폰</td>
	<td class="confirmrent-subtitle">예약자 이메일</td>
	
	</tr>
	<tr>
	<td class="confirmrent-content">${list.mem_name }</td>
	<td class="confirmrent-content">${list.mem_hp }</td>
	<td class="confirmrent-content">${list.mem_email }</td>
	</tr>
	</table>
	<hr width="1000">
	<table class="confirmrent-table">
	<tr>
	<td rowspan="5"><img alt="" src="/carphoto/${list.photo }" style="width: 400px;"></td>
	<td class="confirmrent-subtitle">차량명</td>
	<td class="confirmrent-subtitle">연식</td>
	<td class="confirmrent-subtitle">등급</td>
	</tr>
	<tr>
	
	<td class="confirmrent-content">${list.name }</td>
	<td class="confirmrent-content">${list.year }</td>
	<td class="confirmrent-content">${list.grade }</td>
	
	</tr>
	<tr>
	<td class="confirmrent-subtitle" >연료</td>
	<td class="confirmrent-subtitle" colspan="2">총 요금</td>
	</tr>
	<tr>
	<td class="confirmrent-content">${list.type }</td>
	<td class="confirmrent-content" colspan="2">
	<fmt:formatNumber value="${list.total_price}" type="currency"/>
	</td>
	</tr>
	<tr>
	<td class="confirmrent-content" colspan="3">
	<div class="confirmrent-info">차량대여 중 발생하는 귀책사유로 인한 당사 차량손해(손, 망실)는 고객님께서 차량 수리비를 지불하셔야 합니다. 단, 자차손해 면책제도(CDW)에 가입하시면 자차 사고에 대한 보호를 받으실 수 있습니다.</div>
	</td>
	</tr>
	
	</table>
	<hr width="1000">
	<table class="confirmrent-table">
	<tr>
	<td class="confirmrent-subtitle">대여 / 반납일</td>
	<td rowspan="2"><div id="calendar"></div></td>
	</tr>
	<tr>
	<td class="confirmrent-content">
	대여 : <span id="startDay">${list.startDay}</span> ${list.startTime }<br>
	반납 : <span id="endDay">${list.endDay}</span> ${list.endTime }
	<div class="confirmrent-info">※ 차량 대여 기간을 초과하여 반납하실 경우 별도의 초과 요금이 적용 됩니다. <br>
	예를 들어 오후 3시에 차량을 반납하기로 되어있는 경우 교통체증으로 인해 오후 5시에 차량을 반납하시게 되면 초과시간 2시간에 대한 요금을 추가 부담 하셔야 합니다.<br> 참고 바랍니다.</div>
	</td>
	</tr>

	</table>
	</div>
	
	
</body>
</html>