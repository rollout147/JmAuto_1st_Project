<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/carInfo.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<div class="header_continer"><%@ include file="../header_white.jsp" %></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b1aec89436ffdda282e6948304fd91a1"></script>
<script type="text/javascript">
	window.addEventListener('scroll', function() {
		console.log("스크롤 중....");
		const purchaseDiv = document.querySelector('.Info_purchase');
		const footer = document.querySelector('footer');
		const footerTop = footer.offsetTop;
		const scrollY = window.scrollY;
		const stopPosition = 247;
		const divHeight = purchaseDiv.offsetHeight;
		
		if (scrollY > stopPosition && (scrollY + divHeight) < footerTop){
			purchaseDiv.style.position = 'fixed';
			purchaseDiv.style.top = '65px';
		} else if ((scrollY + divHeight) >= footerTop) {
			purchaseDiv.style.position = 'absolute';
			purchaseDiv.style.top = (footerTop - divHeight) + 'px';
		} else {
			purchaseDiv.style.position = 'absolute';
			purchaseDiv.style.top = '312px';
		}
	});
	
	function swapImage(clickedThumbnail){
		console.log("체크실행중");
		const mainImage = document.getElementById('mainImage');
		const mainImageSrc = mainImage.src;
		
		mainImage.src = clickedThumbnail.src;
		
		clickedThumbnail.src = mainImageSrc;
	}
	
	function toggleFaq(element) {
		var answer = element.nextElementSibling;
		var toggleBut = element.querySelector(".faq_arrow");
		
		if (answer.style.display == "block"){
			answer.style.display = "none";
			toggleBut.classList.remove('rotated');
		} else {
			answer.style.display = "block";
			toggleBut.classList.add('rotated');
		}
	}
	
	let currentSlide = 0; // 현재 슬라이드 위치
	const cardsPerPage = 2; // 한 페이지에 보여줄 카드 개수

	function showSlides() {
	    const slides = document.querySelectorAll('.expert_card_list');
	    slides.forEach((slide, index) => {
	        // currentSlide와 cardsPerPage를 사용해 보여줄 카드 결정
	        if (index >= currentSlide && index < currentSlide + cardsPerPage) {
	            slide.classList.add('show'); // 'show' 클래스 추가
	        } else {
	            slide.classList.remove('show'); // 'show' 클래스 제거
	        }
	    });
	}

	function slide(direction) {
	    const slides = document.querySelectorAll('.expert_card_list');
	    const totalSlides = slides.length;
		console.log("currentSlide " + currentSlide);
	    // 현재 슬라이드 위치 업데이트
	    currentSlide += direction;

	    // currentSlide가 유효한 범위 내에 있도록 조정
	    if (currentSlide > totalSlides - cardsPerPage) {
	        currentSlide = totalSlides - cardsPerPage; // 마지막 페이지 조정
	    } 
	    if (currentSlide < 0) {
	        currentSlide = 0; // 처음 페이지 조정
	    }

	    showSlides();
	}
	window.onload = showSlides;

	// 초기 슬라이드 보여주기
	showSlides(); // 여기서 초기 상태 설정

    $(document).ready(function() {
        $(".zzim_insert").on("click", function() {
            const sellNum = $(this).data("sell_num"); // Correct 'sell_num' to lowercase
            const userId  = $(this).data("user_id");
            
            if(!userId) {
            	window.location.href = "/view_jm/login";
            	return;
            }
            
            console.log("Sending sellNum:", sellNum, "userId:", userId); // Debugging line

            $.ajax({
                type: "POST",
                url: "/mhwishlist/add",
                contentType: "application/json",
                data: JSON.stringify({
                    sellNum: sellNum, // Proper JSON format
                    userId: userId
                }),
                success: function(response) {
                	showZzimEffect(response); // Handle success
                },
                error: function(xhr, status, error) {
                    alert("Error: " + error); // Handle error
                }
            });
        });
    });
    function showZzimEffect(message) {
	    const overlay = document.getElementById('overlay');
	    overlay.style.display = 'flex';
	
	    setTimeout(() => {
	        overlay.style.display = 'none';
	        alert(message); 
	    }, 2000); 
	}
</script>

<div class="div_kakao"><%@ include file="../kakao.jsp" %></div>
</head>
<body>
<main class="main_container">
	<div class="container1">
		<!-- 차량기본정보 및 주행거리 평균 -->
		<div class="Car_Info">
			<c:forEach var="list" items="${carInfoList}">
				<div class="Info_car_list">
					<div class="Info_car_hear">
						<h1 class="Info_car_h1">${list.model}</h1>
						<c:if test="${sessionScope.user.user_type == 'P' || sessionScope.user.user_type == 'A' }">
							<button type="button" onclick="location.href='/KH/pay/createExpertReview?sell_num=${list.sell_num}'" class="Info_car_hear_but">리뷰작성</button>
						</c:if>
					</div>
					<div class="Info_body">
						<div class="Info_body_text">
							<div class="Info_car_text_1">${list.car_num }</div>
							<div class="Info_car_text_2">${list.accident }</div>
							<div class="Info_car_text_3">${list.munu_date_cos }</div>
							<div class="Info_car_text_4">${list.mileage }km</div>
							<div class="Info_car_text_5">${list.fuel }</div>
							<div class="Info_car_text_6">${list.color }</div>
							<div class="Info_car_text_7">${list.transmission }</div>
							<div class="Info_car_text_8">${list.price }만원</div>
						</div>
						<div class="Info_body_a">
							<c:forEach var="car" items="${carInfoList }">
								<button id="zzim_insert" class="zzim_insert" data-sell_Num="${car.sell_num }" data-user_id="${sessionScope.user.user_id }">찜하기</button>
							</c:forEach>
							<button id="zzim_insert">공유하기</button>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div class="Info_img_container">
				<div class="Info_main_img">
					<img id="mainImage" alt="main_img" src="<%=request.getContextPath()%>${car_img[0].img_url}" class="main_image" style="margin: 0 0 20px;">
				</div>
				
				<div class="thumbnail_container">
					<c:forEach var="car" items="${car_img}" begin="1">
						<img alt="thumbnail" src="<%=request.getContextPath()%>${car.img_url}" class="thumbnail" onclick="swapImage(this)">
					</c:forEach>
				</div>
		</div>
		
		
		
		<div class="car_particular_main">
			<div class="car_particular_hd">
				<h3>차량정보</h3>
			</div>
			<div class="car_particular">
				<c:forEach var="list" items="${carInfoList}">
				<div class="Info_carInfo_particular">
					<h4>기본정보</h4>
					<table class="particular_text_pu">
						<tr>
							<td class="particular_text_pu_td_1">차량번호</td>
							<td class="particular_text_pu_td_2">${list.car_num }</td>
							<td class="particular_text_pu_td_1">연식</td>
							<td class="particular_text_pu_td_2">${list.munu_date_cos }</td>
						</tr>
						<tr>
							<td class="particular_text_pu_td_1">주행거리</td>
							<td class="particular_text_pu_td_2">${list.mileage }km</td>
							<td class="particular_text_pu_td_1">연료</td>
							<td class="particular_text_pu_td_2">${list.fuel }</td>
						</tr>
						<tr>
							<td class="particular_text_pu_td_1">변속기</td>
							<td class="particular_text_pu_td_2">${list.transmission }</td>
							<td class="particular_text_pu_td_1">제조사</td>
							<td class="particular_text_pu_td_2">${list.brand }</td>
						</tr>
						<tr>
							<td class="particular_text_pu_td_1">차종</td>
							<td class="particular_text_pu_td_2">${list.car_type }</td>
							<td class="particular_text_pu_td_1">사고유무</td>
							<td class="particular_text_pu_td_3">${list.accident }</td>
						</tr>
						<tr>
							<td class="particular_text_pu_td_1">색상</td>
							<td class="particular_text_pu_td_2">${list.color }</td>
							<td class="particular_text_pu_td_1">압류유무</td>
							<td class="particular_text_pu_td_3">
								<c:choose>
									<c:when test="${list.repossession == '0' }">
										무압류
									</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="particular_text_pu_td_1">입고날짜</td>
							<td class="particular_text_pu_td_2"><fmt:formatDate value="${list.reg_date }" pattern="yyyy/MM/dd"/></td>
							<td ></td>
							<td ></td>
						</tr>
					</table>
				</div>
						
						
		
				<div class="Info_mileage">
					<h4>주행거리 분석</h4>
					<div class="Info_mileage_body">
						<c:choose>
							<c:when test="${list.mileage < 25000 }">
								<img alt="매우짧음_그래프" src="<%=request.getContextPath()%>/images/main/Veryshort_graph.png" class="mileage_grp_img">
							</c:when>
							<c:when test="${list.mileage < 50000 }">
								<img alt="짧음_그래프" src="<%=request.getContextPath()%>/images/main/short_graph.png" class="mileage_grp_img">
							</c:when>
							<c:when test="${list.mileage < 75000 }">
								<img alt="보통_그래프" src="<%=request.getContextPath()%>/images/main/Normal_graph.png" class="mileage_grp_img">
							</c:when>
							<c:when test="${list.mileage < 100000 }">
								<img alt="다소많음_그래프" src="<%=request.getContextPath()%>/images/main/Somewhatmuch_Graph.png" class="mileage_grp_img">
							</c:when>
							<c:otherwise>
								<img alt="매우많음_그래프" src="<%=request.getContextPath()%>/images/main/Verymany_graph.png" class="mileage_grp_img">
							</c:otherwise>
						</c:choose>
						<div class="Info_mileage_text">
							<div class="Info_mileage_text_ju1">${list.years_passed }년 ${list.mon_passed }개월 동안 <div class="Info_mileage_text_km">${list.mileage }km</div>운행</div>
							<div class="Info_mileage_text_ju2">[<div class="Info_mileage_text1">${list.car_num }</div>] 차량은</div>
							<div class="Info_mileage_text_ju3"> 주행거리는 일반적으로 [
							<div class="Info_mileage_text2">
								<c:choose>
									<c:when test="${list.mileage < 25000 }">
										매우짧음
									</c:when>
									<c:when test="${list.mileage < 50000 }">
										짧음
									</c:when>
									<c:when test="${list.mileage < 75000 }">
										보통
									</c:when>
									<c:when test="${list.mileage < 100000 }">
										다소많음
									</c:when>
									<c:otherwise>
										매우많음
									</c:otherwise>
								</c:choose>
							</div>
							] 입니다.</div>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
				
		<!-- 판매자 정보 -->
		<div class="Info_user_main">
			<hr/>
			<div class="Info_user_id_hd">
				<h3>판매자 정보</h3>
			</div>
			<div class="Info_user_id_allbody">
				<div class="Info_user_id">
					<c:forEach var="user" items="${userInfo }">
						<h4>판매자</h4>
						<div class="Info_user_id_body">
							<div class="Info_user_id_text1">${user.user_name }&emsp;<div class="Info_user_id_text1_1">┃</div>&emsp;${user.region }</div>
							<div class="Info_user_id_text2">${user.buz_name }</div>
							<div class="Info_user_id_text3">${user.user_tel }</div>
							<div class="Info_user_id_but1">               
                    	 <c:set var="sellNum" value="${param.sellNum}" />
                    <c:set var="id"      value="${param.id}" />

                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <button value="note" class="Info_purchase_but_2" onclick="window.open('/view_ms/go_note_form?sellNum=${sellNum}&id=${id}', '_blank', 'width=600, height=600, left=260, top=100, scrollbars=yes'); return false;">
                            쪽지 보내기</button>
                        </c:when>

                        <c:otherwise>
                            <button value="note" class="Info_user_id_but1_but" onclick="alert('로그인이 필요한 서비스입니다.'); window.location.href='/view_jm/login'; return false;">쪽지하기</button>
                        </c:otherwise>
                    </c:choose>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="Info_map_footer">
					<h4>판매자 소개</h4>
					<c:forEach var="user" items="${userInfo }">
						<c:if test="${user.introduction == null or user.introduction == ''}">
							<div class="Info_map_text_all">
								<div class="Info_map_text2">판매자가 설명을 등록하지 않았습니다.</div>
								<div class="Info_map_text2">판매자에게 직접 연락을 하시면</div>
								<div class="Info_map_text2">좀 더 자세한 사항을 안내 받을 수 있습니다.</div>
							</div>
						</c:if>
						<div class="Info_map_text3">${user.introduction }</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<!-- 판매자 소개(지도) -->
		<div class="Info_map_all">
			<div class="Info_map_content">
				<h4>차량을 직접 보시고 싶다면, 직영점 당일 방문 예약을 이용해 주세요.</h4>
				<div class="Info_map_hed_and">
					<ul class="Info_map_hed_ul">
						<li>토요일은 전화를 통한 예약만 가능합니다.</li>
						<li>예약 차량은 다른 고객에게 판매하지 않습니다.</li>
					</ul>
					  	 <c:set var="sellNum" value="${param.sellNum}" />
                    <c:set var="id"      value="${param.id}" />

                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <button value="note" class="Info_map_content_but_1" onclick="window.open('/view_ms/go_note_form?sellNum=${sellNum}&id=${id}', '_blank', 'width=600, height=600, left=260, top=100, scrollbars=yes'); return false;">
                            쪽지 보내기</button>
                        </c:when>

                        <c:otherwise>
                            <button value="note" class="Info_map_content_but_1" onclick="alert('로그인이 필요한 서비스입니다.'); window.location.href='/view_jm/login'; return false;">쪽지 남기기</button>
                        </c:otherwise>
                    </c:choose>
				</div>
				<hr/>
			</div>
			
			<div class="Info_map_content2">
			<div id="kakao_map" class="Info_user_map" style="width: 360px; height: 220px;">
				<script type="text/javascript">
					var container = document.getElementById('kakao_map');
					var options = {
						center: new kakao.maps.LatLng(33.450701, 126.570667),
						level: 3
					};
		
					var map = new kakao.maps.Map(container, options);
				</script>
			</div>
			<c:forEach var="user" items="${userInfo }">
					<div class="Info_map_text_all">
						<ul>
							<li><div class="Info_map_text1">주소</div>
								<div class="Info_map_text2">${user.buz_addr }</div></li>
							<li><div class="Info_map_text1">대표번호</div>
								<div class="Info_map_text2">${user.user_tel }</div></li>
							<li><div class="Info_map_text1">영업시간</div>
								<div class="Info_map_text2">월~토요일 09:00~18:00 공휴일/일요일 휴정</div></li>
							<li><div class="Info_map_text1">점심시간</div>
								<div class="Info_map_text2">12:00~13:00</div></li>
						</ul>
					</div>
			</div>
				<div class="Info_map_fil_all">
					<div class="Info_map_fil_div">
						<div class="Info_map_fil_text1">지역명</div>
						<div class="Info_map_fil_text1">${user.buz_addr }</div>
					</div>
					<div class="Info_map_fil_but">
						<button type="button" class="Info_map_fil_but_1">찾아오시는 길</button>
						<button type="button" class="Info_map_fil_but_2">주소알아보기</button>
					</div>
				</div>
					
			</c:forEach>
			
		</div>
		
		<!-- 전문가리뷰 리스트 -->
		<div class="expert_rev_list">
			<c:if test="${not empty ExpList}">
				<div class="expert_rev_hed">
					<div class="expert_rev_hed_title">
						전문가 리뷰
					</div>
				    <nav class="Info_purchase_nav">
				        <ul>
				            <li class="Info_purchase_nav_li">
				                <button class="previous" onclick="slide(-1)">
				                    <span>
				                        ◀
				                    </span>
				                </button>
				            </li>
				            <li class="Info_purchase_nav_li">
				                <button class="next" onclick="slide(1)">
				                    <span>
				                        ▶
				                    </span>
				                </button>
				            </li>
				        </ul>
				    </nav>
			    </div>
			    <div class="expert_card_wrapper">
			        <div class="expert_card_container">
		                <c:forEach var="rev_list" items="${ExpList}">
		                    <div class="expert_card_list">
		                   		<a onclick="window.open('/KH/pay/expertReviewPage?expert_review_num=${rev_list.expert_review_num }', '전문가리뷰보기', 'width=700,height=1000,location=no,status=no,scrollbars=yes,top=300,left=300')">
		                        <div class="exp_card_body">
		                            <div class="expert_card_Text">${rev_list.content}</div>
		                        </div>
		                        <div class="exp_card_footer">
		                            <div class="exp_card_footer_img"><img alt="" src=""></div>
		                            <div class="exp_card_footer_text">
		                                <div class="exp_card_footer_text_1">${rev_list.model}</div>
		                                <div class="exp_card_footer_text_2">
		                                    <fmt:formatDate value="${rev_list.write_date}" pattern="yyyy.MM.dd" />
		                                </div>
		                            </div>
		                        </div>
		                        </a> 
		                    </div>
		                </c:forEach>
			        </div>
			    </div>
			 </c:if>
		</div>
		
		<!-- 자주묻는질문 -->
		<div class="faq_list">
			<div class="faq_list_card">
				<c:forEach var="faq" items="${faqListSel }">
					<div class="faq_card">
						<div class="faq_list_card_title" onclick="toggleFaq(this)">
							<div class="faq_list_card_title_text_1">Q</div>
							<div class="faq_list_card_title_text_2">${faq.faq_title }</div>
							<button class="faq_toggle_btn"><img alt="화살표 버튼" src="<%=request.getContextPath()%>/images/main/화살표_icon.png" class="faq_arrow"></button>
						</div>
						<div class="faq_list_card_body">
							<div class="faq_list_card_body_text">
								<div class="faq_list_card_title_text_1">A</div>
								<p class="faq_list_card_title_text_3">${faq.faq_content }</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="Note_list">
				<ul class="Note_list_ul">
					<li class="Note_list_li1">위 주행거리 안내는 상품화 과정과 전시장 내 이동으로 실제와 다를 수 있습니다.</li>
					<li class="Note_list_li">선택옵션은 신차 계약 시 제공되는 기본 옵션 외에 추가 비용을 내고 장착한 옵션입니다.</li>
					<li class="Note_list_li">선택옵션은 해당 차량의 연식(최초등록일)과 모델연도가 다를 경우 옵션 정보(연식 기준)가 실제와 다를 수 있습니다.</li>
					<li class="Note_list_li">선택옵션의 가격은 신차 출고 당시의 옵션 가격이며, 현재 가치를 의미하지 않습니다.</li>
					<li class="Note_list_li">사고 유무와 상관없는 외부패널 부위(후드, 프론트펜더, 도어, 트렁크 등)의 판금과 도색은 K Car 진단 범위에 포함되지 않습니다.</li>
					<li class="Note_list_li">과거이력(정비이력 등)은 해당 차량의 모든 과거이력이 아닌 공공데이터로 공개되고 있는 일부 정보만 제공됩니다.</li>
					<li class="Note_list_li2">제조사 보증 정보는 참고용이며, 실제 남은 보증기간은 제조사에 직접 확인해 주세요.</li>
				</ul>
			</div>
		</div>
		

		<!-- 구매버튼 및 구매정보 -->
		<div class="Info_purchase">
			<c:forEach var="user" items="${userInfo }">
				<div class="Info_purchase_text1">
					<img alt="전화_icon" src="<%=request.getContextPath()%>/images/main/call_icon_.png" class="Info_purchase_icon">&nbsp;${user.user_tel }
				</div>
			</c:forEach>
			<hr/>
			<c:forEach var="list" items="${carInfoList}">
				<div class="Info_purchase_body">
					<div class="Info_purchase_h4">${list.model }</div>
					<div class="Info_purchase_text2">${list.car_num }&emsp;${list.accident }&emsp;${list.munu_date_cos }&emsp;${list.mileage }km&emsp;${list.fuel }&emsp;${list.transmission }</div>
					<table class="Info_purchase_table">
						<tr>
							<td><div class="Info_purchase_text3">차량가</div></td>
							<td><div class="Info_purchase_text4">${list.price_fre } 원</div></td>
						</tr>
						<tr>
							<td><div class="Info_purchase_text3">세금</div></td>
							<td><div class="Info_purchase_text4">${list.tax } 원</div></td>
						</tr>
						<tr>
							<td><div class="Info_purchase_text3">대행 수수료</div></td>
							<td><div class="Info_purchase_text4">${list.agency_fee } 원</div></td>
						</tr>
						<tr>
							<td><div class="Info_purchase_text6">출고 비용</div></td>
							<td><div class="Info_purchase_text5">0 원</div></td>
						</tr>
					</table>
				</div>
				<table class="Info_purchase_footer">
					<tr>
						<td><div class="Info_purchase_text7">합계</div></td>
						<td><div class="Info_purchase_text8">${list.sum_price } 원</div></td>
					</tr>
				</table>
				<div class="Info_purchase_but">
					<button onclick="location.href='/KH/pay/goPay?sell_num=${list.sell_num }'" value="pay" class="Info_purchase_but_1">결제하기</button>
					 <c:set var="sellNum" value="${param.sellNum}" />
                    <c:set var="id"      value="${param.id}" />

                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <button value="note" class="Info_purchase_but_2" onclick="window.open('/view_ms/go_note_form?sellNum=${sellNum}&id=${id}', '_blank', 'width=600, height=600, left=260, top=100, scrollbars=yes'); return false;">
                            쪽지 보내기</button>
                        </c:when>

                        <c:otherwise>
                            <button value="note" class="Info_purchase_but_2" onclick="alert('로그인이 필요한 서비스입니다.'); window.location.href='/view_jm/login'; return false;">쪽지 보내기</button>
                        </c:otherwise>
                    </c:choose>
				</div>
				<div class="Info_purchase_but_isu">
					<c:forEach var="car" items="${carInfoList }">
						<button class="zzim_insert" data-sell_Num="${car.sell_num }" data-user_id="${sessionScope.user.user_id }">찜하기</button>
					</c:forEach>
					<div class="overlay" id="overlay" style="display: none;">
						<div class="overlay_content">
							<img alt="찜하기 등록!" src="<%=request.getContextPath()%>/images/main/찜하기_mov.gif">
						</div>
					</div>
					<div class="Info_purchase_but_isu_text">│</div>
					<button>공유하기</button>
				</div>
			</c:forEach>
		</div>
		
	</div>
</main>
</body>
<footer class="footer">
	<div class="div_footer"><%@ include file="../footer.jsp" %></div>
</footer>
</html>