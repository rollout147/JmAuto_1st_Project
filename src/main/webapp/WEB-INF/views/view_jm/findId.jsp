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
		
		$(function () {
			//직접입력 인풋박스 기존에는 숨어있다가
			$("#user_email3").hide();
			$("#user_email2").change(function () {
				//직접입력을 누를 때 나타남
				if ($("#user_email2").val() == "direct") {
					$("#user_email3").show();
					$("#user_email2").css("width", "22px")
				} else {
					$("#user_email3").hide();
					$("#user_email2").css("width", ""); // 기본 크기로 되돌림
				}
			})
		});

		// 이메일 유효성 확인 및 전체 이메일을 user_email로 설정
		function validateEmail() {
			// const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일: 기본적인 이메일 형식
			var email = $("#user_email1").val().trim();
			var emailDomain = $("#user_email2").val(); // 지정된 도메인 값
			var emailDirect = $("#user_email3").val().trim(); // 직접 입력한 도메인 값

			if (emailDomain == "direct") {
				// 직접 입력된 도메인 사용 
				emailDomain = emailDirect;
			}
			// 이메일 전체 합치기
			var fullEmail = email + "@" + emailDomain;
			var emailCheckMessage = $("#email_check");

			// 에러 메시지 초기화
			emailCheckMessage.text("");

			// 이메일 유효성 검사 정규식
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

			if (!emailRegex.test(fullEmail)) {
				showError("유효한 이메일 주소를 입력해주세요.", "#email_check");
				return false;
			}

			// 이메일이 유효하면 hidden input에 값을 설정
			$("#hidden_user_email").val(fullEmail);

			return true;
		}



		function emailCheck() {
    var emailCheckMessage = $("#email_check");

	// 이메일 유효성 검사 및 hidden_user_email 설정
    if (!validateEmail()) {
        emailCheckMessage.text("유효한 이메일 주소를 입력해주세요.").css("color", "red");
        return; // 이메일이 유효하지 않으면 종료
    }

    // hidden_user_email 값 확인
    var email = $("#hidden_user_email").val();
    if (email === "") {
        emailCheckMessage.text("이메일이 입력되지 않았습니다.").css("color", "red");
        return; // 이메일 값이 없으면 종료
    }

    $.ajax({
        url: '/view_jm/sendAuthCode',
        type: 'POST',
        data: { 'user_email': email },  // 이메일 값 전송
        success: function (response) {
            emailCheckMessage.text("인증번호가 전송되었습니다.").css("color", "green");
        },
        error: function () {
            emailCheckMessage.text("인증번호 전송 실패").css("color", "red");
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
					enableSubmit();  // 상태 업데이트 후 submit 버튼 활성화 여부 확인
				},
				error: function () {
					alert("인증번호 확인 중 오류가 발생했습니다.");
				}
			});
		}



		$(document).ready(function () {
			$("#verifyAuthCodeBtn").on("click", verifyAuthCode);
		});

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
				<h1>아이디 찾기</h1>
			</div>
			<div class="content">
			<div class="container">	
					<form method="post" name="frm" action="/view_jm/findId" onsubmit="return chkValue();">
						<div class="form-group">
							<label for="user_name">이름</label>
							<input type="text" id="user_name" name="user_name" required="required">
						</div>
						
						<!-- 이메일  -->
						<div class="form-group">
							<label for="user_email">이메일</label>
							<input type="text" id="user_email1" name="user_email1" style="width: 30px; required="required">
							&nbsp;@&nbsp;
							<input type="text" id="user_email3" name="selboxDirect"  />
							<select id="user_email2" name="email_domain">
								<option value="naver.com">naver.com</option>
								<option value="naver.com">daum.net</option>
								<option value="naver.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="direct">직접입력</option>
							</select>
							<button type="button" onclick="emailCheck()" >인증번호 전송</button>
							<p class="check_font" id="email_check"></p>
							<!-- hidden input to hold the full email value -->
							<input type="hidden" id="hidden_user_email" name="user_email" required="required"/>
						</div>

						<!-- 이메일 인증 번호 -->
						<div class="form-group">
							<label for="auth_code">인증번호</label>
							<input type="text" id="auth_code" name="auth_code" required="required">
							<button type="button" id="verifyAuthCodeBtn">인증번호 확인</button>
							<p class="check_font" id="verifyAuthCodeMessage"></p>
						</div>

						<!-- 제출 버튼 -->
						<div class="form-gruop">
							<div class="moveBtn">
								<a href="/view_jm/findId"><button type="submit" id="submitBtn">아이디 찾기</button></a>
							</div>
						</div>
				</div>
				</form>
			</div>
		</div>
		<footer>
			<%@ include file="../footer.jsp" %>
		</footer>
	</body>
	</html>