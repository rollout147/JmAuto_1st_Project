		 
	 
		google.charts.load('current', {'packages':['table', 'corechart']});
		google.charts.setOnLoadCallback(drawTable);

        function drawTable() {
			
            var data = new google.visualization.DataTable();
            data.addColumn('string', '분기');
            data.addColumn('number', '자동차 판매량 합계');
            data.addColumn('number', '소비자 입금액 합계(억원)');
            data.addColumn('number', '판매자 입금액 합계(억원)');
            data.addColumn('number', '세금 합계(만원)');
            data.addColumn('number', '판매 수수료(5%) 합계(만원)');
            data.addColumn('number', '대행수수료 합계(만원)');
            data.addColumn('number', '매출 합계(만원)');
 
 
			let total = [0, 0, 0, 0, 0, 0, 0, 0]; // 각 항목의 합계를 저장할 배열
		
		    adminQuarterCostList.forEach(entry => {
		        data.addRow(entry); // 행 추가
		
		        // 합계 계산
		        for (let i = 1; i < total.length; i++) {
		            total[i] += entry[i]; // 항목별 합계 계산
		        }
		    });
		
		    // '합계' 행 추가
		    data.addRow(['합계', total[1], total[2], total[3], total[4], total[5], total[6], total[7]]);


            var table = new google.visualization.Table(document.getElementById('quarter_cost_chart_div'));
            table.draw(data);
        
						        
			var comboData = new google.visualization.DataTable();
			comboData.addColumn('string', '분기');
			comboData.addColumn('number', '매출 합계(만원)');
			
			comboData.addRows(adminQuarterSalesList);
				
			/* 데이터값을 차트에 보여주지만 적용시 애니메이션을 적용할 수 없음
			var view = new google.visualization.DataView(comboData);
			view.setColumns([
			    0, // 분기 (QUARTER)
			    1, // 매출 합계 (TOTAL_SALES)
			    { 
			        calc: "stringify",  // 숫자 데이터를 문자열로 변환하여 주석으로 사용
			        sourceColumn: 1,    // 1번 열(TOTAL_SALES)
			        type: "string",
			        role: "annotation"  // 주석 역할
			    }
			]);
			*/
								
			var options = {
					title          : year + '년 분기별 총매출액',
			    	titleTextStyle : { fontSize: 20 },
			    	series         : {
			        	 0         : { color: '#ff4714' } // 첫번째 차트 바 색깔
			    	},
			    	width          : 1200,
			    	height         : 373,
			 		animation      : {
			        	startup    : true,
			        	duration   : 1200, 
			        	easing     : 'out'
			    	},
			    	legend: {
        				position: 'bottom',        // 범례 위치
        				textStyle: { fontSize: 16 } // 범례 글씨 크기 조정
    				}
				  /*  annotations     : { 
	                  alwaysOutside : true, 
	                      textStyle : { 
	                          color : 'black' 
	                      }
	                }*/
			};
			
			var comboChart = new google.visualization.ColumnChart(document.getElementById('quarter_sales_chart_div'));
			comboChart.draw(comboData, options);
		}
			
			
			