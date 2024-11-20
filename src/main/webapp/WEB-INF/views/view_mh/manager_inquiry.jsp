<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="<%=request.getContextPath()%>/css/manager_inquiry.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<div class="header_continer"><%@ include file="../header.jsp" %></div>
<div class="menu_continer"><%@ include file="../manager_menu.jsp" %></div>
<style type="text/css">
	
	.manager_Qna_table {
		width: 100%;
		table-layout: fixed;
	}
	.manager_Qna_td {
		padding: 0; /* Remove any padding */
	    margin: 0; /* Remove any margin */
	}
</style>
<script type="text/javascript">
	function searchQna() {
		var keyword = document.getElementById('keyword').value;
		
		$.ajax({
			type: 'GET',
			url : '/mh/man_inquiry',
			data: {keyword:keyword},
			success: function(data) {
				window.location.href = '/mh/man_inquiry?keyword=' + encodeURIComponent(keyword);
			},
			error: function(err) {
				console.log('오류 발생 : ', err);
			}
		})
	}
	
	let isFiltered = false;

	function filterUnanswered() {
	    var answerStatus = isFiltered ? null : 0;
	     // 필터링 상태 반전
	     isFiltered = !isFiltered;
	    
	    console.log("answerStatus:>>>>", answerStatus);
	    console.log("isFiltered:>>>>", isFiltered);
	    $.ajax({
	        type: 'GET',
	        url: '/mh/man_inquiry',
	        data: { answerStatus: answerStatus },
	        success: function(data) {
	            var url = '/mh/man_inquiry?answerStatus=' + (answerStatus !== null ? answerStatus : '');
    			window.location.href = url; // URL 변경
	        },
	        error: function(err) {
	            console.log('오류 발생 : ', err);
	        }
	    });
	}

	function toggleAnswer(element) {
		var target = event.target;
		
		if(!target.closest('.col_6') && !target.closest('.col_7')){
		    var answerRow = element.nextElementSibling; // 다음 요소인 답변 행을 선택
		
		    // 답변의 현재 display 상태 확인
		    if (answerRow.style.display === "block") {
		        answerRow.style.display = "none"; // 답변 숨기기
		    } else {
		        answerRow.style.display = "block"; // 답변 표시
		    }
		}
	}
	
	function submitAnswer(qna_num) {
		console.log("qna_num >>>>>" + qna_num);
		const textarea = document.querySelector(`#answerRow_`+qna_num);
	    
	    if (!textarea) {
	        console.error(`Textarea not found for QNA number:`);
	        alert("해당 Q&A에 대한 답변란이 없습니다.");
	        return; // 함수를 종료하여 오류 발생 방지
	    }
	    
	    const answer = textarea.value;
	
	    console.log("textarea >>>>>" + textarea);
		if(answer === "") {
			alert("답변을 입력하세요.")
			return;
		}
		
		$.ajax({
			type : "POST",
			url : "/mh/submitAnswer",
			data : {qnaNum:qna_num, answer:answer},
			success : function(response) {
				console.log(`response: ` + response);
				updateQnaList(qna_num, answer);
				 location.reload();
			},
			error: function(xhr, status, error) {
				alert("답변 제출에 실패했습니다. 다시 시도해주세요.");
				console.err("Error : ", error);
			}
		});
		textarea.value = '';
	}
	function updateQnaList(qna_num, answer) {
	    const answerRow = document.querySelector(`#answerRow_` + qna_num);
	    console.log("answerRow >>>", answerRow);  // Check if answerRow is correctly selected
	    
	    if (answerRow) {
	        const answerElement = document.createElement('p');
	        answerElement.textContent = answer;

	        const answerSection = answerRow.closest('.manager_Qna_answer');
	        console.log("answerSection >>>", answerSection);  // Check if answerSection is found correctly
	        if (answerSection) {
	            answerSection.innerHTML = ''; 
	            answerSection.appendChild(answerElement); 
	        }

	    }
	}
	
	function openImagePreview(fileUrl) {
	    // 이미지 파일 확장자 체크 (jpg, png, gif 등)
	    const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
	    const fileExtension = fileUrl.split('.').pop().toLowerCase();
	    
	    // 파일이 이미지 형식인 경우 새 창에 이미지 미리보기 표시
	    if (imageExtensions.includes(fileExtension)) {
	        window.open(fileUrl, '_blank', 'width=800,height=600');
	        return false; // a 태그의 기본 다운로드 동작 중지
	    }
	    // 이미지가 아니면 다운로드 동작 진행
	    return true;
	}
	
</script>
</head>
<body>
	<div class="manager_Qna_continer">
        <div class="manager_Qna_header">
            <div class="manager_Qna_header_text">문의내역</div>
            <div class="manager_Qna_header_search">
	            <input type="text" name="keyword" class="keyword" id="keyword" placeholder="검색어를 입력하세요.">
	            <button onclick="searchQna()" class="manager_Qna_header_search_but">검색</button>
            </div>
            <div class="manager_Qna_header_but">
            	<button class="Qna_header_but" onclick="filterUnanswered()"><div class="Qna_header_but_text">답변전</div></button>
            </div>
        </div>
        <div class="manager_Qna_List" >
            <table class="manager_Qna_table">
                <tr class="tr_1">
                    <td class="col_1"><div class="manager_Qna_text_1">대분류</div></td>
                    <td class="col_2"><div class="manager_Qna_text_1">문의유형</div></td>
                    <td class="col_3"><div class="manager_Qna_text_1">문의아이디</div></td>
                    <td class="col_4"><div class="manager_Qna_text_1">문의제목</div></td>
                    <td class="col_5"><div class="manager_Qna_text_1">문의날짜</div></td>
                    <td class="col_6"><div class="manager_Qna_text_1">첨부파일</div></td>
                    <td class="col_7"><div class="manager_Qna_text_1">답변여부</div></td>
                </tr>
                <c:forEach var="Qna" items="${qnaList}">
                <tr class="answer_item" onclick="toggleAnswer(this);" id="tr_2">
                        <td class="col_1" ><div class="manager_Qna_td_text">질문</div></td>
                        <td class="col_2" ><div class="manager_Qna_td_text2">${Qna.qna_cls }</div></td>
                        <td class="col_3" ><div class="manager_Qna_td_text2">${Qna.user_id }</div></td>
                        <td class="col_4" ><div class="manager_Qna_td_text2">${Qna.qna_title }</div></td>
                        <td class="col_5" ><div class="manager_Qna_td_text2">${Qna.qna_date }</div></td>
                        <td class="col_6">
                        	<c:choose>
                        		<c:when test="${Qna.file_url == null || Qna.file_url == '' }">
                        			<div class="manager_Qna_td_text2">파일이 없습니다.</div>
                        		</c:when>
                        		<c:otherwise>
		                        	<a href="<%-- ${Qna.file_url } --%><%=request.getContextPath()%>/cs/qna/${Qna.file_name}" 
						               <%-- download="${Qna.qna_title }_${Qna.qna_num}"  --%>
						               class="manager_Qna_td_text2" 
						               onclick="return openImagePreview('<%=request.getContextPath()%>/cs/qna/${Qna.file_name}');">
						               <img src="<%=request.getContextPath()%>/images/main/폴더_icon.png" alt="첨부파일" class="a_but_img">
						            </a>
                        		</c:otherwise>
                        	</c:choose>
                        </td>
                        <td class="col_7">
	                        <div class="manager_Qna_td_answer">
	                        	<c:choose>
	                        		<c:when test="${Qna.qna_useyn == 1 }">
	                        			<div class="manager_Qna_td_box2"><div class="manager_Qna_td_text6">답변완료</div></div>
	                        		</c:when>
	                        		<c:otherwise>
	                        			<div class="manager_Qna_td_box1"><div class="manager_Qna_td_text5">답변 전</div></div>
	                        		</c:otherwise>
	                        	</c:choose>
	                        </div>
                        </td>
                    </tr>
                    <tr class="answerRow">
                        <td colspan="5" class="col_8">
                            <div class="manager_Qna_answer">
                                <c:if test="${Qna.ans_content != null}">
                                	<div class="manager_Qna_answer_do_1">
                                		<div class="manager_Qna_answer_title">문의내용</div>
                                		<div class="manager_Qna_answer_back">
                                			<div class="manager_Qna_answer_text1">${Qna.qna_content}</div>
                                		</div>
                                	</div>
                                	<div class="manager_Qna_answer_do_2">
                                		<div class="manager_Qna_answer_title">답변내용</div>
                                		<div class="manager_Qna_answer_back_2">
		                                    <div class="manager_Qna_answer_text1">${Qna.ans_content}</div>
		                                </div>
		                                <div class="manager_Qna_answer_text3">답변 날짜 : ${Qna.ans_date }</div>
                                    </div>
                                </c:if>
                                <c:if test="${Qna.ans_content == null}">
                                	<div class="manager_Qna_answer_do_3">
                                		<div class="manager_Qna_answer_title">문의내용</div>
                                		<div class="manager_Qna_answer_back">
	                                		<div class="manager_Qna_answer_text1">${Qna.qna_content}</div>
	                                	</div>
	                                	<div class="manager_Qna_answer_title">답변내용작성</div>
	                                   	<textarea id="answerRow_${Qna.qna_num}" placeholder="답변을 입력해주세요..." class="manager_Qna_answer_textarea"></textarea>
	   									<button class="manager_Qna_answer_but" onclick="submitAnswer(${Qna.qna_num});">답변 제출</button>
   									</div>
                                </c:if>
                            </div>
                        </td>
                	</tr>
                </c:forEach>
            </table>
           
        </div>
        <div class="manager_pagination">
		    <a class="manager_pagination_a <c:if test='${currentPage == 1}'>disabled</c:if>" 
		       href="<c:if test='${currentPage > 1}'>?pageNum=${currentPage - 1}<c:if test='${answerStatus != null}'> &answerStatus=${answerStatus}</c:if></c:if>"><div class="manager_pagination_a_back">이전</div></a>
		
		    <c:set var="startPage" value="${currentPage - 2}" />
		    <c:set var="endPage" value="${currentPage + 2}" />
		    <c:if test="${startPage < 1}">
		        <c:set var="endPage" value="${endPage + (1 - startPage)}" />
		        <c:set var="startPage" value="1" />
		    </c:if>
		    <c:if test="${endPage > totalPages}">
		        <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
		        <c:set var="endPage" value="${totalPages}" />
		    </c:if>
		    <c:if test="${startPage < 1}">
		        <c:set var="startPage" value="1" />
		    </c:if>
		
		    <c:forEach var="i" begin="${startPage}" end="${endPage}">
		        <c:choose>
		            <c:when test="${i == currentPage}">
		                <span class="manager_pagination_current">${i}</span>
		            </c:when>
		            <c:otherwise>
		                <a class="manager_pagination_a" 
		                	href="?pageNum=${i}<c:if test='${keyword != null}'>&keyword=${keyword}</c:if><c:if test='${answerStatus != null}'> &answerStatus=${answerStatus}</c:if>">${i}</a>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		
		    <a class="manager_pagination_a <c:if test='${currentPage == totalPages}'>disabled</c:if>" 
		       href="<c:if test='${currentPage < totalPages}'>?pageNum=${currentPage + 1}<c:if test='${answerStatus != null}'> &answerStatus=${answerStatus}</c:if></c:if>"><div class="manager_pagination_a_next">다음</div></a>
		</div>
    </div>
</body>
</html>