<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="../css/join.css" rel="stylesheet" type="text/css">
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<style>
				.container{
			top:200px;
		}


		footer {
			position: relative;
			top: 400px;
		}
	</style>

	<script type="text/javascript" src="/js/jquery.js"></script>
	<script type="text/javascript">
	
	let isAuthCodeVerified = false // 이메일 전송 여부

		$(document).ready(function(){
			$("#user_email1, #user_email2, #user_email3").on("input", function () {
			validateEmail();
		});

		$("#verifyAuthCodeBtn").on("click", verifyAuthCode);

		$("#emailCheckBtn").on("click", emailCheck);
		})
		
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

		if(!validateEmail()) return;

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

			let isValid = true; // 제출 확인 여부 
			
			var auth_code = $("#auth_code").val().trim();

			var verifyAuthCodeMessage = $("#verifyAuthCodeMessage");


			isValid = true;
			
			if (!isAuthCodeVerified) {
				$("#verifyAuthCodeMessage").text("인증번호를 확인 해주세요.").css("color", "red");
				$("#auth_code").focus();
				isValid = false;
				return false;
			}
			
			isValid = true;
		} 




	</script>

	<body>
		<header>
			<%@ include file="../header_white.jsp" %>
		</header>
		<div class="contents">
			<div class="content">
				<h1>비밀번호 찾기</h1>
			</div>
			<div class="content">
				<div class="container">
					<form method="post" name="frm" action="/view_jm/findPw" onsubmit="return chkValue();">

						<!-- 아이디 -->
						<div class="form-group">
							<label for="user_id">아이디</label> 
							<input type="text" id="user_id" name="user_id"	required="required">
						</div>

						<div class="form-group">
							<label for="user_email">이메일</label>
							<input type="text" id="user_email1" name="user_email1" style="width: 30px; required="required">
							&nbsp;@&nbsp;
							<input type="text" id="user_email3" name="selboxDirect" />
							<select id="user_email2" name="email_domain">
								<option value="naver.com">naver.com</option>
								<option value="naver.com">daum.net</option>
								<option value="naver.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="direct">직접입력</option>
							</select>
							<button type="button" id="emailCheckBtn">인증번호 전송</button>
							<p class="check_font" id="emailCheckMessage"></p>
							<!-- hidden input to hold the full email value -->
							<input type="hidden" id="hidden_user_email" name="user_email" required="required"/>
						</div>

						<!-- 이메일 인증 번호 -->
						<div class="form-group">
							<label for="auth_code">인증번호</label>
							<input type="text" id="auth_code" name="auth_code">
							<button type="button" id="verifyAuthCodeBtn">인증번호 확인</button>
							<p class="check_font" id="verifyAuthCodeMessage"></p>
						</div>
						<!-- 제출 버튼 -->
						<div class="form-gruop">
							<div class="moveBtn">
								<a href="/view_jm/findPw"><button type="submit" id="submitBtn">회원정보 확인</button></a>
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