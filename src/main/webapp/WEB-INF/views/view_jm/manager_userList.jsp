<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="header_continer">
	<%@ include file="../header.jsp"%>
</div>
<div class="menu_continer">
	<%@ include file="../manager_menu.jsp"%>
</div>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	font-family: 'Pretendard';
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

.header_continer {
	position: relative;
	width: 100%;
	top: 0;
	z-index: 1001;
}

.manager_Qna_header_search {
	display: flex;
	position: relative;
}

.manager_Qna_header_search_but {
	position: absolute;
	right: 15px;
	bottom: 10px;
	border: none;
	width: 50px;
	height: 30px;
	box-shadow: 0 0 10px 5px rgb(0, 0, 0, 0.01);
	cursor: pointer;
}

.manager_header_h1 button {
	border: none;
	background-color: #ff4714;
	color: white;
	margin-left: 20px;
	height: 30px;
	font-size: 15px;
}

.manager_header_h1 button:hover {
	border: none;
	background-color: black;
	color: white;
	margin-left: 20px;
	height: 30px;
}

.menu_continer {
	position: fixed;
	top: 0;
	z-index: 1000;
	height: 100vh;
}

.manager_container {
	display: grid;
	grid-template-columns: minmax(auto, 1320px);
	justify-content: center;
	max-width: 100%;
	margin: 0px auto;
	background-color: #f7f7f7;
	height: auto;
}

.manager_menu {
	background: #fdfdfd;
	box-shadow: 0 0 10px 5px rgb(0, 0, 0, 0.06);
	width: 100%;
	max-width: 400px;
	height: auto;
	margin: 40px 0 20px;
}

.manager_header {
	display: flex;
	justify-content: space-between;
	margin: 40px 0 20px;
	align-items: center;
}

.manager_header_h1 {
	font-size: 24px;
	font-weight: 550;
}

.hidden {
	display: none;
	/* 숨기기 위한 클래스 */
}

#addAdminBtn {
	border: none;
	background-color: #ff4714;
	color: #fdfdfd;
	width: 100%;
	max-width: 100px;
	height: 35px;
	font-size: 14px;
	font-weight: bold;
}

#addAdminBtn:hover {
	background-color: #323232;
	color: #fdfdfd;
}

.container {
	background-color: #fafafa;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.container_table {
	background-color: #fdfdfd;
	box-shadow: 0 0 10px 5px rgb(0, 0, 0, 0.06);
	height: auto;
	margin: 0 0 40px;
}

/* 테이블 스타일 */
table {
	padding: 0 20px 5px;
	width: 1280px;
}

th {
	width: 200px;
	color: gray;
	font-weight: bold;
	text-align: center;
	/* 중앙 정렬 */
	padding: 20px 0;
}

td {
	border-top: 0.4px solid #e2e8ee;
	padding: 20px 0;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
	/* 중앙 정렬 */
	color: #323232;
	font-size: 14px;
}

/* 모달 기본 스타일 */
.modal {
	display: none;
	/* 기본적으로 숨김 */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
}

/* 모달 콘텐츠 스타일 */
.modal-content {
	background-color: #fff;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 50%;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.container_nav {
	display: flex;
	width: auto;
}

.but_background {
	background: none;
	border: none;
}


.but_images {
	width: 100%;
	max-width: 21px;
	height: auto;
	cursor: pointer;
}

.form-group {
	margin-bottom: 30px;
	/* 각 폼 그룹의 하단 마진을 설정합니다. */
	display: flex;
	/* 폼 그룹 내의 항목들을 플렉스 박스로 배치합니다. */
	align-items: center;
	/* 폼 그룹 내 항목들을 수직 중앙에 정렬합니다. */
	flex-wrap: wrap;
	/* 줄바꿈을 허용 */
}

.form-group label {
	width: 150px;
	/* 라벨의 너비를 150px로 설정합니다. */
	margin-right: 10px;
	/* 라벨과 입력 필드 사이의 여백을 설정합니다. */
	font-weight: bold;
	/* 라벨의 글씨를 두껍게 설정합니다. */
	font-size: 21px;
}

.form-group input {
	padding: 8px;
	/* 입력 필드의 내부 여백을 설정합니다. */
	border: 1px solid #ccc;
	/* 입력 필드의 테두리 색을 연한 회색으로 설정합니다. */
	height: 20px;
	font-size: 16px;
	width: 500px;
}

.form-group button {
	border: none;
	background-color: #ff4714;
	color: #fdfdfd;
	width: 200px;
	height: 30px;
	font-size: 16px;
}

.paging {
	text-align: center;
	font-size: 20px;
}

.keyword {
	width: 600px;
	border: none;
	padding: 20px;
	box-shadow: 0 0 10px 5px rgb(0, 0, 0, 0.02);
}

.manager_pagination_current {
	background-color: #ff4714;
	color: #fdfdfd;
	/* 텍스트 색상 */
	padding: 5px 10px;
	/* 패딩 추가 */
	border-radius: 5px;
	/* 둥근 모서리 */
	font-weight: bold;
	/* 글씨 두껍게 */
}

.manager_pagination {
	font-size: 16px;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 0 80px;
}

.manager_pagination_a {
	color: #323232;
	margin: 0 5px;
}

.manager_pagination_a_next {
	color: #ff4714;
	text-decoration: underline;
	text-underline-position: under;
	font-weight: 700;
	margin: 0 5px;
}

.manager_pagination_a_back {
	color: #ff4714;
	text-decoration: underline;
	text-underline-position: under;
	font-weight: 700;
	margin: 0 5px;
}

.manager_Qna_header_search {
	display: flex;
	position: relative;
}

.manager_Qna_header_search_but {
	position: absolute;
	right: 15px;
	bottom: 10px;
	border: none;
	width: 50px;
	height: 30px;
	box-shadow: 0 0 10px 5px rgb(0, 0, 0, 0.01);
	cursor: pointer;
}

.td_del_state {
	display: flex;
	justify-content: center;
	align-content: centerl
}

.car_del_state_back1 {
	background-color: #ff4714;
	height: 25px;
	width: 60px;
	display: flex;
	justify-content: center;
	text-align: center;
}

.car_del_state1 {
	font-size: 12px;
	color: #fdfdfd;
	align-items: center;
	margin: 4px
}

/* 삭제시 */
.car_del_state_back2 {
	background-color: #5B4A80;
	height: 25px;
	width: 60px;
	display: flex;
	justify-content: center;
}

.car_del_state2 {
	font-size: 12px;
	color: #fdfdfd;
	align-items: center;
	margin: 4px
}

</style>
</head>
<script>



		// 날짜 포맷팅 함수
		function formatDate(dateString) {
			// dateString이 비어있으면 기본값 반환
			if (!dateString) return "년 월 일";

			// 서버에서 오는 dateString을 Date 객체로 변환
			const date = new Date(dateString);

			// 유효한 날짜인지 확인
			if (isNaN(date.getTime())) {
				console.error("유효하지 않은 날짜:", dateString);
				return "년 월 일"; // 유효하지 않은 경우 기본값 반환
			}

			// 날짜 포맷팅
			const options = { year: 'numeric', month: '2-digit', day: '2-digit' };
			// 'yyyy년 mm월 dd일' 형식으로 변경
			const formattedDate = date.toLocaleDateString('ko-KR', options)
				.replace(/(\d+)\/(\d+)\/(\d+)/, '$1년 $2월 $3일');

			return formattedDate;
		}

		
	// 모달 열기 함수
	function openModal() {
		document.getElementById("adminModal").style.display = "block";
	}

	// 모달 닫기 함수
	function closeModal() {
		document.getElementById("adminModal").style.display = "none";
	}

	// 모달 외부를 클릭했을 때 닫기
	window.onclick = function(event) {
		var modal = document.getElementById("adminModal");
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}
	function userDeactive(userId) {
		if (confirm(userId + " 님의 계정을 비활성화 하겠습니까?")) {
			// 사용자가 "확인"을 누른 경우에만 AJAX 요청을 실행
			$.ajax({
				url : '/view_jm/userDeactive',
				type : 'GET',
				dataType : 'json',
				data : {
					'user_id' : userId
				}, // userId로 데이터 전송
				success : function(response) {
					alert("사용자가 성공적으로 비활성화 되었습니다.");
					location.reload(); // 페이지 새로고침
				},
				error : function(error) {
					console.error("비활성화 중 오류 발생", error);
					alert("삭제 중 오류가 발생했습니다.");
				}
			});
		} else {
			// 사용자가 "취소"를 누른 경우
			alert("비활성화가 취소되었습니다.");
		}
	}

	function userActive(userId) {
		if (confirm(userId + " 님의 계정을 활성화 하겠습니까?")) {
			$.ajax({
				url : '/view_jm/userActive',
				type : 'GET',
				dataType : 'json',
				data : {
					'user_id' : userId
				}, // userId로 데이터 전송
				success : function(response) {
					alert("사용자가 성공적으로 활성화 되었습니다.");
					location.reload(); // 페이지 새로고침
				},
				error : function(error) {
					console.error("활성화 중 오류 발생", error);
					alert("삭제 중 오류가 발생했습니다.");
				}
			});

		} else {
			// 사용자가 "취소"를 누른 경우
			alert("활성화가 취소되었습니다.");
		}
	}

</script>
</head>
<body>

	<!--  컨테이너 ----------------------------------------------------->
	<div class="manager_container">

		<div class="manager_header">
			<div class="manager_header_h1">
				회원목록
				<!-- 사용자 버튼 -->
				<a href="/view_jm/searchUser">
					<button>사용자</button>
				</a> <a href="/view_jm/manager_adminList?&user_type=A">
					<button id="admin">관리자</button>
				</a>
			</div>
			<form action="/view_jm/searchUser"  id="frm" >
				<div class="manager_Qna_header_search">
					<input type="text" name="keyword" class="keyword" id="keyword"
						placeholder="아이디 또는 이름 입력.">
					<button type="submit" class="manager_Qna_header_search_but">검색</button>
				</div>
			</form>
		</div>
		<div class="manager_list">
			<div class="container_table">
				<c:if test="${total>0}">
					<table>
						<thead>
							<tr>
								<th>사용자 유형</th>
								<th>아이디</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>가입일</th>
								<th>작업</th>
								<th>탈퇴 여부</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="users" items="${userList }">
								<tr>
									<td><c:choose>
											<c:when test="${users.user_type == 'P'}">전문가</c:when>
											<c:when test="${users.user_type == 'S'}">판매자</c:when>
											<c:when test="${users.user_type == 'B'}">구매자</c:when>
											<c:when test="${users.user_type == 'A'}">관리자</c:when>
										</c:choose></td>
									<td>${users.user_id }</td>
									<td>${users.user_name }</td>
									<td>${users.user_tel }</td>
									<td>${users.user_email }</td>
									<td><fmt:formatDate value="${users.user_regdate}"
											pattern="yyyy. MM. dd." /></td>
									<td>
										<button class="but_background"
											onclick="userActive('${users.user_id }')">
											<img alt="노출_icon"
												src="<%=request.getContextPath()%>/images/main/노출_icon.png"
												class="but_images">
										</button>
										<button class="but_background"
											onclick="userDeactive('${users.user_id }')">
											<img alt="삭제_icon"
												src="<%=request.getContextPath()%>/images/main/삭제_icon.png"
												class="but_images">
										</button>
									</td>

									<td class="td_del_state"><c:choose>
											<c:when test="${users.del_state == 0 }">
												<div class="car_del_state_back1">
													<div class="car_del_state1">사 용</div>
												</div>
											</c:when>
											<c:when test="${users.del_state == 1 }">
												<div class="car_del_state_back2">
													<div class="car_del_state2">탈 퇴</div>
												</div>
											</c:when>
										</c:choose></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>

				<c:if test="${total == 0}">
					<div>
						<h1>등록된 유저가 없습니다</h1>
					</div>
				</c:if>

			</div>
		</div>
		<!-- 페이징 네비게이션 ------------------------------------- -->
		<div class="manager_pagination">

			<!-- 이전 페이지 ------------------->
			<c:if test="${page.startPage > page.pageBlock}">
				<a id="page" class="manager_pagination_a_back"
					href="/view_jm/searchUser?currentPage=${page.startPage - page.pageBlock > 0 ? page.startPage - page.pageBlock : 1}&total=${total}&keyword=${keyword}">
					이전 </a>
			</c:if>


			<!-- 현재 페이지 ------------------->
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<c:choose>
					<c:when test="${i == page.currentPage}">
						<span class="manager_pagination_current">${i}</span>
					</c:when>
					<c:otherwise>
						<a id="page" class="manager_pagination_a"
							href="/view_jm/searchUser?currentPage=${i}&total=${total}&keyword=${keyword}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<!--  다음 페이지 -------------------->
			<c:if test="${page.endPage < page.totalPage}">
				<a class="manager_pagination_a_next" id="page"
					href="/view_jm/searchUser?currentPage=${page.startPage+page.pageBlock}&total=${total}&keyword=${keyword}">다음</a>
			</c:if>
		</div>
	</div>



</body>

</html>