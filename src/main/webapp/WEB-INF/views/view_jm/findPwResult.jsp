<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<link href="../css/join.css" rel="stylesheet" type="text/css">


	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<style>
		.container {
			top: 200px;
			justify-content: center;
			align-content: center;
		}

		.form-group #userCheckMessage {
			text-align: center;
			color: gray;
			font-size: 20px;
			height: auto;
			position: relative;
			left: 10%;
		}

		.form-group button {
			position: relative;
			left: 45%;
		}

		.form-group span {
			text-align: center;
			color: gray;
			font-size: 20px;
		}
	</style>
	<script type="text/javascript" src="/js/jquery.js"></script>

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
					<form action="/view_jm/tempPassword" method="post">
						<input type="hidden" name="user_id" value="${user_id}">
						<div class="form-group">
							<label for="userCheck"></label>
							<span id="userCheckMessage">${userCheckMessage}</span>
						</div>

						<c:choose>
							<c:when test="${not empty user_id}">
								<div class="form-group">
									<div class="moveBtn">
										<!-- 사용자가 확인되었으면 임시 비밀번호 발급 버튼 표시 -->
										<a href="/view_jm/tempPassword">
											<button type="submit" id="submitBtn">임시비밀번호 이메일로 발급하기</button>
										</a>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<!-- 사용자가 확인되지 않았으면 비밀번호 찾기로 이동하는 버튼 표시 -->
								<div class="form-group">
									<div class="moveBtn">
										<a href="/view_jm/findPw">
											<button type="button">다시 비밀번호 찾기</button>
										</a>
									</div>
								</div>

							</c:otherwise>
						</c:choose>
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