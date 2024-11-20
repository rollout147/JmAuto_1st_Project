<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_S.jsp" %></div>
<%@ include file="../kakao.jsp" %>
<script type="text/javascript" src="../js/jquery.js"></script>
<style type="text/css">
table.List {
    width: 100%;                /* 테이블 폭을 100%로 설정 */
    border-collapse: collapse;  /* 경계선 겹치기 제거 */
    margin-top: 0;
}
.List tbody {
    display: block;              /* tbody를 블록으로 변경 */
}
.chu-img {
    width: 400px;
    height: auto;
    margin: 20px;
}
tbody tr {
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.10); /* 아래쪽으로 그림자 효과 */
	margin-bottom: 10px; /* 간격 조정 */
	margin-left: 100px;
}
.chu-title2{
	width: 500px;
}
</style>
<script type="text/javascript">
	/* 체크박스 함수 */
	function handleSubmit(){
		const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
		//querySelectorAll이라는 메서드를 사용해 현재 문서에 체크된 :checked요소를 모두 선택해 결과를 nodeList로 반환
		const selectedPosts = Array.from(checkboxes).map(checkbox => parseInt(checkbox.value));
		//map 메서드를 사용해 checkbox.value를 호출해 체크박스 값을 수집

		if(selectedPosts.length===0){
			alert('삭제할 게시물을 선택해주세요');
			return;
		}
		//서버에 삭제요청을 보낸다.
		$.ajax({
			url: '/sellCarDelete',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(selectedPosts),
			success: function(response){
				alert('선택한 게시물이 삭제되었습니다.');
				location.reload();
			},
			error: function(xhr, status, error){
				alert('삭제실패:' + xhr.statusText);
			}
		});
	}
	function toggleCheckbox(checkboxId, imgElement) {
	    const checkbox = document.getElementById(checkboxId);
	    checkbox.checked = !checkbox.checked; // 체크 상태를 반전

	    // 이미지 변경 (체크된 상태와 체크되지 않은 상태에 따라)
	    if (checkbox.checked) {
	        imgElement.src = '../images/main/joinOK.png'; // 체크된 상태의 이미지
	    } else {
	        imgElement.src = '../images/main/joinOK_before.png'; // 체크되지 않은 상태의 이미지
	    }
	}
</script>
</head>


<body>
	<div class="container">
		<div class="content_container">
			<div class="content_hed">
				<h1>판매자 판매차량</h1>
			</div>

			<div class="block_1">
				<div class="block_1_text" style="font-size: 32px;">판매중인 차량</div>
				<hr />

				<table class="List">

					<tbody>
						<c:forEach var="Car_General_Info" items="${Car_General_Info}">
							<tr>
								<td><div class="chu_carList2">
										<a href="/carInfo?sellNum=${Car_General_Info.sell_num}&id=${Car_General_Info.user_id}">
											<img src="${Car_General_Info.img_url }" class="cardlist_img_src">
									</div></td>

								<td><div class="chu_body_all2">
										<p class="chu-title2"
											style="font-size: 20px; font-weight: 700; text-align: center;">${Car_General_Info.model}</p>
									</div>

									<div>
										<p class="chu-text2">
											<span style="color: gray; font-size: 16px; margin-left: 40px;">제조년월:
												${Car_General_Info.manu_date}</span> <span style="margin-left: 20px;">|</span>
											<span style="margin-left: 20px;">${Car_General_Info.mileage}km</span> <span
												style="margin-left: 20px;">|</span> <span
												style="margin-left: 20px;">${Car_General_Info.fuel}</span> <span
												style="margin-left: 20px;">|</span> <span
												style="margin-left: 20px;">${Car_General_Info.accident}</span>
										</p>
									</div></td>
								<td style="padding-left: 100px; padding-top: 10px;">
									<div style="position: relative;">
										<input type="checkbox" id="checkbox-${Car_General_Info.sell_num}"
											name="post1" value="${Car_General_Info.sell_num}" style="display: none;">
										<img src="../images/main/joinOK_before.png" alt="체크박스"
											style="cursor: pointer;"
											onclick="toggleCheckbox('checkbox-${Car_General_Info.sell_num}', this)">
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

		</div>
		<div class="button-container"
			style="display: flex; justify-content: flex-end; text-align: right;">
			<img alt="" src="../images/main/삭제_but.png" onclick="handleSubmit()"
				style="cursor: pointer; text-align: right;">
		</div>
		<!--------------------------------------- 푸터 ---------------------------------------->
	<%@ include file="../footer.jsp" %>
</body>
</html>