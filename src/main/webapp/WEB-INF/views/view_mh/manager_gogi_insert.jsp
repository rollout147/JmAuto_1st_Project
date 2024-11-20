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
<style type="text/css">
	.gogi_insert_container {
		display: grid;
		grid-template-columns: minmax(auto, 1320px);
		justify-content: center;
		max-width: 100%;
		margin: 0px auto;
		background-color: #f7f7f7;
		height: 100%;
	}
</style>
</head>
<body>
	
	<div class="gogi_insert_container">
		<div class="manager_gogi_sel_content">
			<div class="gogi_sel_hed">공지새로작성하기</div>
			<form action="/mh/gogiinsertFrom" method="post">
				<table class="gogi_sel_table">
					<tr>
						<td class="gogi_sel_table_title"><div class="gogi_sel_table_text">분류</div></td>
						<td><select name="notice_cls" id="gogi_notice_cls" class="gogi_sel_select">
								<option value="6100">공지사항</option>
								<option value="6200">이용약관</option>
								<option value="6300">이벤트</option>
							</select></td>
					</tr>
					<tr>
						<td class="gogi_sel_table_title"><div class="gogi_sel_table_text">제목</div></td>
						<td><input type="text" name="notice_title" class="gogi_sel_input"></td>
					</tr>	
					<tr>
						<td class="gogi_sel_table_title"><div class="gogi_sel_table_text">내용</div></td>
						<td><textarea rows="10" cols="150" name="notice_content" class="gogi_sel_textarea"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="gogi_sel_table_td"><input type="hidden" value="${sessionScope.user.user_id }" name="user_id">
							<input type="button" value="취소" class="gogi_sel_but_su" onclick="location.href='/manager/CS/faq'">
							<input type="reset" value="리셋" class="gogi_sel_but_reset">
							<input type="submit" value="확인" class="gogi_sel_but_sub">
							</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>