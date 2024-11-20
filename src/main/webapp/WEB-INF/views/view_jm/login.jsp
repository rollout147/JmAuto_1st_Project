<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

body, html {
    margin: 0; /* 브라우저 기본 여백을 제거 */
    padding: 0; /* 브라우저 기본 패딩을 제거 */
    height: 100%; /* 화면 높이를 100%로 설정 */
    background-color: #fafafa; /* 배경 색상 설정 */
    font-family: 'Pretendard'; /* 기본 폰트 설정 */
}



.container {
    position: relative;
    left: 1300px;
    width: 400px; /* 컨테이너의 너비를 400px로 설정 */
    height: 700px; /* 컨테이너의 높이를 600px로 설정 */
    padding: 40px; /* 컨테이너의 내부 여백을 40px로 설정 */
    background-color: #fdfdfd; /* 컨테이너의 배경을 흰색으로 설정 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* 컨테이너에 그림자 효과 추가 */
    text-align: center; /* 컨테이너 내부의 텍스트를 가운데 정렬 */
    margin: 100px 0px;
    
}

.logo{
    position: relative;
    top: 50px;
}

.userForm {
    position: relative; /* 상대적 위치를 설정하여 위치 조정 가능 */
    top: 150px; /* 컨테이너 내에서 150px 아래로 위치 설정 */
}

.container input[type="text"], .container input[type="password"] {
    width: calc(100% - 20px); /* 입력 필드의 너비를 컨테이너 너비에서 20px 줄여서 설정 */
    height: 50px; /* 입력 필드의 높이를 40px로 설정 */
    padding: 10px; /* 입력 필드 내부 여백을 10px로 설정 */
    box-sizing: border-box; /* 박스 크기 계산에 패딩과 테두리를 포함 */
    border: 1px solid #ddd; /* 입력 필드 테두리를 연한 회색으로 설정 */
    transition: border-color 0.3s; /* 테두리 색상 변환을 부드럽게 0.3초 동안 적용 */
}

.container input[type="text"]:focus, .container input[type="password"]:focus {
    border-color: #ff4714; /* 입력 필드가 포커스를 받을 때 테두리 색상을 주황색으로 변경 */
    outline: none; /* 포커스 시 나타나는 기본 외곽선을 제거 */
}

.container input[type="submit"] {
    width: calc(100% - 20px); /* 제출 버튼의 너비를 컨테이너 너비에서 20px 줄여서 설정 */
    height: 50px; /* 제출 버튼의 높이를 40px로 설정 */
    padding: 10px; /* 제출 버튼 내부 여백을 10px로 설정 */
    background-color: #ff4714; /* 제출 버튼의 배경색을 주황색으로 설정 */
    margin-top: 20px;
    border: none; /* 제출 버튼의 테두리를 제거 */
    color: white; /* 제출 버튼의 글자 색을 흰색으로 설정 */
    font-weight: bold; /* 제출 버튼의 글자를 굵게 설정 */
    transition: background-color 0.3s; /* 배경색 변환을 부드럽게 0.3초 동안 적용 */
}

.container input[type="submit"]:hover {
    background-color: #ededed; /* 제출 버튼에 마우스가 올라갈 때 배경색 유지 */
    color : gray;
}

.userChoose {
    display: flex;
    justify-content: center;
    width: calc(100% - 20px);
    margin-top: 20px; /* 목록의 위쪽 여백을 20px로 설정 */
    padding: 0; /* 목록의 패딩을 제거 */
    list-style: none; /* 목록의 기본 불릿 제거 */
    position: relative;
    left: 10px;
}

ul.links li {
    margin: 0 10px;
}

ul.userChoose li a {
    text-decoration: none; /* 링크의 밑줄을 제거 */
    color: gray; /* 링크의 글자 색을 주황색으로 설정 */
    font-size: 14px; /* 링크의 글자 크기를 14px로 설정 */
}

ul.userChoose li span{
    color: gray;
}

ul.userChoose li a:hover {
    text-decoration: underline; /* 링크에 마우스를 올렸을 때 밑줄을 추가 */
}

.errMessage{
float: left;
color: red;
font-size: 12px;
margin: 5px 0;
position: relative;
left: 15px;
}

body {
    background-image: url("../images/main/로그인.png");
    background-repeat: no-repeat;
    
    background-position: 100px 250px;
}
</style>




</head>

<script type="text/javascript">

window.onload = function() {
    document.getElementById("user_id").focus();
};



</script>
<body>
<header>
 <%@ include file="../header_white.jsp"%>
</header>
    <div class="container" >
        <div class="logo">
            <img src="<%=request.getContextPath()%>/images/main/logo_web.png" width="40%">
        </div>
        <div class="userForm">
            <form action="/view_jm/login" method="post">
            <c:if test="${not empty loginError}">
            <p class="errMessage">${loginError}</p>
        	</c:if>
                <input type="text" placeholder="아이디" id ="user_id" name="user_id" value="${user_id}" required="required"><p>
                    <input type="password" placeholder="비밀번호" name="user_pw" required="required"><p>
                    <input type="submit" value="로그인">
            </form>
            <ul class="userChoose">
                <li><a href="/view_jm/joinType">회원가입</a></li>
                <li><span>&nbsp;|&nbsp;</span></li>
                <li><a href="/view_jm/findPw">비밀번호 찾기</a></li>
                <li><span>&nbsp;|&nbsp;</span></li>
                <li><a href="/view_jm/findId">아이디 찾기</a></li>
            </ul>
        </div>
	</div>
	<footer>
	<%@ include file="../footer.jsp" %>
	</footer>
</body>
</html>