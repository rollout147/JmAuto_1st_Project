<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<link href="../css/join.css" rel="stylesheet" type="text/css">
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>기업회원 자격인증</title>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
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
		<script src="../js/jquery.js"></script>
		<script>

			function chkValue() {

				var buzNum = $("#buz_num").val().trim();
				var buzName = $("#buz_name").val().trim();
				var buzAddr = $("#buz_addr").val().trim();
				var fileUpload = $("#fileUpload").val().trim();


				var buzNumCheckMessage = $("#buzNumCheckMessage");
				var buzNameCheckMessage = $("#buzNameCheckMessage");
				var buzAddrCheckMessage = $("#buzAddrCheckMessage");
				var buzFileCheckMessage = $("#buzFileCheckMessage");

				var isValid = true;

				// 사업자 번호 유효성 검사 (10자리 숫자)
				var buzNumRegex = /^\d{3}-\d{2}-\d{5}$/;

				if (buzNum === "") {
					buzNumCheckMessage.text("사업자 번호를 입력해주세요").css("color", "red");
					$("#buz_num").focus();
					isValid = false;
					return false;
				} else if (!buzNumRegex.test(buzNum)) {
					buzNumCheckMessage.text("10자리 숫자를 입력해주세요").css("color", "red");
					$("#buz_num").focus();
					isValid = false;
					return false;
				}
				else {
					buzNumCheckMessage.text("");  // 입력이 있으면 에러 메시지 초기화
				}


				// 사업자 상호명 유효성 검사
				if (buzName === "") {
					buzNameCheckMessage.text("사업자 상호명을 입력해주세요").css("color", "red");
					$("#buz_name").focus();
					isValid = false;
					return false;
				} else {
					buzNameCheckMessage.text("");  // 입력이 있으면 에러 메시지 초기화
				}


				if (buzAddr === "") {
					buzAddrCheckMessage.text("사업자 주소를  입력해주세요").css("color", "red");
					$("#buz_addr").focus();
					isValid = false;
					return false;
				} else {
					buzAddrCheckMessage.text("");  // 입력이 있으면 에러 메시지 초기화
				}

				// 파일이 첨부되지 않았을 때 (fileUpload 필드 확인)
				if (fileUpload === "") {
					buzFileCheckMessage.text("사업자 등록증을 첨부해주세요").css("color", "red");
					$("#fileUpload").focus();
					isValid = false;
					return false;
				} else {
					buzFileCheckMessage.text("");  // 정상 입력 시 에러 메시지 초기화
				}

				// 모든 검사를 통과하면 true 반환 (폼 제출 가능)
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


			const hypenBuzNum = (target) => {
				// 숫자만 남기고, 최대 10자리까지 입력 가능하도록 함
				target.value = target.value
					.replace(/[^0-9]/g, '') // 숫자 외 문자 제거
					.slice(0, 10);          // 최대 10자리까지만 입력

				// 입력된 값에 맞춰 하이픈 추가
				if (target.value.length > 5) {
					// XXX-XX-XXXXX 형식 (10자리)
					target.value = target.value.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');
				}

			}

			// 예시로 사용할 수 있는 input 필드
			document.getElementById("buz_num").addEventListener("input", function () {
				hypenBuzNum(this);  // 입력 이벤트가 발생할 때마다 함수 호출
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
					<li><img src="<%=request.getContextPath()%>/images/main/joinAgree_after.png"><span>약관동의</span></li>
					<li><img src="<%=request.getContextPath()%>/images/main/buzInfo.png"><span>사업자 정보 입력</span></li>
					<li><img src="<%=request.getContextPath()%>/images/main/joinInfo_before.png"><span>회원 정보 입력</span>
					</li>
					<li><img src="<%=request.getContextPath()%>/images/main/joinOk_before.png"><span>가입신청</span></li>
				</ul>
			</div>
			<div class="content">
				<div class="container">
					<form method="post" name="frm" action="/view_jm/sellerJoinInfo_2" enctype="multipart/form-data"
						onsubmit="return chkValue();">

						<!-- 사업자 번호  -->
						<div class="form-group">
							<label for="buz_num">사업자 번호</label>
							<input type="text" id="buz_num" name="buz_num" maxlength="14" placeholder="-를 제외하고 입력해주세요"
								oninput="hypenBuzNum(this)"> <!-- 하이픈 포함 길이 14 -->
							<p class="check_font" id="buzNumCheckMessage"></p>
						</div>

						<!-- 사업자 상호명 -->
						<div class="form-group">
							<label for="buz_name">사업자 상호명</label>
							<input type="text" id="buz_name" name="buz_name">
							<p class="check_font" id="buzNameCheckMessage"></p>
						</div>

						<!-- 사업자 주소 -->
						<div class="form-group">
							<label for="buz_addr">사업자 주소</label>
							<input type="text" id="buz_addr" name="buz_addr">
							<p class="check_font" id="buzAddrCheckMessage"></p>
						</div>

						<!-- 사업자 등록증  -->
						<div class="form-group">
							<label for="file">사업자 등록증</label>
							<input name="fileUploadName" id="fileUploadName">
							<label for="fileUpload">파일찾기</label>
							<input type="file" id="fileUpload" name="fileUpload">
							<p class="check_font" id="buzFileCheckMessage"></p>
						</div>

						<!-- 제출 버튼 -->
						<div class="form-gruop">
							<div class="moveBtn">
								<a>
									<button id="backBtn"onclick="history.back();">이전</button>
								</a>
								<a href="/view_jm/sellerJoinInfo_2">
									<button type="submit" id="submitBtn">다음</button>
								</a>
							</div>
						</div>


					</form>
				</div>
			</div>
		</div>
		<footer>
			<%@ include file="../footer.jsp" %>
		</footer>
	</body>

	</html>