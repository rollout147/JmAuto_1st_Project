<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/manager_gogi_corr.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<div class="header_continer"><%@ include file="../header.jsp" %></div>
<div class="menu_continer"><%@ include file="../manager_menu.jsp" %></div>
</head>
<body>
	<div class="manager_gogi_sel_continer">
		<div class="manager_gogi_sel_content">
			<div class="gogi_sel_hed">게시물수정</div>
			<c:forEach var="Gogi" items="${notice }">
				<div class="gogi_sel_form">
					<form action="/mh/gogiupdatesel" method="post">
					<table class="gogi_sel_table">
						<tr>
							<td class="gogi_sel_table_title"><div class="gogi_sel_table_text">제목</div></td>
							<td><input type="text" value="${Gogi.notice_title }" name="notice_title" class="gogi_sel_input"></td>
						</tr>
						<tr>
							<td class="gogi_sel_table_title"><div class="gogi_sel_table_text">분류</div></td>
							<td><select name="notice_cls" id="gogi_notice_cls" class="gogi_sel_select">
									<option value="6100" ${Gogi.notice_cls == 6100 ? 'selected' : '' }>공지사항</option>
									<option value="6200" ${Gogi.notice_cls == 6200 ? 'selected' : '' }>이용약관</option>
									<option value="6300" ${Gogi.notice_cls == 6300 ? 'selected' : '' }>이벤트</option>
								</select></td>
						</tr>
						<tr>
							<td class="gogi_sel_table_title"><div class="gogi_sel_table_text">내용</div></td>
							<td><textarea name="notice_content" rows="10" cols="100" class="gogi_sel_textarea">${Gogi.notice_content }</textarea></td>
						</tr>
						<tr>
							<td colspan="2" class="gogi_sel_table_td"><input type="hidden" value="${Gogi.notice_num }" name="notice_num">
								<input type="button" value="취소" class="gogi_sel_but_su" onclick="location.href='/manager/CS/gogi'">
								<input type="reset" value="리셋" class="gogi_sel_but_reset">
								<input type="submit" value="확인" class="gogi_sel_but_sub">
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