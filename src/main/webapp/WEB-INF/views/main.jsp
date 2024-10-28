<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<h1>MAIN</h1>
	<table>
		<c:forEach	var="paperList"	items="${paperList}"	varStatus="status" >
					<tr>
						<td class="cell">${paperList.aply_num}</td>						
						<td class="cell">${paperList.lctr_num}</td>
						<td class="cell">${paperList.unq_num}</td>						
						<td class="cell">${paperList.prdoc_type}</td>
						<td class="cell">${paperList.aply_ymd}</td>						
						<td class="cell">${paperList.issu_ymd}</td>
						<td class="cell">${paperList.issu_stts}</td>	
					</tr>
		</c:forEach>
	</table>
</body>
</html>

