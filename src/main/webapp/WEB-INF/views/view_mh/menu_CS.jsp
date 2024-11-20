<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.menu {
	z-index: 1;
}

.nav__cont {
  position: fixed;
  width: 60px;
  top:0;
  height: 100vh;
  z-index: 1;
  background-color: #323232;
  overflow:hidden;
  transition:width .3s ease;
  cursor:pointer;
  box-shadow:4px 7px 10px rgba(0,0,0,.4);
  &:hover {
    width:240px;
  }
  @media screen and (min-width: 600px) {
    width: 60px;
  }
}

.nav__cont_logo {
	width: 100%;
	max-width: 42px;
	height: auto;
	position: relative;
	margin: 20px 10px;
}

.nav {
  list-style-type: none;
  padding-top:100px;
  color:white;
  height: 800px;
  &:first-child {
    padding-top:150px;
  }
}

.nav__items {
	display:flex;
  padding-bottom:4rem;
  font-family: 'Pretendard';
  align-items:center;
   a {
    position: relative;
    display:block;
    top:0px;
    padding-left:15px;
    padding-right:25px;
    transition:all .3s ease;
    margin-left:0px;
    margin-right:10px;
    text-decoration: none;
    color:white;
    font-family: 'Pretendard';
    font-weight: 100;
    font-size: 16px;
     &:after {
       content:'';
       width: 100%;
       height: 100%;
       position: absolute;
       top:0;
       left:0;
       border-radius:2px;
       background:radial-gradient(circle at 94.02% 88.03%, #ff4714, transparent 100%);
       opacity:0;
       transition:all .5s ease;
       z-index: -10;
     }
  }
  &:hover a:after {
    opacity:1;
  }
   img{
    width:26px;
    height:auto;
    position: relative;
    left:-25px;
    cursor:pointer;
    @media screen and(min-width:600px) {
    	width: 100%;
      	max-width:28px;
      	height: auto;
    	max-height:28px;
		left:-15px;
    }
  }
}



.nav__items3 img{
    width:26px;
    height:26px;
    position: relative;
    left:-25px;
    cursor:pointer;
    @media screen and(min-width:600px) {
    	width: 100%;
      	max-width:28px;
      	height: auto;
    	max-height:28px;
		left:-15px;
    }
}

/* .nav__items3 기본 설정 */
.nav__items3 {
  display: flex;
  flex-direction: column; /* 자식 요소들을 세로로 배치 */
  padding: 0 0 47px;
  font-family: 'Pretendard';
  align-items: flex-start;
  position: relative;
}

/* 문의내역 텍스트 스타일 */
.nav__items3 .nav_items_text3 {
  position: relative;
  display: block;
  padding-left: 15px;
  padding-right: 25px;
  transition: all 0.3s ease;
  margin-left: 10px;
  text-decoration: none;
  color: #e2e8ee;
  font-size: 16px;
  font-family: 'Pretendard';
  font-weight: 100;
  top: -21px;
  left: 20px;
}

/* 문의내역 텍스트에 마우스를 올렸을 때 배경효과 */
.nav__items3 .nav_items_text3:after {
  content: '';
  width: 100%;
  height: 100%;
  position: absolute;
  bottom: 0;
  right: 0;
  border-radius: 2px;
  background: radial-gradient(circle at 94.02% 88.03%, #ff4714, transparent 100%);
  opacity: 0;
  transition: all 0.5s ease;
  z-index: -10;
}

.nav__items3:hover .nav_items_text3:after {
  opacity: 1; /* 마우스를 올리면 배경 활성화 */
}

/* 서브메뉴(mon_nav_items)를 기본적으로 숨김 (visibility와 opacity 사용) */
.mon_nav_items {
  visibility: hidden;
  opacity: 0;
  max-height: 0;
  transition: visibility 0s, opacity 0.3s ease, max-height 0.3s ease;
  overflow: hidden;
}

/* .nav__items3에 마우스를 올렸을 때 서브메뉴가 펼쳐짐 */
.nav__items3:hover .mon_nav_items {
  visibility: visible;  /* 마우스를 올리면 보이기 */
  opacity: 1;           /* 투명도 조절로 애니메이션 */
  max-height: 200px;    /* 자연스럽게 펼쳐지는 효과 */
  overflow: visible;
}

/* 서브메뉴의 항목 스타일 */
.mon_nav_items a {
  position: relative;
  display: block;
  padding-left: 40px;
  padding-right: 25px;
  margin: 10px 0;
  text-decoration: none;
  color: #e2e8ee;
  font-size: 14px;
  transition: color 0.3s ease;
}

/* 서브메뉴 항목에 배경효과 추가 */
.mon_nav_items a:after {
  content: '';
  width: 100%;
  height: 100%;
  position: absolute;
  bottom: 0;
  right: 0;
  border-radius: 2px;
  background: radial-gradient(circle at 94.02% 88.03%, #ff4714, transparent 100%);
  opacity: 0;
  transition: all 0.5s ease;
  z-index: -10;
}

/* 서브메뉴 항목에 마우스를 올렸을 때 배경효과 활성화 */
.mon_nav_items a:hover:after {
  opacity: 1;
}


</style>
</head>
<body>

<nav class="nav__cont">
	<img alt="logo" src="../images/main/로고_icon_2.png" class="nav__cont_logo">
  	<ul class="nav">
	    
	    <li class="nav__items">
	      <img alt="icon" src="../images/main/전문가리뷰_icon.png" class="nav_items_img">
	      <a href="/view_jw/csFaq" class="nav_items_text">자주 묻는 질문</a>
	    </li>
      
        <li class="nav__items">
		<img alt="icon" src="../images/main/찜_icon.png" class="nav_items_img">
			<c:choose>
				<c:when test="${not empty sessionScope.user}">
					<a href="#" onclick="window.open('/view_jw/csQna', '_blank', 'width=600, height=800')" 
      							class="nav_items_text">신고·문의·민원</a>
				</c:when>

				<c:otherwise>
					<a href="../view_jw/csNotLogin" class="nav_items_text">신고·문의·민원</a>
				</c:otherwise>
			</c:choose>
	    </li>
      
	    <li class="nav__items">
	      <img alt="icon" src="../images/main/문의내역.png" class="nav_items_img">
	      <a href="/view_jw/csNotice" class="nav_items_text">공지사항 및 약관</a>
	    </li>
	    
	    <li class="nav__items">
	      <img alt="icon" src="../images/main/개인정보수정_icon.png" class="nav_items_img">
	      <a href="/view_jw/csReview" class="nav_items_text">고객후기</a>
	    </li>
	</ul>
</nav>

</body>
</html>