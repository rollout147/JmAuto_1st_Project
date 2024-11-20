<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.header_continer {
    position: relative; /* No fixed position, it will scroll naturally */
    width: 100%;
    top: 0;
    z-index: 1001; /* Still higher than the menu */
}
.menu_continer {
    position: fixed;
    top: 0; /* Stays fixed at the top */
    z-index: 1000; /* Lower than the header */
    height: 100vh; /* Full viewport height */
}
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

.nav__items2 {
  display:flex;
  padding-top:170px;
  font-family: 'Pretendard';
  align-items:center;
   a {
    position: relative;
    display:block;
    top:0px;
    padding-left:60px;
    padding-right:25px;
    transition:all .3s ease;
    margin-left:60px;
    margin-right:00px;
    text-decoration: none;
    color:#e2e8ee;
    font-family: 'Pretendard';
    font-weight: 100;
    font-size: 12px;
     &:after {
       content:'';
       width: 100%;
       height: 100%;
       position: absolute;
       bottom:0;
       right:0;
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

table.List {
    width: 100%;                /* 테이블 폭을 100%로 설정 */
    border-collapse: collapse;  /* 경계선 겹치기 제거 */
    margin-top: 80px;
}

.List thead {
    display: none;              /* 헤더 숨기기 (필요에 따라) */
}

.List tbody {
    display: flex;              /* 테이블 몸체를 Flexbox로 설정 */
    flex-wrap: wrap;           /* 줄 바꿈 허용 */
}

.List tr {
    display: flex;              /* 각 행을 Flexbox로 설정 */
    align-items: center;        /* 수직 정렬 */
    margin-bottom: 20px;       /* 각 행 간의 여백 */
    flex: 1 0 calc(33.333% - 20px); /* 3개씩 나열되도록 설정 */
}

.chu_carList {
    display: flex;              /* 차량 리스트를 Flexbox로 설정 */
    align-items: center;        /* 수직 정렬 */
}

.chu-img {
    width: 200px;               /* 이미지 크기 조정 */
    height: auto;
    margin-right: 10px;        /* 이미지와 텍스트 간격 */
}

.chu_body_all {
    display: flex;              /* 텍스트 부분도 Flexbox로 설정 */
    flex-direction: column;     /* 세로로 배치 */
}
</style>
</head>
<body>

<nav class="nav__cont">
	<img alt="logo" src="../images/main/로고_icon_2.png" class="nav__cont_logo">
  <ul class="nav">
    <li class="nav__items">
      <img alt="icon" src="../images/main/구매내역.png" class="nav_items_img">
      <a href="/view_ms/sellList" class="nav_items_text">판매중인 차량</a>
    </li>
      
    <li class="nav__items">
      <img alt="icon" src="../images/main/계약.png" class="nav_items_img">
     <a href="/view_ms/sellWan" class="nav_items_text">판매완료 내역</a>
    </li>
      
    <li class="nav__items3">
      <img alt="icon" src="../images/main/문의내역.png" class="nav_items_img">
      <a href="" class="nav_items_text3">문의내역</a>
      <div class="mon_nav_items">
      	<a href="/view_ms/myNote_S">차량구매 문의 내역</a>
      	<a href="/view_ms/myQna_S">고객센터 문의 내역</a>
      </div>
    </li>
    <li class="nav__items">
      <img alt="icon" src="../images/main/개인정보수정_icon.png" class="nav_items_img">
      <a href="/view_ms/myPageEditCheck_S" class="nav_items_text">회원정보수정</a>
    </li>
    
       <li class="nav__items">
      <img alt="icon" src="../images/main/jh_stats.png" class="nav_items_img">
      <button id="stats" onclick="window.open('/view_jh/seller_Stats_MainForm', '_blank', 'width=1400, height=1000, left=250, scrollbars=yes')">판매자 통계</button>
    </li>


    <style>
	    #stats {
	        background: none;
	        border: none; 
	        color: inherit; 
	        cursor: pointer;
	        margin-left: 10px;
	        font: inherit; 
	    }
	    #stats:hover {
			background: radial-gradient(circle at 94.02% 88.03%, #ff4714, transparent 100%);
			transition: all 0.5s ease;
	    } 
	</style>
    
    <li class="nav__items2">
      <a href="/view_ms/talTwae_S" class="nav_items_text2">회원탈퇴</a>
    </li>
  </ul>
</nav>

</body>
</html>