<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>구매자 - 내가 쓴 후기</title>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript"></script>
<link rel="stylesheet" href="../css/myPage.css">
<div class="header_continer"><%@ include file="../header_white.jsp"%></div>
<div class="menu_continer"><%@ include file="../menu_B.jsp" %></div>
<%@ include file="../kakao.jsp"%>
</head>

<style type="text/css">
.container {
	display: flex;
	flex-direction: column;
	text-align: center;
	width: 1320px;
	margin: 0 300px;
	align-items: center;
	
}

.title {
	font-size: 32px; 
	font-weight: bold;
	margin: 100px 0 ;
}

.carInfo {
	color: #9E9E9E; 
	font-size: 18px;
}

hr {
	width: 1040px; 
	color: gray; 
	margin: 20px auto;
}

.subtitle {
	text-align: left;
	font-size: 18px; 
	font-weight: bold;
	margin: 10px 140px 20px 140px;
}

.evaluation {
	text-align: left;
	margin: 0 140px 50px 140px;
}

.star_img {
	width: 120px;
	height: auto;
	
}

.content {
	font-size: 15px;
	text-align: left;
	margin: 0 140px;
}

.review-images {
	display: flex;
	flex-direction: column;
	text-align: left;
	padding: 10px 0 5px 0;
	margin: 50px 140px;
}


.revImg {
	display: flex;
	margin-bottom: 30px;
	width: 600px;
}

.carImg {
	width: 600px;
}

.delete {
	cursor: pointer; 
	width: 200px;
	height: auto;
	margin: 0 0 10px 1100px;

}

</style>



<script type="text/javascript">

		function deletehoogi(approval_num){
			if(confirm('삭제하시겠습니까?')){
				$.ajax({
					url: '/myHoogiDelete',
					type: 'POST',
					data: {approval_num : approval_num}, 
					success: function(response){
						alert('후기가 삭제되었습니다.');
						window.history.back();
					},
					error: function(xhr, status, error){
						alert('후기의 삭제여부가 변경되었습니다.');
					}
				});
			}
		}
</script>


<body>

	<div class="container">

			
		<div class="title">${ri.review_title}</div>

		<div class="carInfo">
			${ ri.model }&emsp;&emsp; 
			${ ri.manu_date_char }&emsp;&emsp;
			${ ri.mileage }&emsp;&emsp; 
			${ ri.fuel }
		</div>
		<br>
		
		<hr>

		
		<span class="subtitle">평점</span>
		<div class="evaluation">
			<c:choose>
				<c:when test="${ri.evaluation == 5}">
					<img alt="별5점" src="../images/main/star_5.png"
						class="star_img">
				</c:when>
				<c:when test="${ri.evaluation == 4}">
					<img alt="별4점" src="../images/main/star_4.png"
						class="star_img">
				</c:when>
				<c:when test="${ri.evaluation == 3}">
					<img alt="별3점" src="../images/main/star_3.png"
						class="star_img">
				</c:when>
				<c:when test="${ri.evaluation == 2}">
					<img alt="별2점" src="../images/main/star_2.png"
						class="star_img">
				</c:when>
				<c:otherwise>
					<img alt="별1점" src="../images/main/star_1.png"
						class="star_img">
				</c:otherwise>
			</c:choose>
		</div>
			
		<div class="content">${ri.review_content}</div>

		<div class="review-images">
			<!-- 첨부 이미지들 -->
		    <c:if test="${not empty ri.file_name1}">
	            <img src="${ri.file_url}${ri.file_name1}" alt="Review Image 1" class="revImg">
	        </c:if>
		    <c:if test="${not empty ri.file_name2}">
	            <img src="${ri.file_url}${ri.file_name2}" alt="Review Image 2" class="revImg">
	        </c:if>
		    <c:if test="${not empty ri.file_name3}">
	            <img src="${ri.file_url}${ri.file_name3}" alt="Review Image 3" class="revImg">
	        </c:if>
		    
		    <!-- 기본 이미지 -->
			<img src="${ri.img_url}" class="carImg">
		</div>
		<div class="buttondle">
		<button type="button"  style= "background:none; border: none;">
		<img src="../images/main/삭제_but.png" alt="삭제하기" onclick="deletehoogi('${ri.approval_num}')" class="delete">
		</button></div>
			
	</div>
		
		

	<!--------------------------------------- 푸터 --------------------------------------->
	<%@ include file="../footer.jsp"%>
</body>
</html>