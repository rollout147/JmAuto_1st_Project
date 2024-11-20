<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../header_white.jsp" %>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
	}
	
    body {
	margin: 0;
	padding: 0;
	background-color: #fafafa ;
	font-family: Pretendard;
	min-height: 100vh; /* 화면 높이에 맞추어 최소 높이 설정 */
	font-family: 'Pretendard-Regular';
    font-weight: 400;
    font-style: normal;
}

.contents {
	/* 수직 중앙 정렬 */
	align-items: center;
	height: 100vh; /* 뷰포트 높이 100%로 설정 */
}

.content {
	display: flex;
	flex-direction: column; /* 세로 방향으로 배치 */
	align-items: center; /* 수평 중앙 정렬 */
	justify-content: center; /* 수직 중앙 정렬 */
	width: 1000px;
    margin: 0 auto;
}

/* 제목 스타일 */
#title {
	position: absolute;
	top: 150px;
	text-align: center;
	color: #313131;
}

.join_step {
	display: flex;
	position: absolute;
	/* 플렉스 박스 레이아웃 사용 */
	top: 200px;
	justify-content: center;
	/* 가로 가운데 정렬 */
	list-style: none;
	/* 리스트 스타일 제거 */
	padding: 0;
	/* 기본 패딩 제거 */
	margin-bottom: 30px;
}

.join_step li {
	margin: 0 10px;
	/* 항목 간의 간격 설정 */
	position: relative;
	/* 텍스트 위치를 조정하기 위해 relative 유지 */
}

.join_step li img {
	width: 150px;
	/* 리스트 항목 내 이미지의 크기를 설정 */
}

.join_step li span {
	position: absolute;
	/* 텍스트를 절대 위치로 설정 */
	bottom: 0;
	left: 50%;
	/* 텍스트를 중앙 하단에 위치 */
	color: #666;
	/* 텍스트 색상 설정 */
	line-height: 1.462em;
	/* 텍스트 줄 간격 설정 */
	white-space: nowrap;
	/* 텍스트가 줄바꿈되지 않도록 설정 */
	transform: translate(-50%, 0);
	/* 텍스트를 중앙 정렬 */
}

/* 회원가입 폼을 감싸는 컨테이너 스타일 */
.container {
	position: absolute;
	top: 400px;
	height: 200px;
	padding: 100px; /* 컨테이너 내부 여백 */
	width: 800px;
	background-color: #fdfdfd; /* 박스 배경색 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 박스 그림자 설정 */
}



input[type="checkbox"] {
	margin-right: 10px;
	accent-color: #ff4714;
}

.form-group{
    display: flex;
    justify-content: center;
    margin-bottom: 40px;

}

.form-group h1{
 text-align: center;

}

button {
	text-align: center;
	width: calc(100% - 70%);
	/* 제출 버튼의 너비를 컨테이너 너비에서 20px 줄여서 설정 */
	color: white;
	/* 제출 버튼의 글자 색을 흰색으로 설정 */
	background-color: #ff4714;
	/* 제출 버튼의 배경색을 주황색으로 설정 */
	height: 40px;
	/* 제출 버튼의 높이를 40px로 설정 */
	padding: 10px;
	/* 제출 버튼 내부 여백을 10px로 설정 */
	border: none;
	/* 제출 버튼의 테두리를 제거 */
	font-weight: bold;
	/* 제출 버튼의 글자를 굵게 설정 */
	transition: background-color 0.3s;
	/* 배경색 변환을 부드럽게 0.3초 동안 적용 */
	cursor: pointer;
	
}
.home
{
    text-align: center;
}

a {
 color: white;
 text-decoration-line: none;
}

	
</style>
</head>
<body>
	<div id="wrapper">

		<div class="contents">

			<div class="content">
				<h1 id="title">차량등록</h1>
			</div>

			
			<div class="content">
				<ul class="join_step">
					<li><img alt="" src="/images/sellMyCar/약관동의_후.png"><span>약관동의</span></li></li> 
                    <li><img alt="" src="<%=request.getContextPath()%>/images/sellMyCar/차량등록_후.png"><span>차량정보 입력</span></li></li>
                    <li><img alt="" src="<%=request.getContextPath()%>/images/sellMyCar/가입완료_입력.png"><span>등록완료</span></li></li>
				</ul>
			</div>
			

			<div class="content">
				<div class="container">
					<div class="form-group">
                            <h1>차량 등록이 완료되었습니다.</h1>
					</div>
					<div class="form-group">
						<button  class="home" style="width: 200px;">
							<a href="/">
								홈페이지
							</a>
						</button>
					</div>
					</div>
				</div>
			</div>
		</div>
</body>
<%@ include file="../footer.jsp" %>
</html>