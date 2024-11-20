<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<link href="../css/join.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
  

/* 제목 스타일 */
#title {
	position: absolute;
	top: 150px;
	text-align: center;
	color: #313131;
}

input[type="checkbox"] {
	margin-right: 10px;
	accent-color: #ff4714;
}

.form-group{
    display: flex;
    justify-content: center;

}


.form-group h1{
 text-align: center;

}


.home
{
    text-align: center;
}
#submitBtn{
	position: relative;
	top: 25px;
}

a {
 color: white;
 text-decoration-line: none;

}

footer{
	top : 100px;
}
	
</style>
</head>
<body>
	<div id="wrapper">
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
					<li><img src="<%=request.getContextPath()%>/images/main/joinInfo_after.png"><span>회원정보 입력</span></li>
					<li><img src="<%=request.getContextPath()%>/images/main/joinOk.png"><span>가입신청</span></li>
				</ul>
			</div>

			<div class="content">
				<div class="container">
					<div class="form-group">
                            <h1 id="title">회원가입이 완료되었습니다</h1>
					</div>
					<div class="form-group">
						<div class="moveBtn">
							<button  id="submitBtn">
								<a href="/view_jm/login">로그인</a>
							</button>
						</div>
					</div>
					</div>
				</div>
			</div>
			<footer>
				<%@ include file="../footer.jsp" %>
			</footer>
		</div>
</body>
</html>