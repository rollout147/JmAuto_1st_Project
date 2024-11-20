<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>승인 요청한 사람 상세 정보 페이지</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Pretendard';
           background-color: #fafafa;
        }

        .content {
            background-color: #fafafa;
            height: 100%;
            
        }

        .container {
            background-color: #fafafa;
            width: 100%;
           	height: 100%
        }

        table {
            margin: 40px auto;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 600px;
            border-collapse: collapse;
            background-color: white;
        }

        th, td {
            text-align: left; /* 왼쪽 정렬 */
   			 padding: 20px;
        }
        td{
        	text-align: center;
        }

        tr {
            border-bottom: 1px solid #ddd;
        }

        td img {
            width: 300px;
            height: auto;
            cursor: pointer; /* 커서 스타일 변경 */
        }

        /* 모달 스타일 */
        .modal {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 배경색을 더 연하게 */
            display: flex; /* flexbox로 변경 */
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
        }

        .modal img {
            max-width: 70%;
            max-height: 70%;
        }
        
        caption {
		font-size: 30px;
		font-weight: bold;
		margin-bottom: 20px; 
}
#deleteBtn {
	background-color: #ff4714;
	border: none;
	color: #fafafa;
	margin: 0 10px;
	padding: 10px 20px;
}

#deleteBtn:hover {
	color: #ffffffcc;
}
    </style>
    <script type="text/javascript" src="../js/jquery.js"></script>
    <script type="text/javascript">
    $(document).ready(function() {
        $('#modal').hide(); // 페이지 로드 시 모달 숨기기

        // 이미지 클릭 시 모달 열기
        $('.modal-image').click(function() {
            var src = $(this).attr('src');
            $('#modal img').attr('src', src);
            $('#modal').fadeIn();
        });

        // 모달 클릭 시 닫기
        $('#modal').click(function(event) {
            if (event.target === this) {
                $(this).fadeOut();
            }
        });
    });
    
	function userApprove(userId) {
		alert("userid>> " + userId);
		$.ajax({
			url: '/view_jm/userApprove',
			type: 'GET',
			dataType: 'json',
			data: { 'user_id': userId },
			success: function(response) {
				alert("사용자의 계정이 승인처리 되었습니다.");
				location.reload();
			},
			error: function(error) {
				console.error("승인처리중 오류 발생", error);
				alert("처리중 오류가 발생했습니다.");
			}
		});
	}
    </script>
</head>
<body>
    <div class="content">
        <div class="contents">
            <div class="content">
                <div class="container">
                    <table>
                    <caption>회원정보</caption>
                        <thead>
                            <tr>
                                <th>아이디</th>
                                <td>${userInfo.user_id}</td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>이름</th>
                                <td>${userInfo.user_name}</td>
                            </tr>
                            <tr>
                                <th>사용자 유형</th>
                                <td>${userInfo.user_type}</td>
                            </tr>
                            <tr>
                                <th>승인여부</th>
                                <td>${userInfo.approval}</td>
                            </tr>

                            <c:choose>
                                <c:when test="${userInfo.user_type == 'S'}">
                                    <tr>
                                        <th>사업자 번호</th>
                                        <td>${userInfo.buz_num}</td>
                                    </tr>
                                    <tr>
                                        <th>사업자 상호명</th>
                                        <td>${userInfo.buz_name}</td>
                                    </tr>
                                    <tr>
                                        <th>사업자 소재지</th>
                                        <td>${userInfo.buz_addr}</td>
                                    </tr>
                                    <tr>
                                        <th>사업자 등록증</th>
                                        <td><img class="modal-image" src="${userInfo.buz_url}" alt="사업자 등록증"></td>
                                    </tr>
                                </c:when>
                                <c:when test="${userInfo.user_type == 'P'}">
                                    <tr>
                                        <th>자격증 번호</th>
                                        <td>${userInfo.cert_num}</td>
                                    </tr>
                                    <tr>
                                        <th>자격증 이름</th>
                                        <td>${userInfo.cert_name}</td>
                                    </tr>
                                    <tr>
                                        <th>자격증 발행처</th>
                                        <td>${userInfo.cert_loc}</td>
                                    </tr>
                                    <tr>
                                        <th>자격증 발행일</th>
                                        <td><fmt:formatDate value="${userInfo.cert_date}"
											pattern="yyyy. MM. dd." /></td>
                                    </tr>
                                    <tr>
                                        <th>자격증</th>
                                        <td><img class="modal-image" src="${userInfo.cert_url}" alt="자격증"></td>
                                    </tr>
                                </c:when>
                            </c:choose>
                            <tr>
                           <th>작업처리</th>
                           	<td><button id="deleteBtn"
										onclick="userApprove('${userInfo.user_id }')">승인</button>
										<button id="deleteBtn" onclick="history.back();">반려</button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
   <div id="modal" class="modal">
    <span class="close"></span>
    <img src="" alt="Modal Image">
</div>
</body>
</html>
