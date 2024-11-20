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

		
		.form-group {
			display: flex;
			/* 폼 그룹 내의 항목들을 플렉스 박스로 배치합니다. */
			margin-bottom: 25px;

		}

		.form-group #userCheckMessage {
			text-align: center;
			color: gray;
			font-size: 20px;
			height: auto;
		}

		div #user {
			flex: 1;
			display: flex;
			justify-content: center;
			align-items: center;
			background-color: #cdcdcd;
			height: 30px;
			font-size: 20px;
		}
		span #user_id {
			color : black;
			text-align: center;

		}

		
		footer{
			position: relative;
			top: 50px;

		}
	</style>
	<script type="text/javascript" src="/js/jquery.js"></script>

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
					<div class="form-group">
						<label for="userCheck"></label>
						<span id="userCheckMessage">${userCheckMessage}</span>
					</div>
					<div class="form-group">
						<c:choose>
							<c:when test="${not empty find_id}">
								<!-- 1.사용자가 확인 되었으면 아이디를 알려주기-->
								<label for="user_id">아이디</label>
								<div name="userid" id="user"><span id="user_id">${find_id}</span></div>
					</div>
					<!-- 2. 로그인 페이지 or 비밀번호 찾기 페이지 이동  -->
					<div class="form-group">
						<div class="moveBtn">
							<a href="/view_jm/login">
								<button id="backBtn">로그인</button>
							</a>
							<a href="/view_jm/findPw">
								<button id="submitBtn">비밀번호 찾기</button>
							</a>
						</div>
					</div>
					</c:when>
					<c:otherwise>
						<!-- 사용자가 확인되지 않은 경우 아이디 찾기 페이지로 다시 이동 -->
						<div class="form-group">
							<div class="moveBtn">
								<a href="/view_jm/findId.jsp">
									<button id="submitBtn" style="position: relative;left: 180px;">다시 아이디 찾기</button>
								</a>
							</div>
						</div>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		</div>
		</div>
		</div>
		</div>
		<footer>
			<%@ include file="../footer.jsp" %>
		</footer>
	</body>

	</html>