<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 유형 선택</title>
</head>

<style>
body {
	margin: 0;
	padding: 0;
	background-color: #fafafa;
	font-family: Pretendard;
	min-height: 100vh; /* 화면 높이에 맞추어 최소 높이 설정 */
}
/* 전체 페이지의 기본 배경색과 중앙 정렬을 설정 */
.contents {
	align-items: center;/* 수직 중앙 정렬 */
	height: 100vh; /* 뷰포트 높이 100%로 설정 */
	padding-bottom: 100px;
}


.content {
	display: flex;
	flex-direction: column; /* 세로 방향으로 배치 */
	align-items: center; /* 수평 중앙 정렬 */
	justify-content: center; /* 수직 중앙 정렬 */
}

/* 제목 스타일 */
h1 {
	position: absolute;
	top: 150px;
	text-align: center;
	color: #313131;
}


/* 컨테이너 설정: 박스들을 가로로 나열하고 가운데에 배치 */
.container {
	display: flex; /* Flexbox를 사용하여 박스들을 가로로 나열 */
	justify-content: center; /* 컨테이너 내부의 박스들을 수평으로 중앙 정렬 */
	position: absolute;
	top: 250px;
	align-items: center; /* 박스들을 수직으로 중앙 정렬 */
	gap: 40px; /* 박스들 사이의 간격 */
	height: 600px;
	width: 1000px;
	padding: 40px; /* 컨테이너 내부 여백 */
	background-color: #fdfdfd; /* 박스 배경색 */
	box-shadow: 0 0 10px 5px rgb(0,0,0,0.06);
	margin: 70px 0;
}

/* 각 박스의 기본 스타일 설정 */
.box {
	border: 2px solid #ff4714; /* 박스 테두리 색상 및 두께 */
	padding: 20px; /* 박스 내부 여백 */
	width: 200px; /* 박스 너비 */
	text-align: center; /* 텍스트 중앙 정렬 */
	cursor: pointer; /* 마우스 커서를 손 모양으로 변경 */
	transition: transform 0.2s; /* 박스 확대 효과에 대한 부드러운 전환 */
	color: #ff4714;
	height: 200px;
}

/* 박스에 마우스를 올리면 확대되는 효과 */
.box:hover {
	transform: scale(1.05); /* 박스를 1.05배 확대 */
}

/* 박스 내부 이미지의 기본 스타일 설정 */
.box img {
	width: 70px; /* 이미지의 너비를 박스 너비에 맞게 설정 */
	height: 70px; /* 이미지의 비율을 유지 */
	margin-top: 20px; /* 이미지와 위 텍스트 사이의 간격 */
}

a {
	text-decoration: none;
}

h2 {
	font-weight: bold;
	font-size: 25px;
}

h3 {
	color: grey
}
</style>
<body>
	<header>
		<%@ include file="../header_white.jsp"%>
	</header>
	<div class="contents">
		<div class="content">
			<h1>회원가입</h1>
		</div>
		<div class="content">
			<div class="container">
				<a href="/view_jm/buyerJoinAgree">
					<div class="box">
						<h2>개인회원</h2>
						<h3>가입하기</h3>
						<img src="<%=request.getContextPath()%>/images/main/buyer_icon.png" alt="개인사용자">
					</div>
				</a> <a href="/view_jm/sellerJoinAgree">
					<div class="box">
						<h2>기업회원</h2>
						<h3>가입하기</h3>
						<img src="<%=request.getContextPath()%>/images/main/seller_icon.png" alt="기업사용자">
					</div>
				</a> <a href="/view_jm/profJoinAgree">
					<div class="box">
						<h2>전문가</h2>
						<h3>가입하기</h3>
						<img src="<%=request.getContextPath()%>/images/main/prof_icon.png" alt="전문사용자">
					</div>
				</a>
			</div>
		</div>
	</div>
	<footer>
		<%@ include file="../footer.jsp"%>
	</footer>
</body>
</html>