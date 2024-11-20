<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/manager_insert.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<div class="header_continer"><%@ include file="../header.jsp" %></div>
<div class="menu_continer"><%@ include file="../manager_menu.jsp" %></div>
</head>
<body>
	<div class="faq_insert_container">
		<div class="faq_insert_content">
			<div class="faq_input_hed_text">새로작성하기</div>
			<form action="/mh/faqinsertFrom" method="post">
				<table class="faq_input_table">
					<tr>
						<td class="faq_int_table_title"><div class="faq_int_table_text">분류</div></td>
						<td><select name="faq_cls" id="faq_cls_num" class="faq_int_select">
								<option value="5200">구매가이드</option>
								<option value="5300">회원정보관리</option>
								<option value="5400">전문가</option>
								<option value="5500">구매가이드</option>
								<option value="5600">내차팔기</option>
								<option value="5700">기타</option>
							</select></td>
					</tr>
					<tr>
						<td class="faq_int_table_title"><div class="faq_int_table_text">제목</div></td>
						<td><input type="text" name="faq_title" class="faq_input_table_input"></td>
					</tr>	
					<tr>
						<td class="faq_int_table_title"><div class="faq_int_table_text">내용</div></td>
						<td><textarea rows="10" cols="150" name="faq_content" class="faq_input_table_textarea"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="faq_sel_table_td"><input type="hidden" value="${sessionScope.user.user_id }" name="user_id">
							<input type="button" value="취소" class="faq_sel_but_su" onclick="location.href='/manager/CS/faq'">
							<input type="reset" value="리셋" class="faq_sel_but_reset">
							<input type="submit" value="확인" class="faq_sel_but_sub"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>