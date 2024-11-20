<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href="/css/csQna.css" rel="stylesheet" type="text/css"/>
<meta charset="UTF-8">
<title>QnA</title>

</head>
<body>
<script>
	// 문의 유형을 선택하지 않았을 때
    function validateQnaForm() {
        var qnaCls = document.querySelector('select[name="qna_cls"]').value;
        if (qnaCls === '문의선택') {
            alert("문의 분류를 선택해주세요.");
            return false;  // 폼 제출 중단
        }
        return true;  // 폼 제출 진행
    }
</script>


	<h3>01. 고객문의</h3>
	<hr>
	<c:if test="${msg!=null}">${msg}</c:if>
	<form action="writeQna" method="post" name="frm"  enctype="multipart/form-data" onsubmit="return validateQnaForm();">
		<span class="notice">
		- 보내주신 문의를 확인 후 최대한 빠르게 답변해 드리겠습니다.<br>
		- 문의 [제목]과 [내용]란에는 절대 개인정보를 입력하지 마십시오.<br>
		</span>			
		<input type="checkbox" name="agree" required="required" value="개인정보 수집 및 이용동의">
		개인정보 수집 및 이용 동의<br>
		<span class="deny">* 위 항목에 거부할 권리가 있습니다. 
		 단, 동의를 거부할 경우 문의 이용이 제한됩니다.</span>
	
		<h3>02. 문의입력</h3>
		<hr>
		
		<%-- <input type="hidden" name="qna_num" value="${qna.qna_num }">	 --%>
		<table>
			<tr><th>문의유형</th><td>
				<select name="qna_cls">
					<!-- 마이페이지에서 환불 신청하기 버튼을 눌렀을 경우에 function과 when 작동, cs 1:1문의에서는 otherwise 작동 -->
					<c:choose>
						<c:when test="${param.qna_cls == '환불'}">
							<option value="환불" selected>환불</option>
						</c:when>
						<c:otherwise>
							<option value="문의선택" class="clsDefault" <c:if test="${param.qna_cls == null || param.qna_cls == ''}">selected</c:if>>--문의선택--</option>
							<option value="배송" <c:if test="${param.qna_cls == '배송'}">selected</c:if>>배송</option>
		                    <option value="보안" <c:if test="${param.qna_cls == '보안'}">selected</c:if>>보안</option>
		                    <option value="환불" <c:if test="${param.qna_cls == '환불'}">selected</c:if>>환불</option>
		                    <option value="이용안내" <c:if test="${param.qna_cls == '이용안내'}">selected</c:if>>이용안내</option>
		                    <option value="전문가" <c:if test="${param.qna_cls == '전문가'}">selected</c:if>>전문가</option>
		                    <option value="차량정보" <c:if test="${param.qna_cls == '차량정보'}">selected</c:if>>차량정보</option>
		                    <option value="페이지오류" <c:if test="${param.qna_cls == '페이지오류'}">selected</c:if>>페이지오류</option>
		                    <option value="회원관리" <c:if test="${param.qna_cls == '회원관리'}">selected</c:if>>회원관리</option>
		            	</c:otherwise>        
		        	</c:choose>            
				</select></td></tr>
					
			<tr><th>제목</th><td>
			<input class="title" type="text" name="qna_title" required="required"></td>
			</tr>	
							
			<tr><th>내용</th><td>
				<input class="content" type="text" name="qna_content" required="required" ></td>
			</tr>				
	
			<tr><th>첨부파일</th><td>
				<a href="#" class="file">
					<input type="file" accept=".jpg, .jpeg, .png, .pdf" name="file01">
				</a>
			</td></tr>	
		</table>
		
		<span class="button">
			<!-- 데이터 전송 후 새로운 창 열기 -->	
			<button type="submit" class="submit" >
				<img class="img-submit" src="../images/main/문의하기.png">
			</button>
			
			 <!-- 취소버튼 눌러서 창 닫기 -->
			 <button type="button" class="cancel" onclick="window.close()">
	            <img class="img-cancel" src="../images/main/취소하기.png">
	        </button>
		</span>
		
	</form>
	
</body>
</html>