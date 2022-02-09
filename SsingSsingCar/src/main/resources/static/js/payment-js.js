function insertRent(mem_num, car_num, start_day, end_day, total_price) {
	$.ajax({
		method: "POST",
		url: '/rent/reserve',
		data: {
			mem_num: mem_num,
			car_num: car_num,
			start_day: start_day,
			end_day: end_day,
			total_price: total_price
		}
	});
}