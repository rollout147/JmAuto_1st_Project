<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/css/carPayment.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5e660012c6487ac925e5d3920ee4c05b&libraries=services"></script>			

<script>

	$(function(){
	    $("#ModifyAddress").change(function(){
	        if($("#ModifyAddress").is(":checked")){
	        	$('#postcode').prop('readonly', false);
	        	$('#address').prop('readonly', false);
	        	$('#detailAddress').prop('readonly', false);
	        	$('#postcodeButton').prop('disabled', false);
	        	$('#postcode').val('');
	        	$('#address').val('');
	        	$('#detailAddress').val('');
	        }else{
	        	$('#postcode').prop('readonly', true);
	        	$('#address').prop('readonly', true);
	        	$('#detailAddress').prop('readonly', true);
	        	$('#postcodeButton').prop('disabled', true);
	        	$('#postcode').val('${buyer.user_zipcode}');
	        	$('#address').val('${buyer.user_addr1}');
	        	$('#detailAddress').val('${buyer.user_addr2}');
	        }
	    });
	});
	
	
	
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("extraAddress").value = extraAddr;
                    $("#extraAddress").val(extraAddr);
                
                } else {
                    //document.getElementById("extraAddress").value = '';
                    $("#extraAddress").val('');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                //document.getElementById('postcode').value = data.zonecode;
                $("#postcode").val(data.zonecode);
                //document.getElementById("address").value = addr;
                $("#address").val(addr);
                // 커서를 상세주소 필드로 이동한다.
                //document.getElementById("detailAddress").focus();
                $("#detailAddress").focus();
            }
        }).open();
    }

	//파일 이름 및 확장자 분리
	// 파일 형식 및 용량 제한	
	$(function() {
		$("#insureFile").on('change', function() {
			var fileName 	= $("#insureFile").val();
			
			var extension 	= fileName.split('.').pop().toLowerCase();
			
			if($.inArray(extension, ['jpg','jpeg','gif','png']) == -1){
				alert("jpg, jpeg, gif, png 파일만 첨부가능합니다.");
				$("#insureFile").val("");
				return;
			} else{
				$("#upload-name").val(fileName);
			}
			
			var maxSize = 10 * 1024 * 1024; // 10MB
		    var fileSize = $("#insureFile")[0].files[0].size;
		    if(fileSize > maxSize){
		    alert("첨부파일 사이즈는 10MB 이내로 등록 가능합니다.");
		    $("#insureFile").val("");
		    return;
		    }
			
		});
	});
	
	// 배송가능일 설정
	// 구매일 기준 월~수 -> 다음주 월~토
	// 구매일 기준 목~일 -> 다다음주 월~토
	$(function() {
		$("#deilveryDate").on('click', function() {
			var offset	= new Date().getTimezoneOffset() * 60000;	// 9시간 밀리세컨드 값
			var today 	= new Date(Date.now() - offset);
			// var today 	= new Date('2024-9-27');

			var minDate = new Date();
			var maxDate = new Date();
			
			if(today.getDay() == '0') {
				minDate.setDate(today.getDate() + 8);
				maxDate.setDate(today.getDate() + 13);
			} else if(today.getDay() == '1') {
				minDate.setDate(today.getDate() + 7);
				maxDate.setDate(today.getDate() + 12);
			} else if(today.getDay() == '2') {
				minDate.setDate(today.getDate() + 6);
				maxDate.setDate(today.getDate() + 11);
			} else if(today.getDay() == '3') {
				minDate.setDate(today.getDate() + 5);
				maxDate.setDate(today.getDate() + 10);
			} else if(today.getDay() == '4') {
				minDate.setDate(today.getDate() + 11);
				maxDate.setDate(today.getDate() + 16);
			} else if(today.getDay() == '5') {
				minDate.setDate(today.getDate() + 10);
				maxDate.setDate(today.getDate() + 15);
			} else {
				minDate.setDate(today.getDate() + 9);
				maxDate.setDate(today.getDate() + 14);
			}

			$("#deilveryDate").prop("min", minDate.toISOString().substring(0,10));
			$("#deilveryDate").prop("max", maxDate.toISOString().substring(0,10));
		});
	});

	
	//카카오맵 구현
	$(function() {

		var mapContainer = document.getElementById('sellerMap'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};
	
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);
	
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
	
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch('${seller.user_addr1}',
				function(result, status) {

				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {

					var coords = new kakao.maps.LatLng(result[0].y,result[0].x);

					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker({
									map : map,
									position : coords
					});

					// 인포윈도우로 장소에 대한 설명을 표시합니다
					var infowindow = new kakao.maps.InfoWindow({
										content : '<div style="width:150px;text-align:center;padding:6px 0;">회사위치</div>'
					});
					infowindow.open(map, marker);

					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);
					}
		});

	});
	
	
	function goPrivateInformation() {
		var url = "/KH/pay/privateInformation";		
		window.open(url, "_blank", 'width=700,height=900,location=no,status=no,scrollbars=no,top=100,left=300');
	}
	
	
	
	function goPay() {
		
		var fileName 	= $("#insureFile").val();
		var delivery	= $("#deilveryDate").val();
		
		// alert("fileName.length -> " + fileName.length);
		// alert("delivery.length -> " + delivery.length);
		
		if(fileName.length == 0) {
			alert("보험가입증명서를 업로드하세요");
			$("#insureFile").focus();
			return false;
		} else if(delivery.length == 0 ) {
			alert("배송일자를 지정하세요");
			$("#deilveryDate").focus();
			return false;;
		} else {		
			alert("결제를 실행합니다");
			$("#byuerInfoForm").submit();
		}
	}
	
	function payCancel() {
		alert("결제를 취소합니다");
		location.href = "/KH/pay/carList";
	}
</script>

</head>
<body>
	<div id="kakaoTalk">
		<%@ include file="../kakao.jsp" %>
	</div>

	<header id="header" style="z-index: 2;">
		<%@ include file="../header_white.jsp"%>
		<span id="pageTitle">차량구매</span>
	</header>

	<div class="container">

		<div class="item:nth-child(1)">
		
		<form id="byuerInfoForm"	action="/KH/pay/readyPay"	method="post"	enctype="multipart/form-data">
			<input	type="hidden"	name="user_id"	value="${buyer.user_id }" />
			<input	type="hidden"	name="sell_num"	value="${carDetail.sell_num }" />
			<input	type="hidden"	name="buy_type"	value="1" /> 
		
			<span id="intro">
				안녕하세요, ${buyer.user_name } 고객님.<br>
				차량구매를 시작하겠습니다.<br>
				차량 정보와 예상 결제 금액을 확인해 주세요.<br>
			</span>
			<table id="carInfo">
				<tr>
					<th id="carInfoLabelLeft">상품정보</th>
					<th id="carInfoLabelRight" colspan="4">내용</th>
				</tr> 
				<tr>
					<td rowspan="2">
						<img	src="${carImagePath}"
								width="250px" 
								height="200px">
					</td>
					<td id="carInfoModel">${carDetail.brand } ${carDetail.model }</td>
				</tr>
				
				<tr>
					<td id="carInfoDetail">
						<c:set var="manu_date" value="${carDetail.manu_date }"/>
						${fn:substring(manu_date,0,2) } 년 / ${fn:substring(manu_date,2,4) } 월&emsp;|&emsp;				
						<fmt:formatNumber 	value="${carDetail.mileage }" 	pattern="#,###,###"/> km &emsp;|&emsp;
						${carDetail.fuel }&emsp;|&emsp;
					    ${seller.user_addr1}
					</td>
				</tr>			
			</table>
		
			<table id="buyer">
				<tr id="buyerRow1">
					<td  colspan="2">
						<a id="title">주문자 정보</a>&emsp;&emsp;
						주문자 정보는 수정이 불가능합니다
						<hr class="innerLine"/>
					</td>
				</tr>	
				
				<tr id="buyerRow2">										
					<td class="tableLeftColumn">이름</td>
					<td>
						<input class="buyerInput" value="${buyer.user_name }" readonly="readonly" />
					</td>					
				</tr>
					
				<tr id="buyerRow3">	
					<td class="tableLeftColumn">연락처</td>
					<td>
						<input class="buyerInput" value="${buyer.user_tel }" readonly="readonly" />	
					</td>
				</tr>		
			</table>
			
			<table id="oder">
				<tr id="oderRow1">
					<td colspan="2">
						<a  id="title">구매 정보</a>&emsp;&emsp;&emsp;
						<input type="checkbox" id="ModifyAddress" />&nbsp;
						배송지를 수정합니다
						<hr class="innerLine"/>
					</td>
				</tr>	
					
				<tr id="oderRow2">										
					<td class="tableLeftColumn">우편번호</td>
					<td>
						<input	type="text" 
								id="postcode"
								name="receiver_zipcode"
								value="${buyer.user_zipcode }" 
								readonly="readonly" />
						<input 	type="button"
								id="postcodeButton" 
								onclick="execDaumPostcode()"
								value="우편번호 찾기"
								disabled="disabled" />						
					</td>					
				</tr>
				
				<tr id="oderRow3">	
					<td class="tableLeftColumn">기본주소</td>
					<td>
						<input	type="text" 
								id="address"
								name="receiver_addr1"
								value="${buyer.user_addr1}" 
								readonly="readonly" />
					</td>
				</tr>
					
				<tr id="oderRow4">	
					<td class="tableLeftColumn">상세주소</td>
					<td>
						<input	type="text" 
								id="detailAddress"
								name="receiver_addr2"
								value="${buyer.user_addr2}" 
								readonly="readonly" />								
						<input	type="text" 
								id="extraAddress" 
								name="receiver_addr3" 
								placeholder="참고항목" />
					</td>
				</tr>
				
				<tr id="oderRow5">	
					<td id="insureFileTitle">보험가입증명서</td>
					<td>					
						<input	id="upload-name"
								placeholder="첨부파일"
								readonly="readonly" 
								required="required" />
						<label 	for="insureFile">파일찾기</label> 
    					<input 	type="file" 
    							id="insureFile"
    							name="insureFile"
    							accept=".jpg, .gif, .png" 
    							required="required" 
    							readonly="readonly" />
    					<br>
    					<p class="insureFileCaption">.jpg, .gif, .png 파일만 첨부가능합니다.</p>
						<p class="insureFileCaption">파일크기는 10MB 이하만 가능합니다.</p>
					</td>
				</tr>
				
				<tr id="oderRow6">	
					<td class="tableLeftColumn">희망배송일</td>
					<td>
						<input	type="date"
								id="deilveryDate" 
								name="delivery_date" 
								required="required" />	
					</td>
				</tr>	
			</table>
			</form>
			
			<div id="paperWorkDiv">
				<table>
					<tr>
						<td class="paperWorkCell"
							onclick="window.open('/KH/pay/carCheck', '성능/상태검검기록부', 'width=1200,height=900,location=no,status=no,scrollbars=no,top=300,left=300')">
							<img	src="<%=request.getContextPath()%>/images/main/kh_Icon_carCheck.png"
									width="100px" 
									height="100px">
						</td>
						<td class="paperWorkCell"
							onclick="window.open('/KH/pay/carRegistration', '자동차등록증', 'width=835,height=550,location=no,status=no,scrollbars=no,top=300,left=300')">
							<img	src="<%=request.getContextPath()%>/images/main/kh_Icon_carRegistration.png"
									width="100px" 
									height="100px">
						</td>
						<td class="paperWorkCell"
							onclick="window.open('/KH/pay/contract?sell_num=${carDetail.sell_num }&user_id=${buyer.user_id }', '자동차양도증명서', 'width=1330,height=1990,location=no,status=no,scrollbars=no,top=300,left=300')">
							<img	src="<%=request.getContextPath()%>/images/main/kh_Icon_contract.png"
									width="100px" 
									height="100px">
						</td>
					</tr>
					<tr>
						<td class="paperWorkCell">
							성능/상태검검기록부
						</td>
						<td class="paperWorkCell">
							자동차등록증
						</td>
						<td class="paperWorkCell">
							자동차양도증명서
						</td>
					</tr>
				</table>
			</div>
			
			
		</div>
			
		<div class="item:nth-child(2)">
			<table id="sellerInfoTable">
				<tr>
					<th id="sellerInfoTitle"	colspan="2">
						판매자위치
					</th>
				</tr>
					<%-- 
					<tr>
						<td id="sellerImageColumn">
							<div id="sellerImage">
								<img	id="sellerImageFile"	
										src="<%=request.getContextPath()%>/images/main/parrot_small.jpg" />
							</div>
						</td>
						<td id="sellerInfoDetail">
							<span id="sellerInfoName">${seller.user_name } 딜러</span>
							<br>
							<span id="sellerInfoComp">${seller.buz_num} (주)</span>
							<br>
							<span id="sellerInfoTele">
								<img	src="<%=request.getContextPath()%>/images/main/kh_icon_tel.png"
										width="30px" 
										height="30px">
								${seller.user_tel }
							</span>
						</td>
					</tr> 
					--%>
				<tr>
					<td colspan="2">
						<div id="sellerMap"></div>
					</td>
				</tr>						
			</table>
			
			<table id="sellerInfoLink">
				<tr>
					<td class="sellerInfoLinkCell">
						<img	src="<%=request.getContextPath()%>/images/main/kh_repair.png"
								width="100px" 
								height="100px">
						<br>
						<a class="sellerInfoLinkCaption">
							보험이력
							<br>
							<c:set var="status"	value="${carDetail.accident }" />
							<c:set var="repair"		value="단순수리" />
							<c:set var="accident"	value="사고" />
							<c:choose>
								<c:when test="${status eq repair}">
									<div	class="sellerInfoLinkCaptionHref"	
											onclick="window.open('https://www.carhistory.or.kr/main.car?realm=', '보험이력조회', 'width=500,height=700,location=no,status=no,scrollbars=yes,top=300,left=300')">
											단순수리
									</div>
								</c:when>
								<c:when test="${status eq accident}">
									<div	class="sellerInfoLinkCaptionHref"	
											onclick="window.open('https://www.carhistory.or.kr/main.car?realm=', '보험이력조회', 'width=500,height=700,location=no,status=no,scrollbars=yes,top=300,left=300')">
											사고
									</div>
								</c:when>
								<c:otherwise>무사고</c:otherwise>
							</c:choose>
						</a>
					</td>
					<td class="sellerInfoLinkCell">
						<img	src="<%=request.getContextPath()%>/images/main/kh_mileage.png" />
						<br>
						<a class="sellerInfoLinkCaption">
							주행거리
							<br>
							<c:set var="mileage" value="${carDetail.mileage }" />
							<c:set var="good" 	 value="60000"  />
							<c:set var="normal"	 value="100000" />
							<c:choose>
								<c:when test="${mileage lt good}">평균미만</c:when>
								<c:when test="${mileage gt normal}">평균초과</c:when>
								<c:otherwise>평균</c:otherwise>
							</c:choose>
						</a>
					</td>
					<td class="sellerInfoLinkCell">
						<img	src="<%=request.getContextPath()%>/images/main/kh_carInfo.png" />
						<br>
						<div class="sellerInfoLinkCaption">
							기본정보
							<br>
							<a 	class="sellerInfoLinkCaptionHref"
								id="sellerInfoPopup"	
								onclick="window.open('/KH/pay/carBasicInfo?sell_num=${carDetail.sell_num }', '차량기본정보', 'width=500,height=600,location=no,status=no,scrollbars=no,top=300,left=300')">
								보기
							</a>								
						</div>
					</td>
				</tr>
			</table>			
		
			<table id="paymentInfoTable">
				<tr>
					<td colspan="2">
						<span id="paymentInfoTele">
							<img	src="<%=request.getContextPath()%>/images/main/kh_icon_tel.png"
									width="40px" 
									height="40px">
							${seller.user_tel }								
						</span>					
						<hr class="innerLine"/>	
					</td>
				</tr>
				<tr>
					<td colspan="2" id="paymentInfoCarName">
						${carDetail.brand }
						<br>
						${carDetail.model }
					</td>
				</tr>
						
				<tr>
					<td colspan="2" id="paymentInfoCarDetail">
						<c:set var="manu_date" value="${carDetail.manu_date }"/>
						${fn:substring(manu_date,0,2) } 년 / ${fn:substring(manu_date,2,4) } 월&emsp;|&emsp;				
						<fmt:formatNumber 	value="${carDetail.mileage }" 	pattern="#,###,###"/> km &emsp;|&emsp;
						${carDetail.fuel }&emsp;|&emsp;
					    ${seller.user_addr1}
					</td>
				</tr>
					
				<tr>
					<th id="paymentSumTitle">합계</th>
					<td id="paymentSumAmount">
						<fmt:formatNumber 	value="${carDetail.price * 11700 + 50000}" 	pattern="#,###,###,###"/>
					 원
					</td>					
				</tr>
				<tr>
					<th class="paymentSumLeft">차량가격</th>
					<td class="paymentSumRight">
						<fmt:formatNumber 	value="${carDetail.price * 10000}" 	pattern="#,###,###,###"/>
					 원
					</td>					
				</tr>
				<tr>
					<th class="paymentSumLeft">세 금</th>
					<td class="paymentSumRight">
						<fmt:formatNumber 	value="${carDetail.price * 1700}" 	pattern="#,###,###,###"/>
					 원
					</td>					
				</tr>
				<tr>
					<th class="paymentSumLeft">대행수수료</th>
					<td class="paymentSumRight">
						<fmt:formatNumber 	value="50000" 	pattern="#,###,###,###"/>
					 원
					</td>					
				</tr>
				<tr>
					<th class="paymentSumPrivate"></th>
					<td class="paymentSumPrivate">
					</td>					
				</tr>
				<tr>
					<th class="paymentSumPrivate" colspan="2">
					<a onclick="goPrivateInformation()" style="cursor: pointer;">개인정보 수집/이용/처리 동의</a>
					<br>
					<br>
					약관 및 주문 내용을 확인하였으며, 정보 제공 등에 동의합니다.</th>
				</tr>
				<tr>
					<td colspan="2">
						<div id="payButton">
							<button	id="btn-kakao"	onclick="goPay()">
								결제요청
							</button>
							<br>
							<button	id="btn-cancel"	onclick="payCancel()">
								결제취소
							</button>
							
						</div>						
					</td>
				</tr>				
			</table>
		<%-- 					
			<h5>아이디 : ${buyer.user_id }</h5>
			<h5>비밀번호 : ${buyer.user_pw }</h5>
			<h5>이름 : ${buyer.user_name }</h5>
			<h5>전화번호 : ${buyer.user_tel }</h5>
			<h5>우편번호 : ${buyer.user_zipcode }</h5>
			<h5>주소1 : ${buyer.user_addr1}</h5>
			<h5>주소2 : ${buyer.user_addr2}</h5>
			<h5>이메일 : ${buyer.user_email}</h5>
			<h5>등록일 : ${buyer.user_regdate}</h5>
			<h5>사업자번호 : ${buyer.buz_num}</h5>
			<h5>자격증번호 : ${buyer.cert_num}</h5>
			<h5>등급 : ${buyer.user_level}</h5>
			<h5>유형 : ${buyer.user_type }</h5>
			<h5>삭제여부 : ${buyer.del_state }</h5>
			<h5>승인여부 : ${buyer.approval }</h5>
			
			
			
			<h5>매물번호 : ${carDetail.sell_num }</h5>
			<h5>차종 : ${carDetail.car_type }</h5>
			<h5>제조사 : ${carDetail.brand }</h5>
			<h5>모델 : ${carDetail.model }</h5>
			<h5>차량번호 : ${carDetail.car_num }</h5>
			<h5>제조일 : ${carDetail.manu_date }</h5>
			<h5>주행거리 : ${carDetail.mileage }</h5>
			<h5>색상 : ${carDetail.color }</h5>
			<h5>연료 : ${carDetail.fuel }</h5>
			<h5>변속기 : ${carDetail.transmission }</h5>
			<h5>사고유무 : ${carDetail.accident }</h5>
			<h5>압류유무 : ${carDetail.repossession }</h5>
			<h5>차량가격 : ${carDetail.price * 11700} 원</h5>
			<h5>자동차등록증경로 : ${carDetail.sell_regi }</h5>
			<h5>자동차세완납증명서경로 : ${carDetail.sell_certi_tax }</h5>
			<h5>신분증사본 경로 : ${carDetail.sell_shinbun }</h5>
			<h5>판매자 아이디 : ${carDetail.user_id }</h5>
			<h5>판매여부 : ${carDetail.sale }</h5>
			<h5>등록일자 : ${carDetail.reg_date }</h5>
			<h5>삭제여부 : ${carDetail.del_state }</h5>

			<h1>판매자정보</h1>
			<h5>아이디 : ${seller.user_id }</h5>
			<h5>비밀번호 : ${seller.user_pw }</h5>
			<h5>이름 : ${seller.user_name }</h5>
			<h5>전화번호 : ${seller.user_tel }</h5>
			<h5>우편번호 : ${seller.user_zipcode }</h5>
			<h5>주소1 : ${seller.user_addr1}</h5>
			<h5>주소2 : ${seller.user_addr2}</h5>
			<h5>이메일 : ${seller.user_email}</h5>
			<h5>등록일 : ${seller.user_regdate}</h5>
			<h5>사업자번호 : ${seller.buz_num}</h5>
			<h5>자격증번호 : ${seller.cert_num}</h5>
			<h5>등급 : ${seller.user_level}</h5>
			<h5>유형 : ${seller.user_type }</h5>
			<h5>삭제여부 : ${seller.del_state }</h5>
			<h5>승인여부 : ${seller.approval }</h5>
 			--%>
		</div>
		
		
	</div>
		
	<footer id="footer"">
		<%@ include file="../footer.jsp"%>	
	</footer>

</body>

</html>

