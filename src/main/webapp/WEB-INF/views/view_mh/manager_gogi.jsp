<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/manager_faq.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<div class="header_continer"><%@ include file="../header.jsp" %></div>
<div class="menu_continer"><%@ include file="../manager_menu.jsp" %></div>
<script type="text/javascript">
	function goToLink(url) {
	    window.location.href = url;
  	}
	
	function deleteFaq(noticeNum) {
		console.log("noticeNum >>> " + noticeNum);
	    if (confirm("정말 삭제하시겠습니까?")) {
	        fetch(`/mh/gogiDelete`, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json',
	            },
	            body: JSON.stringify({ noticeNum: noticeNum }) // JSON 형식으로 본문에 포함
	        })
	        .then(response => {
	            if (response.ok) {
	                alert("삭제되었습니다.");
	                location.reload(); // 페이지 새로고침
	            } else {
	                alert("삭제 실패: " + response.statusText);
	            }
	        })
	        .catch(error => {
	            alert("오류 발생: " + error);
	        });
	    }
	}
	
	function exposFaq(noticeNum) {
		console.log("noticeNum >>> " + noticeNum);
	    if (confirm("정말 노출하시겠습니까?")) {
	        fetch(`/mh/gogiExpos`, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json',
	            },
	            body: JSON.stringify({ noticeNum: noticeNum }) // JSON 형식으로 본문에 포함
	        })
	        .then(response => {
	            if (response.ok) {
	                alert("노출되었습니다.");
	                location.reload(); // 페이지 새로고침
	            } else {
	                alert("노출 실패: " + response.statusText);
	            }
	        })
	        .catch(error => {
	            alert("오류 발생: " + error);
	        });
	    }
	}
</script>
</head>
<body>
	<div class="manager_container">
		 <c:if test="${not empty message}">
	        <script>
	            alert("${message}"); // 팝업으로 메시지 표시
	        </script>
	    </c:if>
		<div class="manager_gogi">
			<div class="manager_header">
				<div class="manager_header_h1">
					공지사항
				</div>
				<div class="manager_header_gene">
					<a href="/mh/gogiInsert" class="manager_header_gene_a">새로작성</a>
				</div>
			</div>
			<div class="manager_CS_list">
				<table class="manager_CS_table">
					<tr class="tr-1">
						<th class="col-1"><div class="manager_CS_table_th">분류</div></th><th class="col-2"><div class="manager_CS_table_th">작성자</div></th>
						<th class="col-3"><div class="manager_CS_table_th">제목</div></th><th class="col-4"><div class="manager_CS_table_th">날짜</div></th>
						<th class="col-5"><div class="manager_CS_table_th">작업</div></th><th class="col-6"><div class="manager_CS_table_th">삭제여부</div></th>
					</tr>
					<c:forEach var="notList" items="${notList }">
					<tr class="tr-2">
						<td class="col-1" onclick="goToLink('/mh/notsel?noticeNum=${notList.notice_num}')">
							<c:choose>
								<c:when test="${notList.notice_cls == 6100 }">
									<%-- <img alt="" src="<%=request.getContextPath()%>/images/main/star_4.png" class="manager_CS_td_img"> --%>
									<div class="manager_CS_td_text_1">공지사항</div>
								</c:when>
								<c:when test="${notList.notice_cls == 6200 }">
									<%-- <img alt="" src="<%=request.getContextPath()%>/images/main/star_4.png" class="manager_CS_td_img"> --%>
									<div class="manager_CS_td_text_1">이용약관</div>
								</c:when>
								<c:when test="${notList.notice_cls == 6300 }">
									<%-- <img alt="" src="<%=request.getContextPath()%>/images/main/star_4.png" class="manager_CS_td_img"> --%>
									<div class="manager_CS_td_text_1">이벤트</div>
								</c:when>
							</c:choose>
						</td>
						<td class="col-2" onclick="goToLink('/mh/notsel?noticeNum=${notList.notice_num}')"><div class="manager_CS_td_text_1">${notList.user_id }</div></td>
						<td class="col-3" onclick="goToLink('/mh/notsel?noticeNum=${notList.notice_num}')"><div class="manager_CS_td_text_2">${notList.notice_title}</div></td>
						<td class="col-4" onclick="goToLink('/mh/notsel?noticeNum=${notList.notice_num}')"><div class="manager_CS_td_text_1">
								<fmt:formatDate value="${notList.notice_date }" pattern="yyyy/MM/dd"/>
							</div>
						</td>
						<td id="manager_faq_td_but" class="col-5">
							<button type="button" id="faq_corrbut" class="but_background" onclick="exposFaq('${notList.notice_num}')"><img alt="노출_icon" src="<%=request.getContextPath()%>/images/main/노출_icon.png" class="but_images"></button>
							<button type="button" id="faq_delbut" class="but_background" onclick="deleteFaq('${notList.notice_num}')"><img alt="삭제_icon" src="<%=request.getContextPath()%>/images/main/삭제_icon.png" class="but_images"></button>
						</td>
						<td class="col-6">
							<c:choose>
								<c:when test="${notList.del_state == 0 }">
									<div class="faq_del_state_back1"><div class="faq_del_state1">정  상</div></div>
								</c:when>
								<c:when test="${notList.del_state == 1 }">
									<div class="faq_del_state_back2"><div class="faq_del_state2">삭  제</div></div>
								</c:when>
							</c:choose>
						</td>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>