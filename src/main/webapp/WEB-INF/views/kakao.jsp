<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#floatMenu {
position: absolute;
display:flex;
justify-content:space-between;
right : 40px;
bottom : 40px;
color: #fff;
z-index: 999;
}
</style>
<script type="text/javascript">
$(document).ready(function() {

// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
var floatPosition = parseInt($("#floatMenu").css('top'));
// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

$(window).scroll(function() {
// 현재 스크롤 위치를 가져온다.
var scrollTop = $(window).scrollTop();
var newPosition = scrollTop + floatPosition + "px";

/* $("#floatMenu").css('top', newPosition); */


$("#floatMenu").stop().animate({"top" : newPosition}, 500);

}).scroll();

});
</script>
</head>
<body>
<div id="floatMenu">
     <a href="https://open.kakao.com/o/sLynhoOg"><img alt="kakao" src="../images/main/kakao.png"
      style="width: 56px; height: 56px;"></a>
     </div>
</body>
</html>