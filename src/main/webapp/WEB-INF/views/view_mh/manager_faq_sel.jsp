<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/manager_faq_sel.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<div class="header_continer"><%@ include file="../header.jsp" %></div>
<div class="menu_continer"><%@ include file="../manager_menu.jsp" %></div>
</head>
<body>
	<div class="faq_sel_container">
		<div class="faq_sel_content">
			<div class="cal_1_header">게시물 수정</div>
			<c:forEach var="faq" items="${faq }">
				<div class="faq_sel">
					<form action="/mh/faqupdate" method="post">
					<table class="faq_sel_table">
						<tr>
							<td class="faq_sel_table_title"><div class="faq_sel_table_text">제목</div></td>
							<td><input type="text" value="${faq.faq_title }" name="faq_title" class="faq_sel_table_input"></td>
						</tr>
						<tr>
							<td class="faq_sel_table_title"><div class="faq_sel_table_text">분류</div></td>
							<td><select name="faq_cls" id="faq_sel_cls" class="faq_sel_table_select">
									<option value="5200" ${faq.faq_cls == 5200 ? 'selected' : ''}>구매가이드</option>
									<option value="5300" ${faq.faq_cls == 5300 ? 'selected' : ''}>회원정보관리</option>
									<option value="5400" ${faq.faq_cls == 5400 ? 'selected' : ''}>전문가</option>
									<option value="5500" ${faq.faq_cls == 5500 ? 'selected' : ''}>구매가이드</option>
									<option value="5600" ${faq.faq_cls == 5600 ? 'selected' : ''}>내차팔기</option>
									<option value="5700" ${faq.faq_cls == 5700 ? 'selected' : ''}>기타</option>
								</select></td>
						</tr>
						<tr>
							<td class="faq_sel_table_title"><div class="faq_sel_table_text">내용</div></td>
							<td><textarea name="faq_content" rows="10" cols="100" class="faq_sel_table_textarea">${faq.faq_content }</textarea></td>
						</tr>
						<tr>
							<td colspan="2" class="faq_sel_table_td"><input type="hidden" value="${faq.faq_num}" name="faq_num">
								<input type="button" value="취소" class="faq_sel_but_su" onclick="location.href='/manager/CS/faq'">
								<input type="reset" value="리셋" class="faq_sel_but_reset">
								<input type="submit" value="확인" class="faq_sel_but_sub">
								</td>
						</tr>
					</table>
					</form>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>