var list;		// 예약된 시간 불러올 리스트

/* 날짜 / 시간에 관한 함수 */
// 날짜 변경시 정상적인 날짜인지 확인
function check_start_date() {
	// 시간 선택 초기화
	$("#start_time option").attr("selected", false);
	$("#start_time option:eq(0)").attr("selected", true);
	
	// 대여날짜와 반납날짜
	var sdate = new Date($("input[name=start_day]").val() + " 00:00:00"),
		edate = new Date($("input[name=end_day]").val() + " 00:00:00");
	
	// 대여날짜가 반납날짜보다 클 경우
	if (sdate > edate) {
		// 반납날짜를 초기화
		$("input[name=end_day]").val(null);
		$("#end_time option:eq(0)").attr("selected", true);
	}
	
	// 현재 날짜 이전 선택시 초기화
	var now_date = new Date(new Date().getFullYear() + "-" + (new Date().getMonth() + 1) + "-" + new Date().getDate() + " 00:00:00");
		
	if(now_date > sdate) {
		$("input[name=start_day]").val(null);
		$("#start_time option:eq(0)").attr("selected", true);
	}
	
	// 대여시간 option 초기화
	update_start_time();
}

// 날짜 변경시 정상적인 날짜인지 확인
function check_end_date() {
	// 시간 선택 초기화
	$("#end_time option").attr("selected", false);
	$("#end_time option:eq(0)").attr("selected", true);
	
	// 대여날짜와 반납날짜 객채
	var sdate = new Date($("input[name=start_day]").val()),
		edate = new Date($("input[name=end_day]").val());
	
	// 대여날짜가 반납날짜보다 클 경우
	if (sdate > edate) {
		// 반납날짜를 초기화
		$("input[name=end_day]").val(null);
		$("#end_time option:eq(0)").attr("selected", true);
	}
	
	// 대여시간 option 초기화
	update_start_time();
}

// 시간 변경 시 정상적인 시간인지 확인
function check_start_time() {
	// 대여날짜와 반납날짜 객채
	var sdate = $("input[name=start_day]").val(),
		edate = $("input[name=end_day]").val();
		
	var stime = parseInt($("#start_time option:selected").val()),
		etime = parseInt($("#end_time option:selected").val());
	
	// 현재 날짜
	var now_date = get_nowDate();
	
	if (sdate == edate) {
		// 대여, 반납 일자가 같은데 대여 시간이 반납시간보다 같거나 클경우
		if (stime >= etime) {
			// 시간 선택 초기화
			$("#start_time option").attr("selected", false);
			$("#start_time option:eq(0)").attr("selected", true);
		}
	} else if (sdate == now_date) {
		// 현재 날짜와 대여 날짜가 같으면서 현재 시간보다 대여 시간이 작으면 값 초기화
		if(stime <= new Date().getHours()) {
			$("#start_time option").attr("selected", false);
			$("#start_time option:eq(0)").attr("selected", true);
		}
	}
}

function check_reserve_time() {
	// 대여 시간 이후에 이미 예약된 시간이 있다면 해당 시간 이후는 반납시간 선택 불가능하게 함
	if ($("#start_time option:selected").val() != 'none') {
		list.forEach(function (e) {
			if (parseInt(e.starttime) > parseInt($("#start_time option:selected").val())) {
				if ($("input[name=start_day]").val() == e.startday) {
					if ($("input[name=start_day]").val() == $("input[name=end_day]").val()) {
						for (var i = e.endtime; i < 24; i++) {
							$("#end_time option[value=" + i + "]").attr("disabled", true);
						}
					} else {
						$("input[name=end_day]").val(null);
						$("#end_time option:eq(0)").attr("selected", true);
						for (var i = 0; i < 24; i++) {
							$("#end_time option[value=" + i + "]").attr("disabled", true);
						}
					}
				}
			}
		});
	}
}

// 시간 변경 시 정상적인 시간인지 확인
function check_end_time() {
	// 대여날짜와 반납날짜 객채
	var sdate = $("input[name=start_day]").val(),
		edate = $("input[name=end_day]").val();
		
	var stime = parseInt($("#start_time option:selected").val()),
		etime = parseInt($("#end_time option:selected").val());
		
	if (sdate == edate) {
		// 대여, 반납 일자가 같은데 대여 시간이 반납시간보다 같거나 클경우
		if (stime >= etime) {
			// 시간 선택 초기화
			$("#end_time option").attr("selected", false);
			$("#end_time option:eq(0)").attr("selected", true);
		}
	}
}

// 예약된 날짜, 시간 리스트를 통해 option을 비활성화 하는 함수
function update_start_time() {
	// 비활성화 됬던 옵션들 초기화
	$("#start_time option").attr("disabled", false);
	
	// 선택한 대여날짜
	var start_date = $("input[name=start_day]").val();
	
	// 예약 목록 반복하면서 날짜 확인
	for(var i = 0; i < list.length; i++) {
		// 예약 목록 중 같은 날짜가 있을 경우
		if (list[i].startday == start_date) {
			// 반납 일자를 확인 후 대여 시간만큼 option 비활성화
			if (list[i].startday == list[i].endday) {
				// 대여일자와 반납일자가 같은 경우 대여시간과 반납시간까지 비활성화
				for (var j = list[i].starttime; j < list[i].endtime; j++) {
					// 예약되어있는 대여시간(j) 를 비활성화
					$("#start_time option[value=" + j + "]").attr("disabled", true);
				}
			} else {
				// 대여일자와 반납일자가 다른경우 예약된 대여시간부터 마지막 시간까지 모두 비활성화
				for (var j = list[i].starttime; j < 24; j++) {
					// 예약되어있는 대여시간(j) 부터 끝까지 비활성화
					$("#start_time option[value=" + j + "]").attr("disabled", true);
				}
			}
		}
	}
	
	// 현재 날짜
	var now_date = get_nowDate();
	
	// 선택한 대여 날짜가 현재날짜와 같으면 현재 시간 이전 시간은 비활성화
	if (now_date == start_date) {
		for (var i = 0; i <= new Date().getHours(); i++) {
			$("#start_time option[value=" + i + "]").attr("disabled", true);
		}
	}
}

// 예약된 날짜, 시간 리스트를 통해 option을 비활성화 하는 함수
function update_end_time() {
	// 비활성화 됬던 옵션들 초기화
	$("#end_time option").attr("disabled", false);
	
	// 선택한 반납날짜
	var end_date = $("input[name=end_day]").val();
	var start_date = $("input[name=start_day]").val();
	
	// 예약 목록 반복하면서 날짜 확인
	for(var i = 0; i < list.length; i++) {
		// 예약 목록 중 같은 날짜가 있을 경우
		if (list[i].endday == end_date) {
			// 반납 일자를 확인 후 대여 시간만큼 option 비활성화
			if (list[i].startday == list[i].endday) {
				// 대여일자와 반납일자가 같은 경우 대여시간과 반납시간까지 비활성화
				for (var j = list[i].starttime; j < list[i].endtime; j++) {
					// 예약되어있는 대여시간(j) 를 비활성화
					$("#end_time option[value=" + j + "]").attr("disabled", true);
				}
			} else {
				// 대여일자와 반납일자가 다른경우 00시부터 반납시간까지 비활성화
				for (var j = 0; j < list[i].endtime; j++) {
					// 예약되어있는 대여시간(j) 부터 끝까지 비활성화
					$("#end_time option[value=" + j + "]").attr("disabled", true);
				}
			}
		}
	}
	
	// 선택한 대여시간 이전 시간 비활성화
	if (start_date == end_date && $("#start_time option:selected").val() != null) {
		for (var i = 0; i <= $("#start_time option:selected").val(); i++) {
			$("#end_time option[value=" + i + "]").attr("disabled", true);
		}
	}
}

// 시간 변경시 차량 번호/날짜 가 정상적으로 선택되었는지 확인 후 예약 버튼 활성화
function check_info() {
	var	car = car_num,	// 차량 번호
		sdate = $("input[name=start_day]").val(),	// 대여일
		stime = $("#start_time option:selected").val(),	// 대여시간
		edate = $("input[name=end_day]").val(),		//반납일
		etime = $("#end_time option:selected").val();

	// 각 객체의 값이 정상적으로 입력되었을 경우
	if (car != null && sdate != null && stime != 'none' && edate != null && etime != 'none') {
		// 버튼 황성화
		$("#reserve").attr("disabled", false);
		
		// 버튼에 호버 이벤트 등록
		$("#reserve").hover(function() {
			$("#reserve").css("background-color", "aqua");
			$("#reserve").css("color", "white");
		}, function() {
			$("#reserve").css("background-color", "white");
			$("#reserve").css("color", "black");
		});
	} else {
		// 정상적인 값이 아닐경우 호버 이벤트 삭제
		// 버튼 비황성화
		$("#reserve").attr("disabled", true);
		
		// 버튼에 호버 이벤트 삭제
		$("#reserve").hover(function() {
			$("#reserve").css("background-color", '');
			$("#reserve").css("color", '');
		});
	}
}

// 현재 날짜를 input 데이터와 equal 비교하기 위한 객채로 반환시켜주는 함수
function get_nowDate() {
	// 현재 날짜
	var now_date = "";
	
	// 현재 날짜 포맷을 input 데이터와 동일하게 만듬
	if (new Date().getMonth() < 9) {
		if (new Date().getDate() < 10) {
			now_date = new Date().getFullYear() + "-0" + (new Date().getMonth() + 1) + "-0" + new Date().getDate();
		} else {
			now_date = new Date().getFullYear() + "-0" + (new Date().getMonth() + 1) + "-" + new Date().getDate();	
		}
	} else {
		if (new Date().getDate() < 10) {
			now_date = new Date().getFullYear() + "-" + (new Date().getMonth() + 1) + "-0" + new Date().getDate();
		} else {
			now_date = new Date().getFullYear() + "-" + (new Date().getMonth() + 1) + "-" + new Date().getDate();	
		}
	}
	
	return now_date;
}
///////////////////////////// 사용자 함수 끝 ///////////////////////////////////

/* 차량 선택 시 */
// 차량 선택시 차량 번호 유지하고 css 변경
$("tbody").click(function() {
	list = new Array();
	
	car_num = $(this).attr("id");
	
	// 차량 선택 효과를 css 로 지정
	$(".car_select").css("background-color", "white");
	$(this).css("background-color", "#6DF6EA");
	
	// 차량의 위치로 지도를 옮긴다.
	car_num_list.forEach(function (e, i) {
		if (car_num == e) {
			map.setLevel(2);
			map.panTo(new kakao.maps.LatLng(latitude_list[i], longtitude_list[i]));
		}
	})
	
	// 이미 예약된 시간은 option 에서 비활성화하기 위해 ajax 요청
	$.ajax({
		type: 'GET',
		url: '/rent/getDate',
		data: {
			'car_num': car_num
		},
		dataType: 'json',
		success: function(data) {
			// 데이터 개수 반복하면서 새 객채(list)로 옮김
			for (var i = 0; i < data.data.length; i++) {
				var tmp = new Object();
				tmp.startday = data.data[i].startday;
				tmp.starttime = data.data[i].starttime;
				tmp.endday = data.data[i].endday;
				tmp.endtime = data.data[i].endtime;
				list.push(tmp);
			}
		}
	});
	
	// 날짜 선택 초기화
	$("input[name=start_day]").val(null);
	$("input[name=end_day]").val(null);
	$("#start_time option").attr("selected", false);
	$("#end_time option").attr("selected", false);
	$("#start_time option:eq(0)").attr("selected", true);
	$("#end_time option:eq(0)").attr("selected", true);
	
	// 버튼 비활성화
	check_info();
});
//////////////////////////// 차량 선택 이벤트 끝 /////////////////////////////

/* 날짜 및 시간 선택 이벤트 */
// 대여 날짜 변경 시
$("input[name=start_day]").change(function() {
	// 대여일자 확인
	check_start_date();
	
	// option 비활성화 상태 초기화
	update_start_time();
	
	// 버튼 활성화 여부 확인
	check_info();
});

// 대여 시간 변경 시
$("#start_time").change(function() {
	// 대여 시간 확인
	check_start_time();
	
	// 반납 시간 여부 확인
	check_reserve_time();
	
	// 버튼 활성화 여부 확인
	check_info();
});

// 반납 날짜 변경 시
$("input[name=end_day]").change(function() {
	// 반납 일자 확인
	check_end_date();
	
	// option 비활성화 상태 초기화
	update_end_time();
	
	// 반납 시간 여부 확인
	check_reserve_time();
	
	// 버튼 활성화 여부 확인
	check_info();
});

// 반납 시간 변경 시
$("#end_time").change(function() {
	// 반납 시간 확인
	check_end_time();
	
	// 버튼 활성화 여부 확인
	check_info();
});
///////////////////////////// 시간 선택 이벤트 끝 //////////////////////////////

/* 예약 버튼 클릭 시 이벤트 */
$("#reserve").click(function() {
	var	cnum = car_num,	// 차량 번호
		sdate = $("input[name=start_day]").val() + " " + $("#start_time option:selected").val(),	// 대여 일
		edate = $("input[name=end_day]").val() + " " + $("#end_time option:selected").val();		// 반납 일
		
	location.href = '/rent/payment?car_num=' + cnum + '&start_date=' + sdate + '&end_date=' + edate;
});


////////////////////////////// 버튼 이벤트 끝 //////////////////////////////////

$("#wrapper").css("z-index", -1);