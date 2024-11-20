		
		
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(brand_Chart);
		google.charts.setOnLoadCallback(type_Chart);

		//브랜드별 실적
		function brand_Chart() {

			var brand_data = new google.visualization.DataTable();
			brand_data.addColumn('string', '브랜드');
			brand_data.addColumn('number', '판매율');
		
		for (var brand in brandTypeResults) {
			brand_data.addRow([brand, brandTypeResults[brand]]);
		}

   			var options = {
				   title   : year + '년 브랜드별 실적',
                   width   : 800,
                   height  : 450,
                   is3D    : true
            };

   			var chart = new google.visualization.PieChart(document.getElementById('brand_chart_div'));
   			chart.draw(brand_data, options);
		}
		
		//차량 종류별 실적
		function type_Chart() {

			var type_data = new google.visualization.DataTable();
			type_data.addColumn('string', '차 종류');
			type_data.addColumn('number', '실적');
		     
        for (var type in carTypeResults) {
			type_data.addRow([type, carTypeResults[type]]);
        }
        
   			var options = {
				   title   : year + '년 차량 종류별 실적',
                   width   : 800,
                   height  : 450,
                   is3D    : true
            };

   			var chart = new google.visualization.PieChart(document.getElementById('type_chart_div'));
   			chart.draw(type_data, options);
		}
		
		