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

    .center {
        text-align: center;
    }

    .box {
			display: grid;
            grid-template-columns: 1fr;
            grid-column-gap: 20px;
            grid-row-gap: 20px;
            width: 1000px;
            margin: 0 auto;
            background-color: #fff;
            padding: 100px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 50px;
            text-align: center;
            justify-content: center;
            margin-bottom: 40px;
		}

        .box2 {
			display: flex;
            margin-bottom: 50px;
            text-align: center;
            justify-content: center;
		}

    .home{
        text-align: center;
    }

    a{
        text-align: center;
        color: white;
        text-decoration-line: none;
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

    h1 {
        margin-bottom: 50px;
        margin-top: 50px;
        text-align: center;
        font-weight: bold;
    }
    
	
</style>
</head>

<body>
	
    <div class="center">
        <h1>내차팔기</h1>
        
        <div class="box">
            <h1>판매자만 접근 가능한 페이지입니다.</h1>
            
            <div class="box2">
                <button  class="home" style="width: 200px;">
                    <a href="/">홈페이지로 이동</a>
                </button>
            </div>
        </div>
	</div>	
		
			
</body>
<%@ include file="../footer.jsp" %>
</html>