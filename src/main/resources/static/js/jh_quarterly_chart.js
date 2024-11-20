
	
		google.charts.load('current', {'packages':['table', 'corechart']});
        google.charts.setOnLoadCallback(drawCharts);
         
        function drawCharts() {
			
        	//데이터테이블 값 입력
            var tabledata = new google.visualization.DataTable();
            tabledata.addColumn('string', '분기별 실적');
            tabledata.addColumn('number', '자동차 판매량(단위/대)');
            tabledata.addColumn('number', '매출수익(단위/억)');
            
   		var totalSales = 0;
		var totalPrice = 0;

    	for (var quarter in quarterlyResults) {
        	if (quarterlyResults.hasOwnProperty(quarter)) {
            	var result = quarterlyResults[quarter];

            // 판매량과 매출수익을 테이블에 추가
            tabledata.addRow([result.QUARTER + '분기', result.TOTAL_SALES, parseFloat((result.TOTAL_PRICE / 100000000).toFixed(2))]);

            // 합계(판매량, 매출수익) 생성
            totalSales += result.TOTAL_SALES;
            totalPrice += result.TOTAL_PRICE / 100000000; // 합계도 억원 단위로 누적
        	}
    	}	
    		// 합계 추가, 소수점 두번째 자리까지 표시
    		tabledata.addRow(['합계', totalSales, parseFloat(totalPrice.toFixed(2))]);
  
            // 데이터테이블 생성
            var table = new google.visualization.Table(document.getElementById('quarterly_table_div'));
            table.draw(tabledata);

/*----------------------------------------------------------------------------------------------------------------------------------*/       
           
           	// 막대차트 값 입력
            var chartdata = new google.visualization.DataTable();
            chartdata.addColumn('string', '분기별 실적');
            chartdata.addColumn('number', '자동차 판매량(단위/대)');
            chartdata.addColumn('number', '매출수익(단위/억)');
        
		for (var quarter in quarterlyResults) {
			if (quarterlyResults.hasOwnProperty(quarter)) {
				var result = quarterlyResults[quarter];
	        
	        // 판매량과 매출수익을 테이블에 추가
	        chartdata.addRow([result.QUARTER + '분기', result.TOTAL_SALES, parseFloat((result.TOTAL_PRICE / 100000000).toFixed(2))]); 
			}
		}
 
            var view = new google.visualization.DataView(chartdata);
            view.setColumns([0, 1,
                              { calc         : "stringify",
                                sourceColumn : 1,
                                type         : "string",
                                role         : "annotation"}, 
                                2, 
                              { calc         : "stringify",
                                sourceColumn : 2,
                                type         : "string",
                                role         : "annotation"}
          	]); 
                
            //막대차트 옵션
            var chartOptions = {
                    title           : year + '년 분기별 실적',
                    width           : 800,
                    height          : 400,
                    titleTextStyle  : { fontSize: 20 },
                    chartArea       : { top : 50 },
                    legend          : { position : 'bottom' },
                    series          : {
                         0          : { color : '#f0a93f' }, // 첫번째 차트바 색깔 
                         1          : { color : '#ff4714' }, // 두번째 차트바 색깔
                    },
                    annotations     : { 
                      alwaysOutside : true, 
                          textStyle : { 
                              color : 'black' 
                          }
                    }
            };
            
            //막대차트 생성
            var chart = new google.visualization.ColumnChart(document.getElementById('quarterly_chart_div'));
            chart.draw(view, chartOptions);  
        }
        
     