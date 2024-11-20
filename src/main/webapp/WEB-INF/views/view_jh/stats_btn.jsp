<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<!-- 
	 <style type="text/css">
		.goPopUP_Stats_MainForm {
		    display: flex;
		    justify-content: center; 
		    align-items: center;   
		    height: 100vh;           
		    padding: 20px 50px;		
		    font-size: 20px;	    
		}	
	</style>
	 -->
<title>통계</title>
</head>
<body>
	<!-- 통계 메인화면 팝업으로 열기 -->
	<!-- 
 	<div class="goPopUP_Stats_MainForm"> 	
		<button onclick="window.open('/view_jh/seller_Stats_MainForm', '_blank', 'width=1270, height=1000, left=315, scrollbars=yes')">판매자 통계</button>
		<button onclick="window.open('/view_jh/admin_Stats_MainForm', '_blank', 'width=1270, height=1000, left=315, scrollbars=yes')">관리자 통계</button>
	</div>
	 -->
	

	<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ판매자 menu_Sㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
	    
    <li class="nav__items">
      <img alt="icon" src="../images/main/jh_stats.png" class="nav_items_img">
      <button id="stats" onclick="window.open('/view_jh/seller_Stats_MainForm', '_blank', 'width=1270, height=1000, left=315, scrollbars=yes')">판매자 통계</button>
    </li>

    <style>
	    #stats {
	        background: none;
	        border: none; 
	        color: inherit; 
	        cursor: pointer;
	        margin-left: 10px;
	        font: inherit; 
	    }
	    #stats:hover {
			background: radial-gradient(circle at 94.02% 88.03%, #ff4714, transparent 100%);
			transition: all 0.5s ease;
	    } 
	</style>
	
	
	<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ관리자 menu_Aㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
	
	    
    <li class="nav__items">
      <img alt="icon" src="../images/main/jh_stats.png" class="nav_items_img">
      <button id="stats" onclick="window.open('/view_jh/admin_Stats_MainForm', '_blank', 'width=1270, height=1000, left=315, scrollbars=yes')">관리자 통계</button>
    </li>

    <style>
	    #stats {
	        background: none;
	        border: none; 
	        color: inherit; 
	        cursor: pointer;
	        margin-left: 10px;
	        font: inherit; 
	    }
	    #stats:hover {
			background: radial-gradient(circle at 94.02% 88.03%, #ff4714, transparent 100%);
			transition: all 0.5s ease;
	    } 
	</style>
	
	
	
</body>
</html>