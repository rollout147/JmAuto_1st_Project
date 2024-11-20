
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		.content, .title { 
			margin-left: -70px;
			border: 1px solid black;
			font-family: 'Arial', sans-serif; 
			width: 100%;
			resize: none;
			outline: none;
		}
		.content { margin-bottom: 15px; }
		.title { 
			margin-top: 8px;
			margin-bottom: 15px;
			height: 20px;
		}
	</style>
<link href="/css/csQna.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>쪽지 보내기</title>
</head>
<body>
	
	<form action=/view_ms/sending_note method="post">
	
		<p><hr><h3>판매자에게 쪽지보내기</h3><hr>
			<table>
			
				<tr>
					<th>제목</th>
					<td><textarea class="title" name="title" required="required" maxlength="20"></textarea>
						<input type="hidden" name="sellNum" value="${param.sellNum}">  <!-- URL에서 가져오기 -->
                		<input type="hidden" name="id" value="${param.id}">  
					</td>
				</tr>		
								
				<tr>
					<th>내용</th>
					<td><textarea class="content" name="content" required="required" maxlength="500"></textarea></td>
				</tr>				
			</table>
		
		<span class="button">
			<!-- 데이터 전송 후 새로운 창 열기 -->	
			<button type="submit" class="submit">
				<img class="img-submit" src="../images/main/쪽지보내기.png">	
			</button>
			
			 <!-- 취소버튼 눌러서 창 닫기 -->
			 <button type="button" class="cancel" onclick="window.close()">
	            <img class="img-cancel" src="../images/main/취소하기.png">
	        </button>
		</span>
		
	</form>
	
</body>
</html>