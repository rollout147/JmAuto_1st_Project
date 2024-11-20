<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<link href="../css/join.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기업회원 개인정보 입력</title>
<style>

	
#user_email3 {
					width: 50px;
				}


				footer {
					top: 1000px;
				}

</style>
<script type="text/javascript" src="../js/jquery.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">


// 이벤트 핸들러
$(document).ready(function () {
	$("#user_id").on("input", function () {
		validateId();
	});
	$("#user_pw").on("input", function () {
		validatePw();
		// 비밀번호를 변경하면 비밀번호 확인 로직도 다시 실행
		validatePwConfirm();
	});
	$("#user_pw_confirm").on("input", function () {
		validatePwConfirm();
	});
	$("#user_name").on("input", function () {
		validateName();
	});
	$("#user_email1, #user_email2, #user_email3").on("input", function () {
		validateEmail();
	});

	$("#verifyAuthCodeBtn").on("click", verifyAuthCode);

	$("#emailCheckBtn").on("click", emailCheck);


})

// 주소찾기 다음 api
function findAddr() {
	new daum.Postcode({
		oncomplete: function (data) {
			var roadAddr = data.roadAddress;
			var jibunAddr = data.jibunAddress;
			document.getElementById('user_zipcode').value = data.zonecode;
			if (roadAddr !== '') {
				document.getElementById("user_addr1").value = roadAddr;
			} else if (jibunAddr !== '') {
				document.getElementById("user_addr2").value = jibunAddr;
			}
			// 상세 주소에 자동 포커스
			document.getElementById("user_addr2").focus();
		}
	}).open();
}

let isValid = true; // 제출 확인 여부
let isIdConfirmed = false; // 아이디 중복 확인 여부
let isAuthCodeVerified = false // 이메일 전송 여부


// 아이디 유효성 확인
function validateId() {
	// 아이디 정규 표현식
	const idRegex = /^[a-z][a-z0-9_]{3,11}$/; // 아이디: 소문자, _, 4~12글자
	var id = $("#user_id").val().trim();
	var idCheckMessage = $("#idCheckMessage");

	idCheckMessage.text(""); // 에러 메시지 초기화
	isValid = true; // 초기화

	if (id === "") {
		idCheckMessage.text("아이디를 입력해주세요.").css("color", "red");
		$("#user_id").focus();
		isValid = false;
		return false;
	}

	if (id.length < 4 || id.length > 12) {
		idCheckMessage.text("아이디는 4-12자 이내로 입력해주세요.").css("color", "red");
		isValid = false;
	} else if (!idRegex.test(id)) {
		idCheckMessage.text("아이디는 소문자로 시작해야 하며, 소문자, 숫자, _만 포함할 수 있습니다.").css("color", "red");
		isValid = false;
	}

	return isValid; // 결과 반환
}

function confirmId() {
	if (!validateId()) return;

	$.ajax({
		url: '/view_jm/confirmId',
		type: 'GET',
		dataType: 'json',
		data: { 'user_id': $("#user_id").val() },
		success: function (data) {
			var idCheckMessage = $("#idCheckMessage");
			if (data === 1) {
				// 유효하지 않은 경우
				idCheckMessage.text("중복된 아이디 입니다").css("color", "red");
				isIdConfirmed = false;
			} else {
				idCheckMessage.text("사용 가능한 아이디입니다.").css("color", "green");
				isIdConfirmed = true;
			}
		}
	});
}

// 비밀번호 유효성 확인
function validatePw() {
	const pwRegex = /^[A-Za-z0-9_@!]{6,12}$/; // 비밀번호: 대소문자, 숫자, _, @, !, 6~12글자
	var password = $("#user_pw").val().trim();
	var pwCheckMessage = $("#pwCheckMessage"); // 비밀번호 입력 메시지

	// 초기화
	isValid = true;
	// 에러 메시지 초기화
	pwCheckMessage.text("");

	// 비밀번호가 빈 값인 경우
	if (password === "") {
		pwCheckMessage.text("비밀번호를 입력해주세요.").css("color", "red");
		$("#user_pw_confirm").attr("disabled", true); // 비밀번호 확인 비활성화
		$("#user_pw").focus();
		isValid = false;
		return isValid; // 비밀번호가 비어있으면 바로 반환
	}

	// 비밀번호 길이 확인
	if (password.length < 6 || password.length > 12) {
		pwCheckMessage.text("비밀번호는 6자 이상 12자 이하로 입력해주세요.").css("color", "red");
		$("#user_pw_confirm").attr("disabled", true); // 비밀번호 확인 비활성화
		isValid = false;
		return isValid; // 길이가 잘못된 경우 반환
	}

	// 비밀번호 정규식 확인
	if (!pwRegex.test(password)) {
		pwCheckMessage.text("비밀번호는 대소문자, 숫자, !, _, @ 만 입력해주세요.").css("color", "red");
		$("#user_pw_confirm").attr("disabled", true); // 비밀번호 확인 비활성화
		isValid = false;
		return isValid; // 정규식이 맞지 않으면 반환
	}

	// 비밀번호가 유효하면 비밀번호 확인 활성화 및 성공 메시지 표시
	$("#user_pw_confirm").attr("disabled", false);
	pwCheckMessage.text("사용 가능한 비밀번호입니다.").css("color", "green");

	return isValid;
}


// 비밀번호 확인 유효성 확인
function validatePwConfirm() {
	var password = $("#user_pw").val().trim();
	var passwordConfirm = $("#user_pw_confirm").val().trim();
	var pwConfirmMessage = $("#pwConfirmMessage"); // 비밀번호 확인 메시지

	isValid = true; // 초기화
	pwConfirmMessage.text(""); // 에러 메시지 초기화

	if (passwordConfirm === "") {
		pwConfirmMessage.text("비밀번호 확인을 위해 입력해주세요.").css("color", "red");
		isValid = false
		return isValid;
	}
	if (password !== passwordConfirm) {
		pwConfirmMessage.text("비밀번호가 일치하지 않습니다.").css("color", "red");
		isValid = false;
		return isValid;
	} else {
		pwConfirmMessage.text("비밀번호가 일치합니다.").css("color", "green");
	}

	return isValid;
}


// 이름 유효성 확인 
function validateName() {
	// 정규 표현식 : 한글만 입력 가능
	const nameRegex = /^[가-힣]+$/;

	var name = $("#user_name").val().trim();
	var nameCheckMessage = $("#nameCheckMessage");

	// 초기화
	isValid = true;
	nameCheckMessage.text("");

	if (name === "") {
		nameCheckMessage.text("이름을 입력해주세요").css("color", "red");
		$("#user_name").focus();  // 포커스를 이동
		isValid = false;
		return false; // 유효성 검사 결과 반환
	}
	if (!nameRegex.test(name)) {
		nameCheckMessage.text("한글 이름만 입력 가능합니다.").css("color", "red");
		$("#user_name").focus();  // 포커스를 이동
		isValid = false;
		return false; // 유효성 검사 결과 반환
	}

	return isValid;

}

// 전화번호 유효성 확인
function validateTel() {
	// 전화번호 정규 표현식 : XXX-XXXX-XXXX 형식
	const telRegex = /^\d{2,3}-\d{3,4}-\d{4}$/;

	var tel = $("#user_tel").val().trim().replace(/\s+/g, ''); // 공백 제거
	var telCheckMessage = $("#telCheckMessage");

	// 초기화
	let isValid = true;
	// 에러 메시지 초기화
	telCheckMessage.text("");

	if (tel === "") {
		telCheckMessage.text("전화번호를 입력해주세요").css("color", "red");
		$("#user_tel").focus();
		isValid = false;
		return false;
	}
	if (!telRegex.test(tel)) {
		telCheckMessage.text("전화번호는 XXX-XXXX-XXXX 형식으로 입력해주세요").css("color", "red");
		$("#user_tel").focus();
		isValid = false;
		return false;
	}

	return isValid;
}

const hypenTel = (target) => {
	target.value = target.value
		.replace(/[^0-9]/g, '')
		.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}

function validateAddr() {
	var zipcode = $("#user_zipcode").val().trim();
	var addr1 = $("#user_addr1").val().trim();
	var addr2 = $("#user_addr2").val().trim();
	var zipcodeCheckMessage = $("#zipcodeCheckMessage");
	var addr1CheckMessage = $("#addr1CheckMessage");
	var addr2CheckMessage = $("#addr2CheckMessage");

	isValid = true;

	if (zipcode === "") {
		zipcodeCheckMessage.text("우편번호를 입력해주세요").css("color", "red");
		$("#user_zipcode").focus();
		isValid = false;
		return false;
	}
	if (addr1 === "") {
		addr1CheckMessage.text("주소를 입력해주세요").css("color", "red");
		$("#user_addr1").focus();
		isValid = false;
		return false;
	}
	if (addr2 === "") {
		addr2CheckMessage.text("상세주소를 입력해주세요").css("color", "red");
		$("#user_addr2").focus();
		isValid = false;
		return false;
	}

	return true;
}


// 이메일 직접입력 
$(function () {
	//직접입력 인풋박스 기존에는 숨어있다가
	$("#user_email3").hide();
	$("#user_email2").change(function () {
		//직접입력을 누를 때 나타남
		if ($("#user_email2").val() == "direct") {
			$("#user_email3").show();
			$("#user_email2").css("width", "25px")
		} else {
			$("#user_email3").hide();
			$("#user_email2").css("width", ""); // 기본 크기로 되돌림
		}
	})
});

function validateEmail() {
	var email = $("#user_email1").val().trim();
	var emailDomain = $("#user_email2").val(); // 지정된 도메인 값
	var emailDirect = $("#user_email3").val().trim(); // 직접 입력한 도메인 값
	var emailCheckMessage = $("#emailCheckMessage");

	// 이메일 도메인이 직접 입력인 경우 처리
	if (emailDomain == "direct") {
		emailDomain = emailDirect;
	}

	isValid = true;

	// 이메일이 비어있는지 확인
	if (email === "" || (!emailDomain && emailDomain !== "direct")) {
		emailCheckMessage.text("이메일을 입력해주세요.").css("color", "red");
		$("#user_email1").focus();
		isValid = false;
		return false;
	}

	// 이메일 전체 주소 합치기
	var fullEmail = email + "@" + emailDomain;

	// 정규식으로 이메일 유효성 검사
	var emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
	if (!emailRegex.test(fullEmail)) {
		emailCheckMessage.text("유효한 이메일 주소를 입력해주세요.").css("color", "red");
		isValid = false;
		return false;
	}

	emailCheckMessage.text("유효한 이메일입니다.").css("color", "green");
	$("#hidden_user_email").val(fullEmail);
	return true;
}



// 이메일 인증 
function emailCheck() {

	if (!validateEmail()) return;

	var emailCheckMessage = $("#emailCheckMessage");

	$.ajax({
		url: '/view_jm/sendAuthCode',
		type: 'POST',
		data: { 'user_email': $("#hidden_user_email").val() },
		success: function (response) {
			emailCheckMessage.text("인증번호가 전송 되었습니다").css("color", "green");
		},
		error: function () {
			emailCheckMessage.text("인증번호가  전송 실패하였습니다.").css("color", "red");
		}
	});
}

// 인증번호 확인
function verifyAuthCode() {
	var authCode = $("#auth_code").val().trim();
	$.ajax({
		url: '/view_jm/verifyAuthCode',
		type: 'POST',
		data: { 'auth_code': authCode },
		success: function (response) {
			if (response.valid) {
				$("#verifyAuthCodeMessage").text("인증번호가 확인되었습니다.");
				$("#verifyAuthCodeMessage").css("color", "green");
				isAuthCodeVerified = true;
			} else {
				$("#verifyAuthCodeMessage").text("인증번호가 틀렸습니다.");
				$("#verifyAuthCodeMessage").css("color", "red");
				isAuthCodeVerified = false;
			}
		},
		error: function () {
			alert("인증번호 확인 중 오류가 발생했습니다.");
		}
	});
}



function chkValue() {
	var account_name = $("#account_name").val().trim();
	var account_bank = $("#account_bank").val().trim();
	var account_num = $("#account_num").val().trim();


	var accountNumCheckMessage = $("#accountNumCheckMessage");
	var accountNameCheckMessage = $("#accountNameCheckMessage");
	var accountBankCheckMessage = $("#accountBankCheckMessage");

	var auth_code = $("#auth_code").val().trim();

	var verifyAuthCodeMessage = $("#verifyAuthCodeMessage");


	isValid = true;

	if (!validateId() || !validatePw() || !validatePwConfirm() || !validateName() || !validateTel() || !validateEmail() || !validateAddr()) {
		return false; // 유효하지 않으면 폼 제출 중단
	}

	// 중복 확인 상태 체크
	if (!isIdConfirmed) {
		$("#idCheckMessage").text("아이디 중복 확인을 해주세요.").css("color", "red");
		$("#user_id").focus();
		return false; // 중복 확인이 안 되었으므로 제출 금지
	}

	if (!isAuthCodeVerified) {
		$("#verifyAuthCodeMessage").text("인증번호를 확인 해주세요.").css("color", "red");
		$("#auth_code").focus();
		return false;
	}

	if(account_name === ""){
		accountNameCheckMessage.text("예금주를 입력해주세요").css("color","red");
		$("#account_name").focus();
		isValid = false;
		return false;
	}
	if(account_bank === ""){
		accountBankCheckMessage.text("은행명을 입력해주세요").css("color","red");
		$("#account_bank").focus();
		isValid = false;
		return false;
	}
	if(account_num === ""){
		accountNumCheckMessage.text("계좌번호를 입력해주세요").css("color","red");
		$("#account_num").focus();
		isValid = false;
		return false;
	}


	return isValid;

}


</script>
</head>
<body>
	<header>
		<%@ include file="../header_white.jsp"%>
	</header>
	<div class="contents">
		<div class="content">
			<h1>회원가입</h1>
		</div>
		<div class="content">
			<ul class="join_step">
				<li><img src="<%=request.getContextPath()%>/images/main/joinAgree_after.png"><span>약관동의</span></li>
				<li><img src="<%=request.getContextPath()%>/images/main/buzInfo_after.png"><span>사업자 정보 입력</span></li>
				<li><img src="<%=request.getContextPath()%>/images/main/joinInfo.png"><span>회원 정보 입력</span></li>
				<li><img src="<%=request.getContextPath()%>/images/main/joinOk_before.png"><span>가입신청</span></li>
			</ul>
		</div>
		<div class="content">
			<div class="container">
				<form method="post" name="frm" action="/view_jm/sellerJoinRequest" onsubmit="return chkValue();">

					<!-- 아이디 입력 -->
						<div class="form-group">
							<label for="user_id">아이디</label>
							<input type="text" id="user_id" name="user_id">
							<button type="button" id="id_check_btn" onclick="confirmId()">중복확인</button>
							<p class="check_font" id="idCheckMessage"></p>
						</div>

						<!-- 비밀번호 입력 -->
						<div class="form-group">
							<label for="user_pw">비밀번호</label>
							<input type="password" id="user_pw" name="user_pw">
							<p class="check_font" id="pwCheckMessage"></p>
						</div>

						<!-- 비밀번호 확인 입력 -->
						<div class="form-group">
							<label for="user_pw_confirm">비밀번호 확인</label>
							<input type="password" id="user_pw_confirm" name="user_pw_confirm">
							<p class="check_font" id="pwConfirmMessage"></p>
						</div>

						<!-- 이름 입력 -->
						<div class="form-group">
							<label for="user_name">이름</label>
							<input type="text" id="user_name" name="user_name">
							<p class="check_font" id="nameCheckMessage"></p>
						</div>

						<!-- 휴대폰 번호 입력 -->
						<div class="form-group">
							<label for="user_tel">휴대폰 번호</label>
							<input type="text" id="user_tel" name="user_tel" placeholder="-를 제외하고 입력해주세요"
								oninput="hypenTel(this)">
							<p class="check_font" id="phoneCheckMessage"></p>
						</div>

						<!-- 우편번호 입력 -->
						<div class="form-group">
							<label for="user_zipcode">우편번호</label> <input type="text" id="user_zipcode"
								name="user_zipcode">
							<button type="button" onclick="findAddr()">주소 검색</button>
						</div>

						<!-- 주소 입력 -->
						<div class="form-group">
							<label for="user_addr1">주소</label> <input type="text" id="user_addr1" name="user_addr1">
						</div>

						<!-- 상세주소 입력 -->
						<div class="form-group">
							<label for="user_addr2">상세주소</label> <input type="text" id="user_addr2" name="user_addr2">
						</div>

						<!-- 이메일 입력 -->
						<div class="form-group">
							<label for="user_email">이메일</label>
							<input type="text" id="user_email1" name="user_email1" style="width: 30px;">
							&nbsp;@&nbsp;
							<input type="text" id="user_email3" name="selboxDirect" />
							<select id="user_email2" name="email_domain">
								<option value="naver.com">naver.com</option>
								<option value="naver.com">daum.net</option>
								<option value="naver.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="direct">직접입력</option>
							</select>
							<button type="button" onclick="emailCheck()">인증번호 전송</button>
							<p class="check_font" id="emailCheckMessage"></p>
							<!-- hidden input to hold the full email value -->
							<input type="hidden" id="hidden_user_email" name="user_email" />
						</div>

						<!-- 인증번호 입력 -->
						<div class="form-group">
							<label for="auth_code">인증번호</label>
							<input type="text" id="auth_code" name="auth_code">
							<button type="button" id="verifyAuthCodeBtn">인증번호 확인</button>
							<p class="check_font" id="verifyAuthCodeMessage"></p>
						</div>

						<!-- 예금주 입력 -->
						<div class="form-group">
							<label for="account_name">예금주</label> 
							<input type="text" id="account_name" name="account_name">
							<p class="check_font" id="accountNameCheckMessage"></p>
						</div>

						<!-- 은행명 입력 -->
						<div class="form-group">
							<label for="account_bank">은행명</label> <select name="account_bank" id="account_bank">
								<option value="기업은행">기업은행</option>
								<option value="국민은행">국민은행</option>
								<option value="카카오뱅크">카카오뱅크</option>
								<option value="농협은행">농협은행</option>
								<option value="신한은행">신한은행</option>
								<option value="산업은행">산업은행</option>
								<option value="우리은행">우리은행</option>
								<option value="한국씨티은행">한국씨티은행</option>
								<option value="하나은행">하나은행</option>
								<option value="SC제일은행">SC제일은행</option>
								<option value="경남은행">경남은행</option>
								<option value="광주은행">광주은행</option>
								<option value="iM뱅크">iM뱅크</option>
								<option value="도이치은행">도이치은행</option>
								<option value="뱅크오브아메리카">뱅크오브아메리카</option>
								<option value="부산은행">부산은행</option>
								<option value="산림조합중앙회">산림조합중앙회</option>
								<option value="저축은행">저축은행</option>
								<option value="새마을금고">새마을금고</option>
								<option value="수협은행">수협은행</option>
								<option value="신협중앙회">신협중앙회</option>
								<option value="우체국">우체국</option>
								<option value="전북은행">전북은행</option>
								<option value="제주은행">제주은행</option>
								<option value="중국건설은행">중국건설은행</option>
								<option value="중국공상은행">중국공상은행</option>
								<option value="중국은행">중국은행</option>
								<option value="BNP파리바은행">BNP파리바은행</option>
								<option value="HSBC은행">HSBC은행</option>
								<option value="JP모간체이스은행">JP모간체이스은행</option>
								<option value="케이뱅크">케이뱅크</option>
								<option value="토스뱅크">토스뱅크</option>
							</select>
							<p class="check_font" id="accountBankCheckMessage"></p>
						</div>

						<!-- 계좌번호 입력-->
						<div class="form-group">
							<label for="account_num">계좌번호</label> 
							<input type="text" id="account_num" name="account_num"	placeholder="-를 제외하고 입력해주세요">
							<p class="check_font" id="accountNumCheckMessage"></p>
						</div>


						<!-- 회원가입 버튼 -->
						<div class="form-gruop">
							<div class="moveBtn">
								<a href="/view_jm/profJoinInfo_1"><button id="backBtn"
										onclick="history.back()">이전</button></a>
								<a href="/view_jm/profJoinRequest"><button id="submitBtn">회원가입 신청</button></a>
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