		 
	 
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawTable);

        function drawTable() {
				        
			var comboData = new google.visualization.DataTable();
			comboData.addColumn('string', '분기');
			comboData.addColumn('number', '매출(억원)');
				
		    Object.values(admin_sales_profit_results).forEach(entry => {
		        comboData.addRow([entry.QUARTER + " 분기", Number(entry.TOTAL_PRICE)]); // "분기" 추가
		    });
	
								
			var options = {
					title          : '2024년 분기별 매출액',
			    	titleTextStyle : { fontSize: 20 },
			    	series         : {
			        	 0         : { color: '#ff4714' } // 첫번째 차트 바 색깔
			    	},
                    width          : 800,
                    height         : 400,
			 		animation      : {
			        	startup    : true,
			        	duration   : 1200, 
			        	easing     : 'out'
			    	},
			    	legend: {
        				position: 'bottom',        // 범례 위치
        				textStyle: { fontSize: 16 } // 범례 글씨 크기 조정
    				}
			};
			
			var comboChart = new google.visualization.ColumnChart(document.getElementById('admin_sales_profit_chart_div'));
			comboChart.draw(comboData, options);
		}
			
				