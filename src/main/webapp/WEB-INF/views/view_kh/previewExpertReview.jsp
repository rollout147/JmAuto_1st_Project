<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/css/expertReview.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">

	$(function() {
		
		var score 			= $('#gaugeGraphScore').val();
		var rawScoreDegree 	= (score * 2.7) - 135;
		var scoreDegree 	= Math.ceil(rawScoreDegree);
		
		var cssForm 		= "rotate(" + scoreDegree + "deg)";
		var cssJson 		= {"transform" : cssForm};
		
		$('#gaugeGraphNeedle').css(cssJson);
		
		//alert(score);
		//alert(cssForm);
			
	});

 	
</script>
<style type="text/css">

</style>

</head>
<body>
	<div id="expertReviewBody">
		<div id="fullBody">
			
			<img	src="<%=request.getContextPath()%>/images/main/kh_expertReviewPreviewBackground.png"
									width="700px" 
									height="2330px">
		</div>
		
		<div id="carBasicInfoTable">
			<table id="carBasicInfo">
				<tr>
					<td id="carBasicInfoModel" colspan="4">
						${carDetail.brand } &nbsp; 
						${carDetail.model } &nbsp;
						${carDetail.fuel }
					</td>
				</tr>
				
				<tr>
					<td class="carBasicInfocol1">
					</td>
					<td class="carBasicInforow1col24">
						${carDetail.car_num }
					</td>
					<td class="carBasicInfocol3">
					</td>
					<td class="carBasicInforow1col24">
						<c:set var="manu_date" value="${carDetail.manu_date }"/>
						${fn:substring(manu_date,0,2) } 년 / ${fn:substring(manu_date,2,4) } 월
					</td>
				</tr>
				
				<tr>
					<td class="carBasicInfocol1">
					</td>
					<td class="carBasicInforow2col24">
						<fmt:formatNumber 	value="${carDetail.mileage }" 	pattern="#,###,###"/> km
					</td>
					<td class="carBasicInfocol3">
					</td>
					<td class="carBasicInforow2col24">
						${carDetail.accident }
					</td>
				</tr>
				
			</table>
			
		</div>
		
		<div id="mechanicName">${expert.user_name }</div>
		
		
		<div id="gaugeGraph">
		<input type="hidden" id="gaugeGraphScore" value="${experReviewDetail.score }">
			
			<div id="gaugeGraphNeedle"></div>
			<div id="gaugeGraphInnerCircle">
				<table id="gaugeGraphScoreTable">
					<tr>
						<td id="gaugeGraphScoreNumber">
							${experReviewDetail.score }
						</td>
					</tr>
						
					<tr>
						<td>
							<c:set var="inputScore" value="${experReviewDetail.score }"/>
							<c:choose>
								<c:when test="${inputScore gt 80}">
									<span style="font-size:16px; color: bluesky;">Good</span>
								</c:when>
								<c:when test="${inputScore gt 60}">
									<span style="font-size:16px; color: yellowgreen;">Average</span>
								</c:when>
								<c:when test="${inputScore gt 40}">
									<span style="font-size:16px; color: yellow;">Caution</span>
								</c:when>
								<c:otherwise>
									<span style="font-size:16px; color: orange;">Warning</span>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</div>
			
		</div>
		
		<div id="expertComment">
			<table>
				<tr>
					<td>
						<c:set var="inputScore" value="${experReviewDetail.score }"/>
						<c:choose>
							<c:when test="${inputScore gt 80}">
								<span id="expertCommentDetail1">
									구매를 추천드립니다.<br>
								</span>
								<span class="expertCommentDetail">
									★ 상태가 좋은 차량입니다.<br>
									★ 수리와 교환이 필요한 부품이 많지<br>
									&nbsp;&nbsp;&nbsp;않습니다.
								</span>
							</c:when>
							<c:when test="${inputScore gt 60}">
								<span id="expertCommentDetail2">
									구매에 신중하세요.<br>
								</span>
								<span class="expertCommentDetail">
									★ 상태가 양호한 차량입니다.<br>
									★ 수리와 교환이 필요한 부품이 있으니<br>
									&nbsp;&nbsp;&nbsp;판매가를 고려해서 구매하세요.<br>
								</span>
							</c:when>
							<c:when test="${inputScore gt 40}">
								<span id="expertCommentDetail3">
									구매에 주의하세요.<br>
								</span>
								<span class="expertCommentDetail">
									★ 상태가 좋지 않은 차량입니다.<br>
									★ 수리와 교환이 필요한 부품이 많으니<br>
									&nbsp;&nbsp;&nbsp;판매가를 생각해서 구매하세요.<br>
								</span>
							</c:when>
							<c:otherwise>
								<span id="expertCommentDetail4">
									구매를 추천드리지 않습니다.<br>
								</span>
								<span class="expertCommentDetail">
									★ 상태가 불량한 차량입니다.<br>
									★ 전반적인 수리와 교환이 필요하니<br>
									&nbsp;&nbsp;&nbsp;판매가를 생각해서 구매하세요.<br>
								</span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>	
		</div>
		
		<div id=expertReviewBasic>
			<table>
				<c:set var="state" value="${experReviewDetail.ess_state }"/>
				<c:set var="mileage" value="${experReviewDetail.ess_mileage }"/>
				<c:set var="regi" value="${experReviewDetail.ess_regi }"/>
				<tr>
					<td width="400px;">
					</td>
					<td class="expertReviewBasicContent">
						<c:choose>
							<c:when test="${state eq 1}">
								<span class="expertReviewDetail1">
									이상없음
								</span>
							</c:when>
							<c:otherwise>
								<span class="expertReviewDetail3">
									확인필요
								</span>
							</c:otherwise>
						</c:choose>
					</td>				
				</tr>
				
				<tr>
					<td width="400px;">
					</td>
					<td class="expertReviewBasicContent">
						<c:choose>
							<c:when test="${mileage eq 1}">
								<span class="expertReviewDetail1">
									평균이하
								</span>
							</c:when>
							<c:when test="${mileage eq 2}">
								<span class="expertReviewDetail2">
									평균
								</span>
							</c:when>
							<c:otherwise>
								<span class="expertReviewDetail3">
									평균초과
								</span>
							</c:otherwise>
						</c:choose>
					</td>				
				</tr>
				
				<tr>
					<td width="400px;">
					</td>
					<td class="expertReviewBasicContent">
						<c:choose>
							<c:when test="${regi eq 1}">
								<span class="expertReviewDetail1">
									이상없음
								</span>
							</c:when>
							<c:otherwise>
								<span class="expertReviewDetail3">
									확인필요
								</span>
							</c:otherwise>
						</c:choose>
					</td>				
				</tr>
			</table>
		</div>
		
		<div id="expertReviewSummary">
				${experReviewDetail.content }
		</div>
		
		<div id="expertReviewExpendables">
			<table>
				<c:set var="egine_oil"	value="${experReviewDetail.egine_oil }"/>
				<c:set var="brake_oil" 	value="${experReviewDetail.brake_oil }"/>
				<c:set var="coolant" 	value="${experReviewDetail.coolant }"/>
				<c:set var="tire" 		value="${experReviewDetail.tire }"/>
				<c:set var="brake_pad" 	value="${experReviewDetail.brake_pad }"/>
				
				<tr>
					<td width="400px;">
					</td>
					<td class="expertReviewBasicContent">
						<c:choose>
							<c:when test="${egine_oil eq 1}">
								<span class="expertReviewDetail1">
									상태양호
								</span>
							</c:when>
							<c:otherwise>
								<span class="expertReviewDetail3">
									점검필요
								</span>
							</c:otherwise>
						</c:choose>
					</td>				
				</tr>
				
				<tr>
					<td width="400px;">
					</td>
					<td class="expertReviewBasicContent">
						<c:choose>
							<c:when test="${brake_oil eq 1}">
								<span class="expertReviewDetail1">
									상태양호
								</span>
							</c:when>
							<c:otherwise>
								<span class="expertReviewDetail3">
									점검필요
								</span>
							</c:otherwise>
						</c:choose>
					</td>				
				</tr>
				
				<tr>
					<td width="400px;">
					</td>
					<td class="expertReviewBasicContent">
						<c:choose>
							<c:when test="${coolant eq 1}">
								<span class="expertReviewDetail1">
									상태양호
								</span>
							</c:when>
							<c:otherwise>
								<span class="expertReviewDetail3">
									점검필요
								</span>
							</c:otherwise>
						</c:choose>
					</td>				
				</tr>
				
				<tr>
					<td width="400px;">
					</td>
					<td class="expertReviewBasicContent">
						<c:choose>
							<c:when test="${tire eq 1}">
								<span class="expertReviewDetail1">
									상태양호
								</span>
							</c:when>
							<c:otherwise>
								<span class="expertReviewDetail3">
									점검필요
								</span>
							</c:otherwise>
						</c:choose>
					</td>				
				</tr>
				
				<tr>
					<td width="400px;">
					</td>
					<td class="expertReviewBasicContent">
						<c:choose>
							<c:when test="${brake_pad eq 1}">
								<span class="expertReviewDetail1">
								상태양호
								</span>
							</c:when>
							<c:otherwise>
								<span class="expertReviewDetail3">
									점검필요
								</span>
							</c:otherwise>
						</c:choose>
					</td>				
				</tr>
			</table>
		</div>
	</div>	

</body>
</html>