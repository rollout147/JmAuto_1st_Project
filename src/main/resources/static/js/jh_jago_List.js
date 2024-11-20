
				
		google.charts.load('current', {'packages':['table', 'corechart']});
		google.charts.setOnLoadCallback(drawCharts);
		
		// 전역 변수
		var originalData = null; // 원본 데이터 저장 변수
		var filteredData = null; // 필터링된 데이터 저장 변수
		var table = null; // 테이블 객체
		
		function drawCharts() {
		    var tabledata = new google.visualization.DataTable();
		    tabledata.addColumn('string', '매물번호');
		    tabledata.addColumn('string', '날짜');
		    tabledata.addColumn('string', '차량번호');
		    tabledata.addColumn('string', '모델');
		    tabledata.addColumn('string', '차종');
		    tabledata.addColumn('number', '차량가격(만원)');
		    tabledata.addColumn('string', '현재상태');
		
		    vehicleDataList.forEach(function(vehicle) {
		        tabledata.addRow([
		            vehicle.vehicleNumber,
		            vehicle.date,
		            vehicle.carNumber,
		            vehicle.model,
		            vehicle.carType,
		            Number(vehicle.price),
		            vehicle.status
		        ]);
		    });
		
		    // 원본 데이터를 저장
		    originalData = tabledata;
		    filteredData = originalData; // 초기에는 필터링된 데이터가 원본 데이터와 동일
		
		    // 테이블 그리기
		    drawTable(filteredData);
		}
		
		// 테이블 그리기 함수
		function drawTable(data) {
		    var options = {
		        width          : 800,
		        height         : 500,
		        page           : 'enable',
		        pageSize       : 10,
		        showRowNumber  : true,
		        sortAscending  : true,
		        sortColumn     : 0
		    };
		
		    // 데이터테이블 생성
		    table = new google.visualization.Table(document.getElementById('jago_chart_div'));
		    table.draw(data, options);
		}
		
		// 키워드 검색 기능
		function searchTable() {
		    var searchText = document.getElementById('searchInput').value.toLowerCase();
		    var filteredRows = [];
		
		    for (var i = 0; i < originalData.getNumberOfRows(); i++) {
		        var rowMatchesSearch = false;
		
		        // 각 열을 확인하여 검색어와 일치하는 값이 있는지 확인
		        if (searchText) {
		            for (var j = 0; j < originalData.getNumberOfColumns(); j++) {
		                var value = originalData.getValue(i, j).toString().toLowerCase();
		                if (value.includes(searchText)) {
		                    rowMatchesSearch = true; // 일치하는 값이 있는 경우
		                    break; // 더 이상 확인할 필요 없음
		                }
		            }
		        } else {
		            rowMatchesSearch = true; // 검색어가 없으면 모든 행이 일치
		        }
		
		        // 키워드 검색에 일치하는 경우 추가
		        if (rowMatchesSearch) {
		            var row = [];
		            for (var j = 0; j < originalData.getNumberOfColumns(); j++) {
		                row.push(originalData.getValue(i, j)); // 각 열의 값을 추가
		            }
		            filteredRows.push(row); // 필터링된 행 추가
		        }
		    }
		
		    // 필터링된 데이터로 새 데이터 테이블 생성
		    filteredData = new google.visualization.DataTable();
		    filteredData.addColumn('string', '매물번호');
		    filteredData.addColumn('string', '날짜');
		    filteredData.addColumn('string', '차량번호');
		    filteredData.addColumn('string', '모델');
		    filteredData.addColumn('string', '차종');
		    filteredData.addColumn('number', '차량가격(만원)');
		    filteredData.addColumn('string', '현재상태');
		
		    filteredRows.forEach(function(row) {
		        filteredData.addRow(row);
		    });
		
		    // 테이블 다시 그리기
		    drawTable(filteredData);
		}
		
		// 날짜 범위 검색 기능
		function searchByDateRange() {
		    var startDate = document.getElementById('startDateInput').value;
		    var endDate = document.getElementById('endDateInput').value;
		
		    var start, end;
		    if (startDate && endDate) {
		        start = convertStringToDate(startDate.replace(/-/g, '/')); // "-"를 "/"로 변경
		        end = convertStringToDate(endDate.replace(/-/g, '/'));
		        end.setDate(end.getDate() + 1); // 종료 날짜 포함을 위해 하루 더함
		    }
		
		    var filteredRows = [];
		
		    for (var i = 0; i < filteredData.getNumberOfRows(); i++) {
		        var match = false;
		
		        // 날짜 비교
		        var tableDateString = filteredData.getValue(i, 1); // 두 번째 컬럼에서 날짜 문자열 가져오기
		        var tableDate = convertStringToDate(tableDateString); // Data 객체로 변환
		
		        // 날짜 범위 조건 체크
		        if (start && end) {
		            if (tableDate >= start && tableDate < end) {
		                match = true; // 날짜 범위에 포함되는 경우
		            }
		        } else {
		            match = true; // 날짜 범위가 없으면 모든 행 일치
		        }
		
		        // 날짜 범위 검색에 일치하는 경우 추가
		        if (match) {
		            var row = [];
		            for (var j = 0; j < filteredData.getNumberOfColumns(); j++) {
		                row.push(filteredData.getValue(i, j)); // 각 열의 값을 추가
		            }
		            filteredRows.push(row); // 필터링된 행 추가
		        }
		    }
		
		    // 필터링된 데이터로 새 데이터 테이블 생성
		    var newFilteredData = new google.visualization.DataTable();
		    newFilteredData.addColumn('string', '매물번호');
		    newFilteredData.addColumn('string', '날짜');
		    newFilteredData.addColumn('string', '차량번호');
		    newFilteredData.addColumn('string', '모델');
		    newFilteredData.addColumn('string', '차종');
		    newFilteredData.addColumn('number', '차량가격(만원)');
		    newFilteredData.addColumn('string', '현재상태');
		
		    filteredRows.forEach(function(row) {
		        newFilteredData.addRow(row);
		    });
		
		    // 테이블 다시 그리기
		    drawTable(newFilteredData);
		}
		
		// 문자열 형식의 날짜를 Date 객체로 변환하는 함수
		function convertStringToDate(dateString) {
		    if (dateString.includes('/')) {
		        var parts = dateString.split('/');
		        return new Date(parts[0], parts[1] - 1, parts[2]);
		    } else if (dateString.includes('-')) {
		        var parts = dateString.split('-');
		        return new Date(parts[0], parts[1] - 1, parts[2]);
		    }
		    return null; // 형식이 잘못된 경우
		}
		
		// 입력 초기화 함수
		function resetFilters() {
		    // 검색 입력 필드 초기화
		    document.getElementById('searchInput').value = '';
		    document.getElementById('startDateInput').value = '';
		    document.getElementById('endDateInput').value = '';
		
		    // 원본 데이터를 다시 필터링하여 테이블을 그림
		    filteredData = originalData; // 필터링된 데이터를 원본 데이터로 설정
		    drawTable(filteredData); // 테이블 다시 그리기
		}
		
