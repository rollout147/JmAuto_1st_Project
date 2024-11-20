<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<link href="../css/join.css" rel="stylesheet" type="text/css">
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>전문가 자격인증</title>
	</head>
	<style>
		/* Date 입력 필드 스타일 */
		input[type="date"],
		input[type="file"] {
			font-family: "Pretendard", sans-serif;
			/* 원하는 글씨체로 설정 */
			font-size: 16px;
			/* 글씨 크기 설정 */
			color: #333;
			/* 글씨 색상 설정 */
		}

		#fileUploadName {
			font-family: "Pretendard", sans-serif;
			/* 원하는 글씨체로 설정 */
			font-size: 16px;
			/* 글씨 크기 설정 */
			color: #333;
			/* 글씨 색상 설정 */
		}


		#fileUpload {
			position: absolute;
			width: 0;
			height: 0;
			padding: 0;
			overflow: hidden;
			border: 0;
		}

		.form-group label[for="fileUpload"] {
			margin-left: 20px;
			/* 버튼의 배경색을 주황색으로 설정합니다. */
			background-color: #ff4714;
			margin-right: 0;
			/* 버튼의 글씨 색을 흰색으로 설정합니다. */
			color: #fff;
			/* 버튼의 기본 테두리를 제거합니다. */
			border: none;
			/* 입력 필드의 내부 여백을 설정합니다. */
			padding: 8px;
			text-align: center;
			font-weight: bold;
			height: 20px;
			font-size: 15px;

		}

		footer {
			position: relative;
			top: 400px;
		}
	</style>

	<script type="text/javascript" src="/js/jquery.js"></script>
	<script>

		function chkValue() {
			var certNum = $("#cert_num").val().trim();
			var certName = $("#cert_name").val().trim();
			var certLoc = $("#cert_loc").val().trim();
			var certDate = $("#cert_date").val().trim();
			var fileUpload = $("#fileUpload").val().trim();

			var certNumCheckMessage = $("#certNumCheckMessage");
			var certNameCheckMessage = $("#certNameCheckMessage");
			var certLocCheckMessage = $("#certLocCheckMessage");
			var certDateCheckMessage = $("#certDateCheckMessage");
			var certFileCheckMessage = $("#certFileCheckMessage");

			var isValid = true;

			// 자격증 번호 유효성 검사 (11자리 숫자 + 대문자 1자리)
			var certNumRegex = /^[0-9]{11}[A-Z]$/;

			if (certNum === "") {
				certNumCheckMessage.text("자격증 번호를 입력해주세요").css("color", "red");
				$("#cert_num").focus();
				isValid = false;
				return false;
			} else if (!certNumRegex.test(certNum)) {
				certNumCheckMessage.text("11자리 숫자와 대문자 1자리로 입력해주세요").css("color", "red");
				$("#cert_num").focus();
				isValid = false;
				return false;
			} else {
				certNumCheckMessage.text("");
			}

			// 자격증 이름 유효성 검사
			if (certName === "") {
				certNameCheckMessage.text("자격증 이름을 입력해주세요").css("color", "red");
				isValid = false;
				return false;
			} else {
				certNameCheckMessage.text("");
			}

			// 자격증 발행처 유효성 검사
			if (certLoc === "") {
				certLocCheckMessage.text("자격증 발행처를 입력해주세요").css("color", "red");
				isValid = false;
				return false;
			} else {
				certLocCheckMessage.text("");
			}

			// 자격증 발행일 유효성 검사
			if (certDate === "") {
				certDateCheckMessage.text("자격증 발행일을 선택해주세요").css("color", "red");
				isValid = false;
				return false;
			} else {
				certDateCheckMessage.text("");
			}

			// 자격증 파일 업로드 확인
			if (fileUpload === "") {
				certFileCheckMessage.text("자격증 파일을 업로드해주세요").css("color", "red");
				isValid = false;
				return false;
			} else {
				certFileCheckMessage.text("");
			}

			// 모든 유효성 검사를 마친 후 결과 반환
			return isValid;
		}

		//파일 이름 및 확장자 분리 파일 형식 및 용량 제한
		$(function () {
			$("#fileUpload").on('change', function () {
				var fileName = $("#fileUpload").val();
				$("#fileUploadName").val(fileName);
				return;
			}); // 닫는 괄호 수정
		});
	</script>


	<body>
		<header>
			<%@ include file="../header_white.jsp" %>
		</header>
		<div class="contents">
			<div class="content">
				<h1>회원가입</h1>
			</div>
			<div class="content">
				<ul class="join_step">
					<li>
						<img src="<%=request.getContextPath()%>/images/main/joinAgree_after.png">
						<span>약관동의</span>
					</li>
					<li>
						<img src="<%=request.getContextPath()%>/images/main/certInfo.png">
						<span>자격증 인증</span>
					</li>
					<li>
						<img src="<%=request.getContextPath()%>/images/main/joinInfo_before.png">
						<span>회원 정보 입력</span>
					</li>
					<li>
						<img src="<%=request.getContextPath()%>/images/main/joinOk_before.png">
						<span>가입신청</span>
					</li>
				</ul>
			</div>
			<div class="content">
				<div class="container">

					<!-- form -->
					<form method="post" name="frm" action="/view_jm/profJoinInfo_2" enctype="multipart/form-data"
					onsubmit="return chkValue();">

						<!-- 자격증 번호 -->
						<div class="form-group">
							<label for="cert_num">자격증 번호</label>
							<input type="text" id="cert_num" name="cert_num" maxlength="12">
							<p class="check_font" id="certNumCheckMessage"></p>
						</div>

						<!-- 자격증 이름 -->
						<div class="form-group">
							<label for="cert_name">자격증 이름</label>
							<input type="text" id="cert_name" name="cert_name">
							<p class="check_font" id="certNameCheckMessage"></p>
						</div>

						<!-- 자격증 발행처 -->
						<div class="form-group">
							<label for="cert_loc">자격증 발행처</label>
							<input type="text" id="cert_loc" name="cert_loc">
							<p class="check_font" id="certLocCheckMessage"></p>
						</div>

						<!-- 자격증 발행일 -->
						<div class="form-group">
							<label for="cert_date">자격증 발행일</label>
							<input type="date" id="cert_date" name="cert_date">
							<p class="check_font" id="certDateCheckMessage"></p>
						</div>

						<!-- 자격증 파일  -->
						<div class="form-group">
							<label for="file">자격증 파일</label>
							<input name="fileUploadName" id="fileUploadName">
							<label for="fileUpload">파일찾기</label>
							<input type="file" id="fileUpload" name="fileUpload">
							<p class="check_font" id="certFileCheckMessage"></p>
						</div>

						<!-- 제출 버튼 -->
						<div class="form-gruop">
							<div class="moveBtn">
								<a>
									<button id="backBtn" onclick="history.back();">이전</button>
								</a>
								<a href="/view_jm/profJoinInfo_2">
									<button type="submit" id="submitBtn">다음</button>
								</a>
							</div>
						</div>


					</form>
				</div>
			</div>
		</div>
		<footer>
			<%@include file="../footer.jsp" %>
		</footer>
	</body>

	</html>