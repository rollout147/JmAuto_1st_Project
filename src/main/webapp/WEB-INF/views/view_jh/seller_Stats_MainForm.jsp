<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="jh_jstl.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="/css/jh_Stats_Chart.css">
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> 

	<!-- controller에서 받은 값을 객체화해서 외부javaScript(차트)로 보내는 로직 --------------->
	<!-- 2024년 매출차트(처음 팝업창 열면 나옴) -------------------------------------------->
	<script type="text/javascript">
	    var salesProfitResults = {
	        <c:forEach var="entry" items="${sales_profit_results}" varStatus="status">
	            "${entry.key}": {
	                QUARTER: "${entry.value.QUARTER}", // 문자열로 감싸기
	                TOTAL_PRICE: ${entry.value.TOTAL_PRICE},
	            } <c:if test="${!status.last}">,</c:if>
	        </c:forEach>
	    };
	</script>
	
	<!-- 분기별 실적 ---------------------------------------------------------------->
	<script type="text/javascript">
		var year = ${year};
		//분기별 실적 데이터 
	    var quarterlyResults = {
	        <c:forEach var="entry" items="${quarterly_results}" varStatus="status">
	            "${entry.key}": {
	                QUARTER: ${entry.value.QUARTER},
	                TOTAL_PRICE: ${entry.value.TOTAL_PRICE},
	                TOTAL_SALES: ${entry.value.TOTAL_SALES}
	            } <c:if test="${!status.last}">,</c:if>
	        </c:forEach>
	    };
	</script>
		
	<!-- 연도별 실적 --------------------------------------------------------------->
	<script type="text/javascript">
		//연도별 실적 데이터
    	var annualPerformance = {};
	    	<c:forEach var="entry" items="${annual_performance}">
	        	annualPerformance["${entry.key}"] = {
		            YEAR: ${entry.value.YEAR},
		            TOTAL_PRICE: ${entry.value.TOTAL_PRICE},
		            TOTAL_SALES: ${entry.value.TOTAL_SALES}
	        	};
			</c:forEach>
	</script>

	<!-- 차량/브랜드별 판매실적 ------------------------------------------------------------>
	<script type="text/javascript">
		var year = ${year};
		//차량별 실적 데이터
	    var carTypeResults = {};
		    <c:forEach var="entry" items="${car_type_results}">
		        var carType = "${entry.key}";
		        var sales = ${entry.value.SALES}; 
		        carTypeResults[carType] = sales; 
		    </c:forEach>
		    console.log("Car Type Results:", carTypeResults); // 디버깅 위해 출력
	
	    	// 브랜드별 실적 데이터
		    var brandTypeResults = {};
		    <c:forEach var="entry" items="${brand_type_results}">
		        var brand = "${entry.key}";
		        var sales = ${entry.value.SALES}; 
		        brandTypeResults[brand] = sales; 
		    </c:forEach>
		    console.log("Brand Type Results:", brandTypeResults); // 디버깅 위해 출력
	</script>
	
	<!-- 재고내역 조회 ---------------------------------------------------------------->
	<script type="text/javascript">
		//재고목록 데이터
		 var vehicleDataList = [
            <c:forEach var="entry" items="${jago_list}" varStatus="status"> {
                vehicleNumber: '${entry.value.get("매물번호")}',
                date: '${entry.value.get("날짜")}',  
                carNumber: '${entry.value.get("차량번호")}',
                model: '${entry.value.get("모델")}',
                carType: '${entry.value.get("차종")}',
                price: ${entry.value.get("차량가격")},
                status: '${entry.value.get("현재상태")}'
            } <c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
	</script>

	<!-- 입고내역 조회 ---------------------------------------------------------------->
	<script type="text/javascript">
    	var carData = [
        	<c:forEach var="car" items="${receiving_list}"> {
	                sellNum: "${car.SELL_NUM}",               // 매물번호
	                approvalDate: "${car.REG_DATE}",          // 등록일자
	                carNum: "${car.CAR_NUM}",                 // 차량번호
	                model: "${car.MODEL}",                    // 모델
	                carType: "${car.CAR_TYPE}",               // 차종
	                price: ${car.PRICE},                      // 차량가격
	                sale: "${car.SALE}"                       // 현재상태
            } <c:if test="${!carStatus.last}">,</c:if>
        	</c:forEach>
    	];
	</script>
	
	<!-- 출고내역 조회 ---------------------------------------------------------------->
	<script type="text/javascript">
	    var carData2 = [
	        <c:forEach var="entry" items="${delivery_list}"> {
	                sellNum: "${entry.value.SELL_NUM}",             
	                approvalDate: "${entry.value.APPROVAL_DATE}",   
	                carNum: "${entry.value.CAR_NUM}",                
	                model: "${entry.value.MODEL}",                  
	                carType: "${entry.value.CAR_TYPE}",              
	                price: ${entry.value.PRICE},                   
	                regDate: "${entry.value.REG_DATE}",
	                sale: "${entry.value.SALE}"      
	        } <c:if test="${!entryStatus.last}">,</c:if>
	        </c:forEach>
	    ];
	</script>

	<!-- 비용내역 조회 ---------------------------------------------------------------->
	<script type="text/javascript">
		var costData = {
			<c:set var="isFirst" value="true" />
	        <c:forEach var="entry" items="${cost_list}">
				<c:if test="${!isFirst}">,</c:if>
					"${entry.key}": {
						"SELL_NUM": "${entry.value.SELL_NUM}",
						"CAR_NUM": "${entry.value.CAR_NUM}",
						"APPROVAL_DATE": "${entry.value.APPROVAL_DATE}",
						"TOTAL_PRICE": "${entry.value.TOTAL_PRICE}",
						"PRICE": "${entry.value.PRICE}",
						"TAX": "${entry.value.TAX}",
						"FEE": "${entry.value.FEE}",
						"BUZ_FEE": "${entry.value.BUZ_FEE}",
						"BUZ_MONEY": "${entry.value.BUZ_MONEY}"
	                }
			<c:set var="isFirst" value="false" />
			</c:forEach>
        };
    </script>

    <!-- ------------------------ 외부javaScript(차트) 로드 --------------------------->
    <!-- 2024년 매출차트(처음 팝업창 열면 자동으로 나옴) ------------------------------------------------------->
    <c:if test="${sales_profitDataFetched}">
		<script type="text/javascript" src="/js/jh_sales_profit_chart.js"></script> 
	</c:if> 
    
	<!-- 분기별 실적차트(막대차트) ------------------------------------------------------->
	<c:if test="${quarterlyDataFetched}">
		<script type="text/javascript" src="/js/jh_quarterly_chart.js"></script> 
	</c:if> 
	
	<!-- 연도별 실적차트(막대차트) ----------------------------------------------------->
	<c:if test="${annualDataFetched}"> 
		<script type="text/javascript" src="/js/jh_annual_chart.js"></script> 
	</c:if>   
    
    <!-- 차량/브랜드별 실적차트(원형차트)--------------------------------------------------->
	<c:if test="${brand_typeDataFetched}"> 
		<script type="text/javascript" src="/js/jh_car_type_chart.js"></script> 
	</c:if>
	
	<!-- 재고내역 -------------------------------------------------------------------->
	<c:if test="${jagoListDataFetched}"> 
		<script type="text/javascript" src="/js/jh_jago_List.js"></script> 
	</c:if>
	  
	<!-- 입고내역 ------------------------------------------------------------------->
	<c:if test="${receivingListDataFetched}">  
		<script type="text/javascript" src="/js/jh_receiving_List.js"></script> 
	</c:if> 
	  
	<!-- 출고내역 ------------------------------------------------------------------->
	<c:if test="${deliveryListDataFetched}">  
		<script type="text/javascript" src="/js/jh_delivery_List.js"></script> 
	</c:if> 
			  
	<!-- 비용내역 ------------------------------------------------------------------->
	<c:if test="${costListDataFetched}">  
		<script type="text/javascript" src="/js/jh_cost_List.js"></script> 
	</c:if> 
	
</head>
<body>

  	<!-- 최상단 알림상자 --------------------------------------------------------------------------->
	<div class="attentionBox">
    	<img alt="경고아이콘" src="/images/main/jh_attention_Icon.png" width="50" height="50">최근 5년 조회가능
    </div> 
    
    <!-- 분기별 실적 연도조회버튼(우측 상단에 뜨는 연도 조회버튼)---------------------------------------------->
	<div class="inquiry">
	 	<form action="/view_jh/quarterly_results">
	 		<div class="inquiry_gigan">
	 			<h5 id="inquiry_gigan">분기별 실적</h5>
	 		</div>
	 		<div class="inquiry_year_btn">
				<select name="year" class="inquiry_year">
				<option value="2024" <c:if test="${year == 2024}">selected</c:if>>2024</option>
                <option value="2023" <c:if test="${year == 2023}">selected</c:if>>2023</option>
                <option value="2022" <c:if test="${year == 2022}">selected</c:if>>2022</option>
                <option value="2021" <c:if test="${year == 2021}">selected</c:if>>2021</option>
                <option value="2020" <c:if test="${year == 2020}">selected</c:if>>2020</option>
				</select>
				<input type="submit" value="✔조회" class="inquiry_btn">
			</div>
		</form>
	</div>
  
   <!-- 차량/브랜드별 판매실적 연도조회버튼(우측 상단에 뜨는 연도 조회버튼) -------------------------------------->
	<div class="inquiry2">
	 	<form action="/view_jh/brand_type_results">
	 		<div class="inquiry_gigan2">
	 			<h5 id="inquiry_gigan2">차량/브랜드별 실적</h5>
	 		</div>
	 		<div class="inquiry_year_btn2">
				<select name="year" class="inquiry_year2">
				<option value="2024" <c:if test="${year == 2024}">selected</c:if>>2024</option>
                <option value="2023" <c:if test="${year == 2023}">selected</c:if>>2023</option>
                <option value="2022" <c:if test="${year == 2022}">selected</c:if>>2022</option>
                <option value="2021" <c:if test="${year == 2021}">selected</c:if>>2021</option>
                <option value="2020" <c:if test="${year == 2020}">selected</c:if>>2020</option>
				</select>
				<input type="submit" value="✔조회" class="inquiry_btn2">
			</div>
		</form>
	</div>   
    
    <!-- 좌측 중간 버튼3개 ------------------------------------------------------------------------------->  		      
	<div class="btn_container">
		<div class="performance_container">
    		<button id="performance_btn">실적</button>
    			<div class="performance_hidden_btn"> 
	  					<button id="quarterly_performance">분기별 실적</button> 
	  				<a href="/view_jh/annual_performance">
	  					<button id="annual_performance">연도별 실적</button></a>
	  					<button id="car_type_sales_performance">차량/브랜드별 판매실적</button>
  				</div>   
		</div>
	         
		<div class="stock_list_container">
			<button id="stock_list">재고목록</button>
   				<div class="stock_list_hidden_btn"> 
	  				<a href="/view_jh/jago_list">
	  					<button id="inventory_details">재고내역</button></a>
	 			 	<a href="/view_jh/receiving_list">
	  					<button id="receiving_details">입고내역</button></a> 
	  				<a href="/view_jh/delivery_list">
	  					<button id="delivery_details">출고내역</button></a>
  				</div> 					               	
		</div>
   		
   		<a href="/view_jh/cost_list">    
			<button id="cost">비용내역</button></a>      
   	</div>  
	
	
	<!-- 2024년 매출차트(처음 팝업창 열면 나옴) -------------------------------------------->
	<c:if test="${sales_profitDataFetched}">
		<div class="sales_profit_chart_container">
			<div id="sales_profit_chart_div"></div>
		</div>     
	</c:if> 
	
	<!-- 분기별 실적 차트 로드 --------------------------------------------------------------------->
	<c:if test="${quarterlyDataFetched}">
		<div class="quarterly_chart_container">
			<div id="quarterly_table_div"></div>
			<div id="quarterly_chart_div"></div>
		</div>     
	</c:if> 
	 
	 <!-- 연도별 실적 차트 로드 --------------------------------------------------------------------->
	<c:if test="${annualDataFetched}"> 
		<div class="annual_chart_container">
			<div id="annual_table_div"></div>
			<div id="annual_chart_div"></div>
		</div>   
	</c:if>
  
	 <!-- 차량/브랜드별 판매차트 로드----------------------------------------------------------------------->
	<c:if test="${brand_typeDataFetched}"> 
    	<div class="car_type_chart_container">
			<div id="brand_chart_div"></div>
			<div id="type_chart_div"></div>
		</div>  
	</c:if>  
  
    <!-- 재고내역 데이터테이블 로드 -------------------------------------------------------------------------->
    <c:if test="${jagoListDataFetched}"> 
		<div class="jago_chart_chart_container">
			<input type="text" id="searchInput" onkeyup="searchTable()" placeholder="검색어를 입력하세요">
			시작 날짜: <input type="date" id="startDateInput" placeholder="YYYY-MM-DD">
    		종료 날짜: <input type="date" id="endDateInput" placeholder="YYYY-MM-DD">
			<button onclick="searchByDateRange()">날짜 검색</button>
			<button onclick="resetFilters()">입력 초기화</button>
			<div id="jago_chart_div"></div>
		</div>    
	</c:if>  
        
    <!-- 입고내역 데이터테이블 로드-------------------------------------------------------------------------->
	<c:if test="${receivingListDataFetched}">  
    	<div class="receiving_chart_container">
	        <input type="text" id="searchInput" onkeyup="applyFilters()" placeholder="검색어를 입력하세요">
	        시작 날짜: <input type="date" id="startDateInput">
	        종료 날짜: <input type="date" id="endDateInput">
	        <button onclick="applyFilters()">날짜 검색</button>
	        <button onclick="resetFilters()">입력 초기화</button>
        	<div id="receiving_chart_div"></div>
    	</div>
	</c:if>   
    
	<!-- 출고내역 데이터테이블 로드-------------------------------------------------------------------------->
	<c:if test="${deliveryListDataFetched}">
	    <div class="delivery_chart_container">
	        <input type="text" id="searchInput2" onkeyup="searchTable()" placeholder="검색어를 입력하세요">
	        시작 날짜: <input type="date" id="startDateInput">
	        종료 날짜: <input type="date" id="endDateInput">
	        <button onclick="searchTable()">날짜 검색</button>
	        <button onclick="resetFilters()">입력 초기화</button>
	        <div id="delivery_chart_div"></div> 
	    </div>
	</c:if>

	<!-- !-- 비용내역 데이터테이블 로드 ---------------------------------------------------------------------->
	<c:if test="${costListDataFetched}"> 
		<div class="cost_chart_container">
			<input type="text" id="searchInput3" placeholder="검색어를 입력하세요" oninput="searchTable()" />
			시작 날짜: <input type="date" id="startDate" placeholder="시작 날짜" />
			종료 날짜: <input type="date" id="endDate" placeholder="종료 날짜" />
			<button onclick="filterByDate()">날짜 검색</button>
			<button onclick="resetFilters()">입력 초기화</button>
			<div id="cost_chart_div"></div>
		</div>
	</c:if>        
    
	<!-- 우측 상단에 뜨는 연도 조회버튼 외부javaScript 설정 -------------------------->
	<script type="text/javascript" src="/js/jh_seller_inquiry_btn.js"></script> 
  
</body>
</html>
