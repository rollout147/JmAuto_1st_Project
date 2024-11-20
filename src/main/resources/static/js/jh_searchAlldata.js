				
							
										
		// 모든 searchInput에 대해 동일한 이벤트를 설정
		document.querySelectorAll(".searchInput").forEach(function(input) {
		    // 마우스 클릭시 전체 데이터를 로드
		    input.addEventListener("focus", function() {
		        loadAllData(input);
		    });
		
		    // 입력할 때 필터링된 데이터를 로드
		    input.addEventListener("keyup", function() {
		        getSuggestions(input);
		    });
		});
		
		
		
		// 전체 데이터를 로드하는 함수
		function loadAllData(input) {
		    var suggestionsDiv = $(input).next(); // input 필드의 다음 div를 가져옴 (suggestions)
		
		    $.ajax({
		        url: "/view_jh/search/all",
		        type: "GET",
		        success: function(data) {
		            // 이미 서버에서 JSON 배열로 반환되므로 JSON.parse() 필요 없음
		            displaySuggestions(data, suggestionsDiv);
		        }
		    });
		}
		
	
		
		// 검색어 입력 시 필터링된 데이터를 가져오는 함수
		function getSuggestions(input) {
		    var inputValue = $(input).val();
		    var suggestionsDiv = $(input).next();
		
		    if (inputValue.length < 1) {
		        loadAllData(input); // 검색어가 없으면 모든 데이터를 다시 로드
		        return;
		    }
		
		    $.ajax({
		        url: "/view_jh/search/filter",
		        type: "GET",
		        data: { query: inputValue },
		        success: function(data) {
		            // 이미 서버에서 JSON 배열로 반환되므로 JSON.parse() 필요 없음
		            displaySuggestions(data, suggestionsDiv);
		        }
		    });
		}
		
/*			
		// 검색어 입력 시 필터링된 데이터를 화면에 표시하는 함수
		function displaySuggestions(suggestions, suggestionsDiv) {
		    $(suggestionsDiv).empty(); // 기존 내용 초기화
		    suggestions.forEach(function(item) {
		        var div = document.createElement("div");
		        div.className = "suggestion";
		        div.innerHTML = item;
		        div.onclick = function() {
		            $(suggestionsDiv).prev().val(item); // input 필드에 선택한 값 설정
		            loadAccountName(item); // 선택한 user_id로 account_name 로드
		            $(suggestionsDiv).empty(); // 목록 비우기
		        };
		        $(suggestionsDiv).append(div); // jQuery의 append 사용
		    });
		
		    // 검색창 외를 클릭 시 목록 숨기기
		    $(document).on("click", function(event) {
		        var isClickInsideInput = $(suggestionsDiv).prev().is(event.target);
		        var isClickInsideSuggestions = $(suggestionsDiv).is(event.target);
		
		        if (!isClickInsideInput && !isClickInsideSuggestions) {
		            $(suggestionsDiv).empty(); // 검색창 이외 클릭 시 목록 숨김
		        }
		    });
		}
		
			
		
		// accountName을 설정하는 함수
		function loadAccountName(userId) {
		    $.ajax({
		        url: "/view_jh/search/account",
		        type: "GET",
		        data: { user_id: encodeURIComponent(userId) },
		        success: function(data) {
		            // data는 이미 JSON 객체이므로 JSON.parse() 필요 없음
		            updateAccountName(data.accountName); // accountName 업데이트
		        }
		    });
		}
		
		
		
		// 페이지 로드 시 저장된 accountName을 모든 요소에 표시
		$(document).ready(function() {
		    var savedAccountName = localStorage.getItem("accountName");
		    if (savedAccountName) {
		        updateAccountName(savedAccountName);
		    }
		});
		
		
		// 선택된 모든 accountName 요소를 업데이트하는 함수
		function updateAccountName(accountName) {
		    // 모든 accountName 클래스를 가진 요소 선택
		    $(".accountName").each(function() {
		        $(this).text("판매자명 : " + accountName);
		    });
		
		    // localStorage에 accountName 저장
		    localStorage.setItem("accountName", accountName);
		}
		
*/
	
	
	
	
	
	
		// accountName을 설정하는 함수
		function loadAccountName(userId, isCorporate = false) {
		    $.ajax({
		        url: "/view_jh/search/account",
		        type: "GET",
		        data: { user_id: encodeURIComponent(userId) },
		        success: function(data) {
		            // data는 이미 JSON 객체이므로 JSON.parse() 필요 없음
		            if (isCorporate) {
		                updateCorporateAccountName(data.accountName); // 사업자명 업데이트
		            } else {
		                updateSellerAccountName(data.accountName); // 판매자명 업데이트
		            }
		        }
		    });
		}
		
		// 선택된 모든 accountName 요소를 업데이트하는 함수 (사업자명)
		function updateCorporateAccountName(accountName) {
		    // 모든 accountName 클래스를 가진 요소 선택
		    $(".accountName").each(function() {
		        $(this).text("사업자명 : " + accountName);
		    });
		
		    // localStorage에 accountName 저장
		    localStorage.setItem("accountName", accountName);
		    localStorage.setItem("isCorporate", true); // 기업 여부 저장
		}
		
		// 선택된 모든 accountName 요소를 업데이트하는 함수 (판매자명)
		function updateSellerAccountName(accountName) {
		    // 모든 accountName 클래스를 가진 요소 선택
		    $(".accountName").each(function() {
		        $(this).text("판매자명 : " + accountName);
		    });
		
		    // localStorage에 accountName 저장
		    localStorage.setItem("accountName", accountName);
		    localStorage.setItem("isCorporate", false); // 기업 여부 저장
		}
		
		// 페이지 로드 시 저장된 accountName을 모든 요소에 표시
		$(document).ready(function() {
		    var savedAccountName = localStorage.getItem("accountName");
		    var isCorporate = localStorage.getItem("isCorporate") === 'true'; // 저장된 isCorporate 값 가져오기
		    if (savedAccountName) {
		        // 저장된 값에 따라 업데이트
		        if (isCorporate) {
		            updateCorporateAccountName(savedAccountName); // 사업자명으로 업데이트
		        } else {
		            updateSellerAccountName(savedAccountName); // 판매자명으로 업데이트
		        }
		    }
		});
		
		// 검색어 입력 시 필터링된 데이터를 화면에 표시하는 함수
		function displaySuggestions(suggestions, suggestionsDiv) {
		    $(suggestionsDiv).empty(); // 기존 내용 초기화
		    suggestions.forEach(function(item) {
		        var div = document.createElement("div");
		        div.className = "suggestion";
		        div.innerHTML = item;
		        div.onclick = function() {
		            $(suggestionsDiv).prev().val(item); // input 필드에 선택한 값 설정
		
		            // isCorporate를 클릭된 검색창에 따라 설정
		            var isCorporate = ($(suggestionsDiv).prev().attr('id') === 'company'); 
		            loadAccountName(item, isCorporate); // 선택한 user_id로 account_name 로드
		            $(suggestionsDiv).empty(); // 목록 비우기
		        };
		        $(suggestionsDiv).append(div); // jQuery의 append 사용
		    });
		
		    // 검색창 외를 클릭 시 목록 숨기기
		    $(document).on("click", function(event) {
		        var isClickInsideInput = $(suggestionsDiv).prev().is(event.target);
		        var isClickInsideSuggestions = $(suggestionsDiv).is(event.target);
		
		        if (!isClickInsideInput && !isClickInsideSuggestions) {
		            $(suggestionsDiv).empty(); // 검색창 이외 클릭 시 목록 숨김
		        }
		    });
		}





			
		// 아이디를 입력하지 않고 조회 시 경고창
		function validateForm(form) {
		    var userIdInput = $(form).find(".searchInput");
		    if ($.trim(userIdInput.val()) === "") {
		        alert("아이디를 입력하시오");
		        userIdInput.focus(); // 포커스를 아이디 입력란으로 이동
		        return false; // 폼 제출을 막음
		    }
		    return true; // 폼 제출 허용
		}
		
			
		// searchInput, year 선택 및 accountName 초기화
		function resetForm() {
		    $(".searchInput").each(function() {
		        $(this).val(""); // 검색 입력 초기화
		    });
		
		    $(".admin_inquiry_year1, .admin_inquiry_year3, .admin_inquiry_year8").each(function() {
		        $(this).prop("selectedIndex", 0); // 연도 선택 초기화 (2024로 설정)
		    });
		
		    // 모든 accountName 클래스를 가진 요소의 텍스트를 비움
		    $(".accountName").each(function() {
		        $(this).text(""); // accountName 초기화
		    });
		
		    // localStorage에서 accountName 삭제
		    localStorage.removeItem("accountName");
		
		    // 포커스를 첫 번째 입력란으로 이동
		    $(".searchInput").first().focus();
		}
										
										
	