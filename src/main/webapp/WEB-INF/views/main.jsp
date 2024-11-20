<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<%@ include file="header.jsp"%>
<script type="text/javascript">
function goToLink(url) {
    window.location.href = url;
}

$(document).ready(function() {
    $('#autoComplete').autocomplete({
        source: function(request, response) {
            // 현재 선택된 라디오 버튼의 값을 가져옵니다.
            var searchType = $("input[name='searchType']:checked").val();

            $.ajax({
                url: "/ajax/autocomplete.do",
                type: "POST",
                dataType: "json",
                data: {
                    value: request.term,
                    searchType: searchType // 선택된 라디오 버튼의 값 추가
                },
                success: function(data) {
                    response($.map(data.resultList, function(item) {
                        return {
                            label: item.MODEL,
                            value: item.MODEL,
                        };
                    }));
                },
                error: function() {
                    alert("오류가 발생했습니다.");
                }
            });
        },
        minLength: 1,
        delay: 300,
        select: function(event, ui) {
            $('#autoComplete').val(ui.item.value);
            return false;
        }
    });
});

function reviewDetail(approval_num, user_id, sell_num) {

    var url = "/csReviewDetail?approval_num=" + approval_num
                + "&user_id=" + user_id
                + "&sell_num=" + sell_num;

    window.open(url, "_blank", 'width=650,height=800,location=no,status=no,scrollbars=no,top=100,left=300');
}
</script>
</head>
<body>
<div class="kakao_wrapper"><%@ include file="kakao.jsp"%></div>
	<!-- 메인배너 -->
	<div class="main_banner">
		<img alt="메인배너" src="<%=request.getContextPath()%>/images/main/main_banner.png" class="main_search_img">
		<img alt="차량" src="<%=request.getContextPath()%>/images/main/car_main.gif" class="main_car_img">
		<div class="main_search_div">
			<form action="/main_search" method="get" class="main_search_form">
				<div class="searchType_wrapper">
					<input type="radio" id="korea"  value="1000" name="searchType" checked="checked" class="searchType_but1">
					<label for="korea"></label>
					<input type="radio" id="global" value="2000" name="searchType" class="searchType_but2">
					<label for="global"></label>
					<input type="radio" id="eco" 	value="3000" name="searchType" class="searchType_but3">
					<label for="eco"></label>
				</div>
				<div class="search_input">
					<input type="text" id="autoComplete" class="search" name="keyword" placeholder="검색어를 입력하세요."/>
					<button type="submit" class="search_submit"></button>
				</div>
			</form>
		</div>
	</div>
	
	<div class="container">
	
		<!-- 전문가리뷰 -->
		<div class="exp_rev_list_back">
			<div class="exp_rev_list">
				<c:forEach var="ExpRev" items="${expert }">
					<div class="card_text_body">
					  <a class="card_text_Exp_img" onclick="window.open('/KH/pay/expertReviewPage?expert_review_num=${ExpRev.expert_review_num }', '전문가리뷰보기', 'width=700,height=1000,location=no,status=no,scrollbars=yes,top=300,left=300')">
					  <img src="<%=request.getContextPath()%>/images/main/gms.png" class="card-img" alt="...">
					  <div class="card-img-overlay">
					    <h3 class="exp_card_title">${ExpRev.user_id }전문가의 리뷰</h3>
					  </div>
					  </a>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="exp_rev_banner">
			<img alt="전문가리뷰배너" src="<%=request.getContextPath()%>/images/main/beaner_go.png" class="exp_rev_banner_img">
		</div>
		
		<!-- 프리미엄 차량 -->
		<div class="prm_hed">
			<h3 class="prm_title">프리미엄 차량</h3>
		</div>
		<div class="prm_car_background">
			<div class="prm_car-all">
				<c:forEach var="CarList" items="${randomCarInfo}">
					<div class="prm_car-list" >
					  <a href="/carInfo?sellNum=${CarList.sell_num }&id=${CarList.user_id}">
					  <img src="<%=request.getContextPath()%>${CarList.img_url}" class="card-img-top" alt="차량이미지">
					  <div class="card-body">
					    <p class="card-title">${CarList.model}</p>
					    <p class="card-text_1">${CarList.price} 만원</p>
					    <div class="card-text_2"> ${CarList.munu_date_cos }&emsp;&emsp;${CarList.mileage }km&emsp;&emsp;${CarList.fuel }</div>
					  </div>
					  </a>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<!-- 추천 및 우측배너 -->
		<div class="chutitle_all">
			<h3 class="chuhed_title">취향저격! 추천차량</h3>
			<a href="/view_sh/detailSearch" class="chuhed_a">더보기 ></a>
			<div class="chubanner_tile">
				<h3 class="chubanner" style="margin: 0; align-items: center;">메거진</h3>
				<a href="" class="chuhed_a2">더보기 ></a>
			</div>
		</div>
		<div class="chu_banner">
			<div class="chu_list">
				<c:forEach var="CarList" items="${randomCarInfo2}">
					<div class="chu_carList">
						<a href="/carInfo?sellNum=${CarList.sell_num }&id=${CarList.user_id}">
						<img alt="chuCarimg" src="<%=request.getContextPath()%>${CarList.img_url}" class="chu-img">
						<div class="chu_body_all">
							<div class="chu-body">
								<img alt="구매대기중" src="<%=request.getContextPath()%>/images/main/Waitingforpurchase.png">
								<p class="chu-title">${CarList.model }</p>
							</div>
							<p class="chu-text"><b>${CarList.price }</b> 만원</p>
						</div>
						</a>
					</div>
				</c:forEach>
			</div>
			<div class="banner">
				<img alt="배너" src="<%=request.getContextPath()%>/images/main/banner.png" class="chu_img_banner">
			</div>
		</div>
		
		<!-- 가로리뷰 -->
		<img alt="가로배너" src="<%=request.getContextPath()%>/images/main/banner_gr.jpg" class="bann_gr">
		
		<!-- 생생한 리뷰 -->
		<div class="rev_hed">
			<h3 class="rev_h3">생생한 리뷰</h3>
		</div>
		<div class="rev_background">
			<div class="rev_list">
				<c:forEach var="review" items="${review }">
                    <div class="rev_revlist">
                        <a href="#" onclick="reviewDetail('${review.approval_num}', '${review.user_id}', '${review.sell_num}'); return false;">
                            <img alt="" src="${ review.img_url }" class="rev_img">
                            <input type="hidden" value="" id="rev_num">
                        <div class="rev_body">
							<div class="rev_evaluetion">
								<c:choose>
									<c:when test="${review.evaluation == 5}">
										<img alt="별5점" src="<%=request.getContextPath()%>/images/main/star_5.png" class="star_img">
									</c:when>
									<c:when test="${review.evaluation == 4}">
										<img alt="별4점" src="<%=request.getContextPath()%>/images/main/star_4.png" class="star_img">
									</c:when>
									<c:when test="${review.evaluation == 3}">
										<img alt="별3점" src="<%=request.getContextPath()%>/images/main/star_3.png" class="star_img">
									</c:when>
									<c:when test="${review.evaluation == 2}">
										<img alt="별2점" src="<%=request.getContextPath()%>/images/main/star_2.png" class="star_img">
									</c:when>
									<c:otherwise>
										<img alt="별1점" src="<%=request.getContextPath()%>/images/main/star_1.png" class="star_img">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="rev_body_text">${review.review_title}</div>
							<div class="rev_body_text1">
								<%-- <%
									String manuDate = review.getReview_date();
									if(manuDate != null && manuDate.length() == 4){
										String year = manuDate.substring(0,2);
										String month = manuDate.substring(2,4);
										String filDay = year + "년 " + month + "월 식";
									
								%>
								<%=filDay %>&emsp;&emsp;${review.mileage }&emsp;&emsp;${review.fuel}
								<%
									} else {
										out.print("날짜정보 없음");
									}
								%> --%>
								${review.manu_date_char }&emsp;&emsp;${review.mileage }km&emsp;&emsp;${review.fuel}
							</div>
							<div class="rev_body_text2">${review.review_content}</div>
							<div class="rev_body_date">${review.review_date}</div>
						</div>
						</a>
					</div>
				</c:forEach>
			
			</div>
		</div>
		
		<!-- 공지사항 -->
		<div class="gogi_hed">
			<h3 class="gogi_h3">공지사항</h3>
		</div>
		<div class="gogi_list">
			<table class="gogi_table">
				<c:forEach var="notList" items="${listNot}">
						<tr class="col-2" onclick="goToLink('/view_jw/csNoticeSelect?notice_num=${notList.notice_num}')">
							<td><div class="gogi_text">[
								<c:choose>
									<c:when test="${notList.notice_cls == 6100 }">
										공지사항
									</c:when>
									<c:when test="${notList.notice_cls == 6200 }">
										이용약관
									</c:when>
									<c:otherwise>
										이벤트
									</c:otherwise>
								</c:choose>
								]&nbsp${notList.notice_title }</div></td>
							<td><div class="gogi_text_date">
								<fmt:formatDate value="${notList.notice_date }" pattern="yyyy-MM-dd"/> 
								</div>
							</td>
						</tr>
				</c:forEach>
			</table>
			
		</div>
		
	</div>
	<%@ include file="footer.jsp"%>
	<script type="text/javascript" src="../js/bootstrap.js"></script>
</body>
</html>