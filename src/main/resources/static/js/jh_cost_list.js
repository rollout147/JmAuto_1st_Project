		
				
		google.charts.load('current', {'packages': ['table']});
		google.charts.setOnLoadCallback(drawTable);
		
		// 전역 변수
		var originalData; // 원본 데이터 저장
		var filteredData; // 필터링된 데이터
		var table; // 테이블 인스턴스
		
		function drawTable() {
		    var data = new google.visualization.DataTable();
		    data.addColumn('string', '매물번호');
		    data.addColumn('string', '차량번호');
		    data.addColumn('string', '판매날짜');
		    data.addColumn('number', '소비자 입금액(만원)');
		    data.addColumn('number', '차량가격');
		    data.addColumn('number', '세금');
		    data.addColumn('number', '대행수수료');
		    data.addColumn('number', '판매수수료(5%)');
		    data.addColumn('number', '판매자 입금액');
		
		    var rows = [];
		    for (var key in costData) {
		        if (costData.hasOwnProperty(key)) {
		            var item = costData[key];
		            rows.push([
		                item.SELL_NUM,
		                item.CAR_NUM,
		                item.APPROVAL_DATE,
		                Math.round(Number(item.TOTAL_PRICE) / 10000), 
			            Math.round(Number(item.PRICE) / 10000),       
			            Math.round(Number(item.TAX) / 10000),       
			            Math.round(Number(item.FEE) / 10000),       
			            Math.round(Number(item.BUZ_FEE) / 10000),      
			            Math.round(Number(item.BUZ_MONEY) / 10000)
		            ]);
		        }
		    }
		
		    data.addRows(rows);
		    originalData = data; // 원본 데이터 저장
		    filteredData = originalData; // 초기 필터링 데이터는 원본 데이터
		
		    var chartOptions = {
		        width          : 800,
		        height         : 500,
		        page           : 'enable',
		        pageSize       : 10,
		        showRowNumber  : true,
		        sortAscending  : true,
		        sortColumn     : 0
		    };
		
		    table = new google.visualization.Table(document.getElementById('cost_chart_div'));
		    table.draw(filteredData, chartOptions);
		}
		
		// 키워드 검색 및 날짜 필터링 함수
		function applyFilters() {
		    var searchText = document.getElementById('searchInput3').value.toLowerCase();
		    var startDate = new Date(document.getElementById('startDate').value);
		    var endDate = new Date(document.getElementById('endDate').value);
		    var filteredRows = [];
		
		    for (var i = 0; i < originalData.getNumberOfRows(); i++) {
		        var rowMatchesSearch = false;
		
		        // 키워드 검색
		        for (var j = 0; j < originalData.getNumberOfColumns(); j++) {
		            if (originalData.getValue(i, j).toString().toLowerCase().includes(searchText)) {
		                rowMatchesSearch = true;
		                break; // 하나의 열이라도 매치하면 추가
		            }
		        }
		
		        // 날짜 범위 필터링
		        var approvalDate = new Date(originalData.getValue(i, 2)); // '판매날짜' 열의 인덱스는 2
		        if (rowMatchesSearch && (isNaN(startDate) || approvalDate >= startDate) && (isNaN(endDate) || approvalDate <= endDate)) {
		            var row = [];
		            for (var j = 0; j < originalData.getNumberOfColumns(); j++) {
		                row.push(originalData.getValue(i, j));
		            }
		            filteredRows.push(row); // 필터링된 결과 추가
		        }
		    }
		
		    // 필터링된 데이터로 DataTable 생성
		    filteredData = new google.visualization.DataTable();
		    filteredData.addColumn('string', '매물번호');
		    filteredData.addColumn('string', '차량번호');
		    filteredData.addColumn('string', '판매날짜');
		    filteredData.addColumn('number', '소비자 입금액');
		    filteredData.addColumn('number', '차량가격');
		    filteredData.addColumn('number', '세금');
		    filteredData.addColumn('number', '대행수수료');
		    filteredData.addColumn('number', '판매수수료(5%)');
		    filteredData.addColumn('number', '판매자 입금액');
		
		    filteredData.addRows(filteredRows);
		    table.draw(filteredData, {
		        width          : 800,
		        height         : 500,
		        page           : 'enable',
		        pageSize       : 10,
		        showRowNumber  : true,
		        sortAscending  : true,
		        sortColumn     : 0
		    });
		}
		
		// 날짜 범위 검색 버튼 클릭 시 필터링 함수 호출
		function filterByDate() {
		    applyFilters();
		}
		
		// 키워드 검색 입력 시 실시간 필터링
		function searchTable() {
		    applyFilters();
		}
		
		// 초기화 함수
		function resetFilters() {
		    document.getElementById('searchInput3').value = '';
		    document.getElementById('startDate').value = '';
		    document.getElementById('endDate').value = '';
		    filteredData = originalData; // 원본 데이터로 초기화
		    table.draw(originalData, {
		        width          : 800,
		        height         : 500,
		        page           : 'enable',
		        pageSize       : 10,
		        showRowNumber  : true,
		        sortAscending  : true,
		        sortColumn     : 0
		    });
		}
		
		