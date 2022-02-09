<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- jQuery -->
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
		
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
		<!-- swiper -->
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/owl.carousel.min.css">
		<script src="${ pageContext.request.contextPath }/js/owl.carousel.min2.js"></script>
		
		<!-- main-body-style.css -->
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/main-body-style.css">
		<title>TITLE</title>
	</head>
	<body>
		<div class="wrapper">
			<div class="content">
				<div class="maiin_slide_wrap">
					<section id="mainSlider">
						<div id="owl-main" class="owl-carousel">
							<div class="item">
								<div class="container">
									<div class="caption vertical-center text-right">
										<div class="caption1_1">	
											<div class="fadeInLeft-1">
												#싸다<br>#쉽다<br>#간편하다
											</div>
										</div>
										<div class="caption1_2">
											<div class="fadeInLeft-2">
												여행 갈 땐,<br>
												예약부터 결제까지<br>
												원스톱으로 씽씽카~
											</div>
										</div>
										<div class="caption1_3">
											<div class="fadeInLeft-3"><img src="../mainimg/main_img1.png"></div>
										</div>
										<div class="caption1_4">
											<div class="fadeInLeft-4"><img src="../mainimg/main_img2.png"></div>
										</div>
										<!-- /.fadeIn -->
									</div><!-- /.caption -->
								</div><!-- /.container -->
							</div><!-- /.item -->
							<div class="item">
								<div class="container">
									<div class="caption vertical-center text-right">
										<div class="caption2_1">
											<div class="fadeInLeft-1">
												씽씽카
											</div>
										</div>
										<div class="caption2_2">
											<div class="fadeInLeft-2">		
												365일 24시간 PC & 모바일 예약<br>
												렌터카 빌릴 땐 ~
											</div>
										</div>
										<div class="caption2_3">
											<div class="fadeInLeft-3"><img src="../mainimg/main_img3.png"></div>
										</div>
										<div class="caption2_4">
											<div class="fadeInLeft-4"><img src="../mainimg/main_img4.png"></div>
										</div>
										<!-- /.fadeIn -->
									</div><!-- /.caption -->
								</div><!-- /.container -->
							</div><!-- /.item -->
							<div class="item">
								<div class="container">
									<div class="caption vertical-center text-right">
										<div class="caption3_1">
											<div class="fadeInLeft-1">
												#착한 렌터카<br>
												#가격홀릭
											</div>
											</div>
											<div class="caption3_2">
												<div class="fadeInLeft-2">
													일반 렌터카보다<br>
													훨씬 경제적인 대여료~
												</div>
											</div>
										<div class="caption3_3">	
											<div class="fadeInLeft-3"><img src="../mainimg/main_img5.png"></div>
										</div>
										<div class="caption3_4">
											<div class="fadeInLeft-4"><img src="../mainimg/main_img6.png"></div>
										</div>
									<!-- /.fadeIn -->
									</div><!-- /.caption -->
								</div><!-- /.container -->
							</div><!-- /.item -->
							<div class="item">
								<div class="container">
									<div class="caption vertical-center text-right">
										<div class="caption4_1">
											<div class="fadeInLeft-1">
												씽씽카
											</div>
										</div>
										<div class="caption4_2">
											<div class="fadeInLeft-2">
											안전하고 쾌적한 여행<br>
											이젠 씽씽카와 함께하세요.
											</div>
										</div>
										<div class="caption4_3">
											<div class="fadeInLeft-3"><img src="../mainimg/main_img7.png"></div>
										</div>
										<div class="caption4_4">
											<div class="fadeInLeft-4"><img src="../mainimg/main_img8.png"></div>
										</div>
										<!-- /.fadeIn -->
									</div><!-- /.caption -->
								</div><!-- /.container -->
							</div><!-- /.item -->
						</div><!-- /.owl-carousel -->
						<div class="width_wrap" style="width:1200px; margin-top:120px;">
							<div id="owl-cars" class="owl-carousel">		
								<div class="item"><div class="car"><img src="../mainimg/sh.png" ></div><div class="caption"><h3>친구들과 실속파 여행</h3><p><span>소형</span>7,000원~</p></div></div>
								<div class="item"><div class="car"><img src="../mainimg/jh.png" ></div><div class="caption"><h3>연인과 함께 하는 로맨틱 여행</h3><p><span>중형</span>11,500원~</p></div></div>
								<div class="item"><div class="car"><img src="../mainimg/dh.png" ></div><div class="caption"><h3>가족과 함께 하는 편안한 여행</h3><p><span>대형</span>15,000원~</p></div></div>
							</div>
							<div class="owl-nav">
								<div class="owl-prev"></div>
								<div class="owl-next"></div>
							</div> 
							<div class="text-c">
								<a class="main_reserve_btn" id="main_reserve_btn" onclick="location.href='rent/rentForm'">예약하기</a>
							</div>
						</div>		
					</section>
				</div>					
				<div class="bg2">
					<div>
						<h3>
							<span class="cl-point">씽씽카</span>
							에서<br>
							스마트하게 빌리는 방법!
						</h3>
						<img alt="" src="../mainimg/main_bg2.png">
					</div>
				</div>	
			</div>
		</div>
		<script type="text/javascript">
	
		jQuery(function($){ 
		
			
			var owlElementID = '#owl-main';
			$(owlElementID).owlCarousel({
				items:1,
				autoplay:true,
				autoplayTimeout:5000,
				autoplaySpeed:1000,
				center: true,
				loop: true,
				dots: true,
				nav: false,
				//animateIn: 'fadeIn',
				animateOut: 'slideOutLeft'
			});
			
			
			
			$("#owl-cars").owlCarousel({
				autoplay:true,
				autoplayTimeout:3000,
				smartSpeed:1000,
				center: true,
				items:3,
				loop:true,
				
				stopOnHover: false,
				nav: true,
 				navElement: "div", 
				navContainerClass: "owl-nav",
		        navClass: ["owl-prev", "owl-next"], 
				dots: false,
				margin:20,
				mouseDrag:false,
				autoplayHoverPause:true,
				//animateIn: 'fadeIn',
				animateOut: 'slideOutLeft'});
			
	
			

			
		});
		
		</script>
		
	</body>
</html>