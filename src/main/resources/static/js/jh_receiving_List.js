		
		
		google.charts.load('current', {'packages':['table', 'corechart']});
		google.charts.setOnLoadCallback(drawCharts);
		
		var originalData = null; // 원본 데이터 저장 변수
		var table = null; // 테이블 객체
		
		function drawCharts() {
		    var tabledata = new google.visualization.DataTable();
		    tabledata.addColumn('string', '매물번호');
		    tabledata.addColumn('string', '입고일자');
		    tabledata.addColumn('string', '차량번호');
		    tabledata.addColumn('string', '모델');
		    tabledata.addColumn('string', '차종');
		    tabledata.addColumn('number', '차량가격(만원)');
		    tabledata.addColumn('string', '현재상태');
		
		    // carData 배열을 사용하여 rows를 추가
		    for (var i = 0; i < carData.length; i++) {
		        tabledata.addRow([
		            carData[i].sellNum,
		            carData[i].approvalDate,
		            carData[i].carNum,
		            carData[i].model,
		            carData[i].carType,
		            carData[i].price,
		            carData[i].sale
		        ]);
		    }
		
		    originalData = tabledata; // 원본 데이터 저장
		    drawTable(originalData); // 테이블 그리기
		}
		
		// 테이블 그리기 함수
		function drawTable(data) {
		    var chartOptions = {
		        width          : 800,
		        height         : 500,
		        page           : 'enable',
		        pageSize       : 10,
		        showRowNumber  : true,
		        sortAscending  : true,
		        sortColumn     : 0
		    };
		
		    table = new google.visualization.Table(document.getElementById('receiving_chart_div'));
		    table.draw(data, chartOptions);
		}
		
		// 키워드 검색 및 날짜 범위 검색 함수
		function applyFilters() {
		    var searchText = document.getElementById('searchInput').value.toLowerCase();
		    var startDate = document.getElementById('startDateInput').value;
		    var endDate = document.getElementById('endDateInput').value;
		
		    var filteredRows = [];
		    var start = convertStringToDate(startDate);
		    var end = convertStringToDate(endDate);
		    end.setDate(end.getDate() + 1); // 범위에 마지막 날짜 포함
		
		    for (var i = 0; i < originalData.getNumberOfRows(); i++) {
		        var rowMatchesSearch = false;
		        var rowDate = convertStringToDate(originalData.getValue(i, 1).replace(/\//g, '-')); // 입고일자
		
		        // 키워드 검색
		        for (var j = 0; j < originalData.getNumberOfColumns(); j++) {
		            var value = originalData.getValue(i, j).toString().toLowerCase();
		            if (value.includes(searchText)) {
		                rowMatchesSearch = true;
		                break;
		            }
		        }
		
		        // 날짜 범위 검색
		        if ((startDate === "" && endDate === "") || (rowDate >= start && rowDate < end)) {
		            // 두 조건이 모두 만족되면 필터된 행에 추가
		            if (rowMatchesSearch) {
		                var row = [];
		                for (var j = 0; j < originalData.getNumberOfColumns(); j++) {
		                    row.push(originalData.getValue(i, j));
		                }
		                filteredRows.push(row);
		            }
		        }
		    }
		
		    var newFilteredData = new google.visualization.DataTable();
		    newFilteredData.addColumn('string', '매물번호');
		    newFilteredData.addColumn('string', '입고일자');
		    newFilteredData.addColumn('string', '차량번호');
		    newFilteredData.addColumn('string', '모델');
		    newFilteredData.addColumn('string', '차종');
		    newFilteredData.addColumn('number', '차량가격(만원)');
		    newFilteredData.addColumn('string', '현재상태');
		
		    filteredRows.forEach(function(row) {
		        newFilteredData.addRow(row);
		    });
		
		    drawTable(newFilteredData);
		}
		
		// 입력 초기화 함수
		function resetFilters() {
		    document.getElementById('searchInput').value = '';
		    document.getElementById('startDateInput').value = '';
		    document.getElementById('endDateInput').value = '';
		
		    drawTable(originalData); // 원본 데이터로 초기화
		}
		
		// 날짜 문자열을 Date 객체로 변환하는 함수
		function convertStringToDate(dateString) {
		    var parts = dateString.split('-');
		    return new Date(parts[0], parts[1] - 1, parts[2]);
		}
	
