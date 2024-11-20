
	
	    // 1. "분기별 실적" 버튼을 클릭했을 때 연도조회버튼을 활성화 및 다른 모든 버튼 비활성화
	    document.getElementById('quarterly_performance').addEventListener('click', function() { 
	        var admin_inquiry1 = document.querySelector('.admin_inquiry1');
	        var admin_inquiry2 = document.querySelector('.admin_inquiry2'); 
	        var admin_inquiry3 = document.querySelector('.admin_inquiry3');
	        var admin_inquiry4 = document.querySelector('.admin_inquiry4');
	        var admin_inquiry5 = document.querySelector('.admin_inquiry5');
	        var admin_inquiry6 = document.querySelector('.admin_inquiry6');
	        var admin_inquiry7 = document.querySelector('.admin_inquiry7');
	        var admin_inquiry8 = document.querySelector('.admin_inquiry8');
	
	        if (admin_inquiry1) {
	            admin_inquiry1.style.display = 'inline-block';
	            sessionStorage.setItem('inquiry1Visible', 'true');
	        }
	        if (admin_inquiry2) {
	            admin_inquiry2.style.display = 'none'; 
	            sessionStorage.setItem('inquiry2Visible', 'false');
	        }
	        if (admin_inquiry3) {
	            admin_inquiry3.style.display = 'none';
	            sessionStorage.setItem('inquiry3Visible', 'false');
	        }
	        if (admin_inquiry4) {
	            admin_inquiry4.style.display = 'none'; 
	            sessionStorage.setItem('inquiry4Visible', 'false');
	        }
	        if (admin_inquiry5) {
	            admin_inquiry5.style.display = 'none'; 
	            sessionStorage.setItem('inquiry5Visible', 'false');
	        }
	        if (admin_inquiry6) {
	            admin_inquiry6.style.display = 'none';
	            sessionStorage.setItem('inquiry6Visible', 'false');
	        }
	        if (admin_inquiry7) {
	            admin_inquiry7.style.display = 'none'; 
	            sessionStorage.setItem('inquiry7Visible', 'false');
	        }  
	        if (admin_inquiry8) {
	            admin_inquiry8.style.display = 'none'; 
	            sessionStorage.setItem('inquiry8Visible', 'false');
	        }  	              	        	        
	    });
	
	
	    // 2. "연도별 실적" 버튼을 클릭했을 때 아이디조회버튼을 활성화 및 다른 모든 버튼 비활성화
	    document.getElementById('annual_performance').addEventListener('click', function() { 
	        var admin_inquiry1 = document.querySelector('.admin_inquiry1');
	        var admin_inquiry2 = document.querySelector('.admin_inquiry2'); 
	        var admin_inquiry3 = document.querySelector('.admin_inquiry3');
	        var admin_inquiry4 = document.querySelector('.admin_inquiry4');
	        var admin_inquiry5 = document.querySelector('.admin_inquiry5');
	        var admin_inquiry6 = document.querySelector('.admin_inquiry6');
	        var admin_inquiry7 = document.querySelector('.admin_inquiry7');
	        var admin_inquiry8 = document.querySelector('.admin_inquiry8');
	
	        if (admin_inquiry1) {
	            admin_inquiry1.style.display = 'none';
	            sessionStorage.setItem('inquiry1Visible', 'false');
	        }
	        if (admin_inquiry2) {
	            admin_inquiry2.style.display = 'inline-block'; 
	            sessionStorage.setItem('inquiry2Visible', 'true');
	        }
	        if (admin_inquiry3) {
	            admin_inquiry3.style.display = 'none';
	            sessionStorage.setItem('inquiry3Visible', 'false');
	        }
	        if (admin_inquiry4) {
	            admin_inquiry4.style.display = 'none'; 
	            sessionStorage.setItem('inquiry4Visible', 'false');
	        }
	        if (admin_inquiry5) {
	            admin_inquiry5.style.display = 'none'; 
	            sessionStorage.setItem('inquiry5Visible', 'false');
	        }
	        if (admin_inquiry6) {
	            admin_inquiry6.style.display = 'none';
	            sessionStorage.setItem('inquiry6Visible', 'false');
	        }
	        if (admin_inquiry7) {
	            admin_inquiry7.style.display = 'none'; 
	            sessionStorage.setItem('inquiry7Visible', 'false');
	        }  
	        if (admin_inquiry8) {
	            admin_inquiry8.style.display = 'none'; 
	            sessionStorage.setItem('inquiry8Visible', 'false');
	        }  	              	        	        
	    });	
	
	
 		// 3. "차량/브랜드별 실적" 버튼을 클릭했을 때 아이디조회버튼을 활성화 및 다른 모든 버튼 비활성화
	    document.getElementById('car_type_sales_performance').addEventListener('click', function() { 
	        var admin_inquiry1 = document.querySelector('.admin_inquiry1');
	        var admin_inquiry2 = document.querySelector('.admin_inquiry2'); 
	        var admin_inquiry3 = document.querySelector('.admin_inquiry3');
	        var admin_inquiry4 = document.querySelector('.admin_inquiry4');
	        var admin_inquiry5 = document.querySelector('.admin_inquiry5');
	        var admin_inquiry6 = document.querySelector('.admin_inquiry6');
	        var admin_inquiry7 = document.querySelector('.admin_inquiry7');
	        var admin_inquiry8 = document.querySelector('.admin_inquiry8');
	
	        if (admin_inquiry1) {
	            admin_inquiry1.style.display = 'none';
	            sessionStorage.setItem('inquiry1Visible', 'false');
	        }
	        if (admin_inquiry2) {
	            admin_inquiry2.style.display = 'none'; 
	            sessionStorage.setItem('inquiry2Visible', 'false');
	        }
	        if (admin_inquiry3) {
	            admin_inquiry3.style.display = 'inline-block';
	            sessionStorage.setItem('inquiry3Visible', 'true');
	        }
	        if (admin_inquiry4) {
	            admin_inquiry4.style.display = 'none'; 
	            sessionStorage.setItem('inquiry4Visible', 'false');
	        }
	        if (admin_inquiry5) {
	            admin_inquiry5.style.display = 'none'; 
	            sessionStorage.setItem('inquiry5Visible', 'false');
	        }
	        if (admin_inquiry6) {
	            admin_inquiry6.style.display = 'none';
	            sessionStorage.setItem('inquiry6Visible', 'false');
	        }
	        if (admin_inquiry7) {
	            admin_inquiry7.style.display = 'none'; 
	            sessionStorage.setItem('inquiry7Visible', 'false');
	        }  
	        if (admin_inquiry8) {
	            admin_inquiry8.style.display = 'none'; 
	            sessionStorage.setItem('inquiry8Visible', 'false');
	        }  	              	        	        
	    });


		// 4. "재고내역" 버튼을 클릭했을 때 아이디조회버튼을 활성화 및 다른 모든 버튼 비활성화
		document.getElementById('inventory_details').addEventListener('click', function() { 
	        var admin_inquiry1 = document.querySelector('.admin_inquiry1');
	        var admin_inquiry2 = document.querySelector('.admin_inquiry2'); 
	        var admin_inquiry3 = document.querySelector('.admin_inquiry3');
	        var admin_inquiry4 = document.querySelector('.admin_inquiry4');
	        var admin_inquiry5 = document.querySelector('.admin_inquiry5');
	        var admin_inquiry6 = document.querySelector('.admin_inquiry6');
	        var admin_inquiry7 = document.querySelector('.admin_inquiry7');
	        var admin_inquiry8 = document.querySelector('.admin_inquiry8');
	
	        if (admin_inquiry1) {
	            admin_inquiry1.style.display = 'none';
	            sessionStorage.setItem('inquiry1Visible', 'false');
	        }
	        if (admin_inquiry2) {
	            admin_inquiry2.style.display = 'none'; 
	            sessionStorage.setItem('inquiry2Visible', 'false');
	        }
	        if (admin_inquiry3) {
	            admin_inquiry3.style.display = 'none';
	            sessionStorage.setItem('inquiry3Visible', 'false');
	        }
	        if (admin_inquiry4) {
	            admin_inquiry4.style.display = 'inline-block';
	            sessionStorage.setItem('inquiry4Visible', 'true');
	        }
	        if (admin_inquiry5) {
	            admin_inquiry5.style.display = 'none'; 
	            sessionStorage.setItem('inquiry5Visible', 'false');
	        }
	        if (admin_inquiry6) {
	            admin_inquiry6.style.display = 'none';
	            sessionStorage.setItem('inquiry6Visible', 'false');
	        }
	        if (admin_inquiry7) {
	            admin_inquiry7.style.display = 'none'; 
	            sessionStorage.setItem('inquiry7Visible', 'false');
	        }  
	        if (admin_inquiry8) {
	            admin_inquiry8.style.display = 'none'; 
	            sessionStorage.setItem('inquiry8Visible', 'false');
	        }  	              	        	        
	    });
		
		
		// 5. "입고내역" 버튼을 클릭했을 때 아이디조회버튼을 활성화 및 다른 모든 버튼 비활성화
		document.getElementById('receiving_details').addEventListener('click', function() { 
	        var admin_inquiry1 = document.querySelector('.admin_inquiry1');
	        var admin_inquiry2 = document.querySelector('.admin_inquiry2'); 
	        var admin_inquiry3 = document.querySelector('.admin_inquiry3');
	        var admin_inquiry4 = document.querySelector('.admin_inquiry4');
	        var admin_inquiry5 = document.querySelector('.admin_inquiry5');
	        var admin_inquiry6 = document.querySelector('.admin_inquiry6');
	        var admin_inquiry7 = document.querySelector('.admin_inquiry7');
	        var admin_inquiry8 = document.querySelector('.admin_inquiry8');
	
	        if (admin_inquiry1) {
	            admin_inquiry1.style.display = 'none';
	            sessionStorage.setItem('inquiry1Visible', 'false');
	        }
	        if (admin_inquiry2) {
	            admin_inquiry2.style.display = 'none'; 
	            sessionStorage.setItem('inquiry2Visible', 'false');
	        }
	        if (admin_inquiry3) {
	            admin_inquiry3.style.display = 'none';
	            sessionStorage.setItem('inquiry3Visible', 'false');
	        }
	        if (admin_inquiry4) {
	            admin_inquiry4.style.display = 'none'; 
	            sessionStorage.setItem('inquiry4Visible', 'false');
	        }
	        if (admin_inquiry5) {
	            admin_inquiry5.style.display = 'inline-block'; 
	            sessionStorage.setItem('inquiry5Visible', 'true');
	        }
	        if (admin_inquiry6) {
	            admin_inquiry6.style.display = 'none';
	            sessionStorage.setItem('inquiry6Visible', 'false');
	        }
	        if (admin_inquiry7) {
	            admin_inquiry7.style.display = 'none'; 
	            sessionStorage.setItem('inquiry7Visible', 'false');
	        }  
	        if (admin_inquiry8) {
	            admin_inquiry8.style.display = 'none'; 
	            sessionStorage.setItem('inquiry8Visible', 'false');
	        }  	              	        	        
	    });
	

		// 6. "출고내역" 버튼을 클릭했을 때 아이디조회버튼을 활성화 및 다른 모든 버튼 비활성화
		document.getElementById('delivery_details').addEventListener('click', function() { 
	        var admin_inquiry1 = document.querySelector('.admin_inquiry1');
	        var admin_inquiry2 = document.querySelector('.admin_inquiry2'); 
	        var admin_inquiry3 = document.querySelector('.admin_inquiry3');
	        var admin_inquiry4 = document.querySelector('.admin_inquiry4');
	        var admin_inquiry5 = document.querySelector('.admin_inquiry5');
	        var admin_inquiry6 = document.querySelector('.admin_inquiry6');
	        var admin_inquiry7 = document.querySelector('.admin_inquiry7');
	        var admin_inquiry8 = document.querySelector('.admin_inquiry8');
	
	        if (admin_inquiry1) {
	            admin_inquiry1.style.display = 'none';
	            sessionStorage.setItem('inquiry1Visible', 'false');
	        }
	        if (admin_inquiry2) {
	            admin_inquiry2.style.display = 'none'; 
	            sessionStorage.setItem('inquiry2Visible', 'false');
	        }
	        if (admin_inquiry3) {
	            admin_inquiry3.style.display = 'none';
	            sessionStorage.setItem('inquiry3Visible', 'false');
	        }
	        if (admin_inquiry4) {
	            admin_inquiry4.style.display = 'none'; 
	            sessionStorage.setItem('inquiry4Visible', 'false');
	        }
	        if (admin_inquiry5) {
	            admin_inquiry5.style.display = 'none'; 
	            sessionStorage.setItem('inquiry5Visible', 'false');
	        }
	        if (admin_inquiry6) {
	            admin_inquiry6.style.display = 'inline-block';
	            sessionStorage.setItem('inquiry6Visible', 'true');
	        }
	        if (admin_inquiry7) {
	            admin_inquiry7.style.display = 'none'; 
	            sessionStorage.setItem('inquiry7Visible', 'false');
	        }  
	        if (admin_inquiry8) {
	            admin_inquiry8.style.display = 'none'; 
	            sessionStorage.setItem('inquiry8Visible', 'false');
	        }  	              	        	        
	    });
	
	
		// 7. "기업별 지불내역" 버튼을 클릭했을 때 아이디조회버튼을 활성화 및 다른 모든 버튼 비활성화
		document.getElementById('payment_company').addEventListener('click', function() { 
	        var admin_inquiry1 = document.querySelector('.admin_inquiry1');
	        var admin_inquiry2 = document.querySelector('.admin_inquiry2'); 
	        var admin_inquiry3 = document.querySelector('.admin_inquiry3');
	        var admin_inquiry4 = document.querySelector('.admin_inquiry4');
	        var admin_inquiry5 = document.querySelector('.admin_inquiry5');
	        var admin_inquiry6 = document.querySelector('.admin_inquiry6');
	        var admin_inquiry7 = document.querySelector('.admin_inquiry7');
	        var admin_inquiry8 = document.querySelector('.admin_inquiry8');
	
	        if (admin_inquiry1) {
	            admin_inquiry1.style.display = 'none';
	            sessionStorage.setItem('inquiry1Visible', 'false');
	        }
	        if (admin_inquiry2) {
	            admin_inquiry2.style.display = 'none'; 
	            sessionStorage.setItem('inquiry2Visible', 'false');
	        }
	        if (admin_inquiry3) {
	            admin_inquiry3.style.display = 'none';
	            sessionStorage.setItem('inquiry3Visible', 'false');
	        }
	        if (admin_inquiry4) {
	            admin_inquiry4.style.display = 'none'; 
	            sessionStorage.setItem('inquiry4Visible', 'false');
	        }
	        if (admin_inquiry5) {
	            admin_inquiry5.style.display = 'none'; 
	            sessionStorage.setItem('inquiry5Visible', 'false');
	        }
	        if (admin_inquiry6) {
	            admin_inquiry6.style.display = 'none';
	            sessionStorage.setItem('inquiry6Visible', 'false');
	        }
	        if (admin_inquiry7) {
	            admin_inquiry7.style.display = 'inline-block'; 
	            sessionStorage.setItem('inquiry7Visible', 'true');
	        }  
	        if (admin_inquiry8) {
	            admin_inquiry8.style.display = 'none'; 
	            sessionStorage.setItem('inquiry8Visible', 'false');
	        }  	              	        	        
	    });
	
	
		// 8. "분기별 지불내역" 버튼을 클릭했을 때 아이디조회버튼을 활성화 및 다른 모든 버튼 비활성화
		document.getElementById('payment_quarter').addEventListener('click', function() { 
	        var admin_inquiry1 = document.querySelector('.admin_inquiry1');
	        var admin_inquiry2 = document.querySelector('.admin_inquiry2'); 
	        var admin_inquiry3 = document.querySelector('.admin_inquiry3');
	        var admin_inquiry4 = document.querySelector('.admin_inquiry4');
	        var admin_inquiry5 = document.querySelector('.admin_inquiry5');
	        var admin_inquiry6 = document.querySelector('.admin_inquiry6');
	        var admin_inquiry7 = document.querySelector('.admin_inquiry7');
	        var admin_inquiry8 = document.querySelector('.admin_inquiry8');
	
	        if (admin_inquiry1) {
	            admin_inquiry1.style.display = 'none';
	            sessionStorage.setItem('inquiry1Visible', 'false');
	        }
	        if (admin_inquiry2) {
	            admin_inquiry2.style.display = 'none'; 
	            sessionStorage.setItem('inquiry2Visible', 'false');
	        }
	        if (admin_inquiry3) {
	            admin_inquiry3.style.display = 'none';
	            sessionStorage.setItem('inquiry3Visible', 'false');
	        }
	        if (admin_inquiry4) {
	            admin_inquiry4.style.display = 'none'; 
	            sessionStorage.setItem('inquiry4Visible', 'false');
	        }
	        if (admin_inquiry5) {
	            admin_inquiry5.style.display = 'none'; 
	            sessionStorage.setItem('inquiry5Visible', 'false');
	        }
	        if (admin_inquiry6) {
	            admin_inquiry6.style.display = 'none';
	            sessionStorage.setItem('inquiry6Visible', 'false');
	        }
	        if (admin_inquiry7) {
	            admin_inquiry7.style.display = 'none'; 
	            sessionStorage.setItem('inquiry7Visible', 'false');
	        }  
	        if (admin_inquiry8) {
	            admin_inquiry8.style.display = 'inline-block'; 
	            sessionStorage.setItem('inquiry8Visible', 'true');
	        }  	              	        	        
	    });
	
	
		// 페이지가 새로고침되어도 입력했던 데이터가 초기화되지않음
		document.addEventListener('DOMContentLoaded', function() {
		    var admin_inquiry1 = document.querySelector('.admin_inquiry1');
		    var admin_inquiry2 = document.querySelector('.admin_inquiry2');
		    var admin_inquiry3 = document.querySelector('.admin_inquiry3');
		    var admin_inquiry4 = document.querySelector('.admin_inquiry4');
		    var admin_inquiry5 = document.querySelector('.admin_inquiry5');
		    var admin_inquiry6 = document.querySelector('.admin_inquiry6');
		    var admin_inquiry7 = document.querySelector('.admin_inquiry7');
		    var admin_inquiry8 = document.querySelector('.admin_inquiry8');
		 
		    var inquiry1Visible = sessionStorage.getItem('inquiry1Visible');
		    var inquiry2Visible = sessionStorage.getItem('inquiry2Visible');
		    var inquiry3Visible = sessionStorage.getItem('inquiry3Visible');
		    var inquiry4Visible = sessionStorage.getItem('inquiry4Visible');
		    var inquiry5Visible = sessionStorage.getItem('inquiry5Visible');
		    var inquiry6Visible = sessionStorage.getItem('inquiry6Visible');
		    var inquiry7Visible = sessionStorage.getItem('inquiry7Visible');
		    var inquiry8Visible = sessionStorage.getItem('inquiry8Visible');
		
		    if (inquiry1Visible === 'true' && admin_inquiry1) {
		        admin_inquiry1.style.display = 'inline-block'; 
		    } else if (inquiry1Visible === 'false' && admin_inquiry1) {
		        admin_inquiry1.style.display = 'none'; 
		    }
		
		    if (inquiry2Visible === 'true' && admin_inquiry2) {
		        admin_inquiry2.style.display = 'inline-block'; 
		    } else if (inquiry2Visible === 'false' && admin_inquiry2) {
		        admin_inquiry2.style.display = 'none'; 
		    }
		    
		    if (inquiry3Visible === 'true' && admin_inquiry3) {
		        admin_inquiry3.style.display = 'inline-block'; 
		    } else if (inquiry3Visible === 'false' && admin_inquiry3) {
		        admin_inquiry3.style.display = 'none'; 
		    }	
		    
		    if (inquiry4Visible === 'true' && admin_inquiry4) {
		        admin_inquiry4.style.display = 'inline-block'; 
		    } else if (inquiry4Visible === 'false' && admin_inquiry4) {
		        admin_inquiry4.style.display = 'none'; 
		    }
	    
		    if (inquiry5Visible === 'true' && admin_inquiry5) {
		        admin_inquiry5.style.display = 'inline-block'; 
		    } else if (inquiry5Visible === 'false' && admin_inquiry5) {
		        admin_inquiry5.style.display = 'none'; 
		    }
		    
		    if (inquiry6Visible === 'true' && admin_inquiry6) {
		        admin_inquiry6.style.display = 'inline-block'; 
		    } else if (inquiry6Visible === 'false' && admin_inquiry6) {
		        admin_inquiry6.style.display = 'none'; 
		    }
		    
		    if (inquiry7Visible === 'true' && admin_inquiry7) {
		        admin_inquiry7.style.display = 'inline-block'; 
		    } else if (inquiry7Visible === 'false' && admin_inquiry7) {
		        admin_inquiry7.style.display = 'none'; 
		    }
		    
		    if (inquiry8Visible === 'true' && admin_inquiry8) {
		        admin_inquiry8.style.display = 'inline-block'; 
		    } else if (inquiry8Visible === 'false' && admin_inquiry8) {
		        admin_inquiry8.style.display = 'none'; 
		    }	           
		});
	
	 