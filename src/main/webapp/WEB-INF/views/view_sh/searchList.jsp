<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


		<%@ include file="../header_white.jsp" %>
		<%@ include file="../kakao.jsp" %>
		
		    


<title>Insert title here</title>
</head>

	<style>
	
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
		}
		
	body {
		font-family: 'Pretendard-Regular';
	    font-weight: 400;
	    font-style: normal;
	}

    .detailSearch {
	    display: flex;
	    flex-direction: row;
	    align-items: center; /* 수평 중앙 정렬 */
	    justify-content: center; /* 수직 중앙 정렬 */
	    width: 100%;
	    background-color: #fdfdfd;
	    padding-bottom: 100px;
    }

    .dsBox{ 
        display: flex;
    }

    .ds1 {
        background-color: #ededed;
        height: 75px;
        width: 250px;
        justify-content: center;
        padding: 10px 20px 0px 20px;
    }

    .ds1 input {
        width: 230px;
        height: 35px;
        border: none;
        background-color: #ededed;
    }

    .ds2 {
        background-color: #ededed;
        height: 75px;
        width: 250px;
        /*display: table;*/
        margin-left: 5px;
        padding: 10px 20px 0px 20px;
    }

    .price {
        text-align: center;
        margin-left: 5px;
    }

    #minPrice {
        width: 95px;
        height: 35px;
        border: none;
        background-color: #ededed;
        text-align: center;
    }

    #maxPrice {
        width: 95px;
        height: 35px;
        border: none;
        background-color: #ededed;
        /* text-align: center; */
    }

    .ds3 {
        background-color: #ededed;
        height: 75px;
        width: 600px;
        margin-left: 5px;
        padding: 10px 20px 0px 20px;
    }

    .ds3 input {
        width: 580px;
        height: 35px;
        border: none;
        background-color: #ededed;
    }

    .searchButton {
        background-color: #ededed;
        width: 250px;
        background-color: #ff4714;
        color: white;
        font-weight: bold;
        font-size: 2em;
        text-align: center;
        vertical-align: middle;
        line-height: 75px;
        margin-left: 25px;
        border: none;
    }
     

    
    /* .searchButton {
	    height: 75px;
	    width: 250px;
	    color: white;
	    background-color: #ff4714;
	    font-weight: bold;
	    font-size: 2em;
	    text-align: center;
	    line-height: 75px; 텍스트를 수직 중앙에 배치
	    margin-left: 25px;
	}  */

    .searchButton button {
        background-color: transparent;
        border: none;
    }
    
    #mainDtext {
    	font-weight: bold;
    	font-size: 20px;
    	color: #070707;
    	margin-bottom: 20px;
    	margin-left: 5px;
    	margin-top: 10px;
    }
    
    #dtext {
    	font-weight: bold;
    	font-size: 15px;
    	color: #313131;
    	margin-bottom: 10px;
    	margin-left: 5px;
    	transition: transform 0.2s; /* 박스 확대 효과에 대한 부드러운 전환 */
    }
    
    input[type="radio"]:hover + label {
    	color: #ff4714;
    	transform: scale(1.05); /* 박스를 1.05배 확대 */
    }
    
    input[type='radio']:checked:after {
        width: 15px;
        height: 15px;
        border-radius: 15px;
        top: -2px;
        left: -1px;
        position: relative;
        background-color: #ff4714;
        content: '';
        display: inline-block;
        visibility: visible;
        border: 2px solid white;
    }
    
    input[type='radio']:checked + label {
    	color: #ff4714;
    }
    
    input[type='radio']:after {
        width: 15px;
        height: 15px;
        border-radius: 15px;
        top: -2px;
        left: -1px;
        position: relative;
        background-color: #ededed;
        content: '';
        display: inline-block;
        visibility: visible;
        border: 2px solid white;
    }
    
    input[type='radio']:checked:before {
	  background: #ff4714;
	}

    #dsText {
        margin-top: 5px;
        margin-left: 5px;
    }
    
    .dSubmit {
    	width: 70px;
    	height: 30px;
    	background-color: #ff4714;
    	color: white;
    	font-weight: bold;
    	font-size: 20px;
    	text-align: center;
    	float: right;
    	margin-right: 30px;
    	margin-top: 30px;
    	border: none;
    }
    
    .dSubmit button {
    	background-color: transparent;
    	border: none;
    }

      .detail{
          margin-top: 10px;
          padding-top: 10px;
          background-color: #fdfdfd;
          width: 200px;
          height: 1200px;
          position: absolute;
          box-shadow: 0 0 10px 5px rgb(0,0,0,0.06);
      }

      .detail input{
          font-size: 15px;
          margin: 0px;
          margin-left: 25px;
      }
/************************************뭐야 이거 아니네*******************/
      .gray{
          width: 100%;
          height: auto;
          background-color: #fafafa;
          min-height: 1300px;
          padding-bottom: 100px;
          padding-top: 20px;
      }
	
	.listTop {
	    display: flex;
	    flex-wrap: wrap;
	    justify-content: space-between;
	    width: 1320px;
	    background-color: #fdfdfd;
	    height: 90px;
	    
	}
	
	.listBottom {
	    text-align: center;
	    flex-wrap: wrap;
	    justify-content: space-between;
	    background-color: #fdfdfd;
	}

	.page {
		display: flex;
		flex: 1 1;
		width: 1280px;
		justify-content: center;
		align-content: center;
	}
	
	.page a {
		text-align: center;
		font-size: 25px;
		font-weight: bold;
		margin-top: 50px;
		width: 70px;
		height: 50px;
		color: #ff4714;
	}
	
	.listBackGround {
		display: flex;
		margin: auto;
		width: 1320px;
		background-color: #fdfdfd;
	}

	
	.list {
		box-shadow: 0 0 10px 5px rgb(0,0,0,0.06);
	    display: flex;
	    flex-wrap: wrap;
	    align-content: flex-start;
	    /* justify-content: center; 이거 하면 매물이 3의 배수로 안 뜨는 경우 가운데로 몰려서 .list의 넓이랑 패딩 수정*/
	    margin: auto;
	    gap: 30px; /* 카드 간의 간격 */
	    width: 1260px;
	    padding: 30px;
	    background-color: #fdfdfd;
	    min-height: 400px;
	}
	
	.list h1{
		margin-top: 100px;
		margin-bottom: 100px;AC
	}
	/*******************************************************/
	#result0{
		text-align: center;
		width: 100%;
		height: 1000px;
		margin-top: 100px;
		background-color: #fdfdfd;
		
	}
	
	#detailB{
		margin-left: 20px;
	}
	
	.card {
	    /* flex: 1 1 calc(30% - 50px);  가로로 3개 배치 
	    margin-right: 40px;
	    box-sizing: border-box;
	    background-color: white;
	    max-width: 400px;  원하는 최대 너비 값 >> 결과가 1이 나오던 3의 배수가 나오던 상관없이 박스의 크기를 맞추기 위함 */
	    
	    /* display: grid; */
		grid-template-columns: repeat(3, 400px); /* 3개의 열을 동일한 크기로 배치 */
		gap: 20px;
		margin: 20px 0 40px;
		max-width: 1280px;
		min-width:400px;
	}
	
	.card-title {
		font-size: 32px;
		font-weight: bold;
		color: #323232;
		margin: 20px 20px 10px 20px;
	}
	      
      #card-text{
      	font-size: 36px;
		font-weight: bold;
		color: #ff4714;
		margin: 10px 20px 20px 20px;
		word-wrap: break-word; /* 부모 요소를 넘는 경우 줄바꿈 */
	    word-break: break-all; /* 단어가 길 경우 단어 중간에서 줄바꿈 */
	    white-space: normal; /* 공백이나 줄바꿈을 기본적으로 처리 */
	    overflow-wrap: break-word; /* 최신 표준 줄바꿈 처리 */
	    max-width: 360px;
	    flex-shrink: 0; /* 부모 요소에서 줄어들지 않도록 강제 */
      }
      
      #imgSize {
      	max-width: 100%;
	    max-height: 100%;
	    width: auto;
	    height: auto;
	    object-fit: contain;
	    min-width: 300px; /*박스 갯수가 몇 개가 나오던 이미지의 최소 사이즈를 정하기 위함*/
      }
      
     .imgBlock {
      	width: 400px;
      	height: 100%;
      	min-height: 300px;
      	max-height: 300px;
      }
      
      #card-img-top {
      	width: 100%;
		max-width: 400px;
		height: auto;
      }
      
      
	
	.searchButton button {
	    background-color: transparent;
	    border: none;
	    color: white;
	    font-size: inherit;
	    font-weight: inherit;
	    cursor: pointer;
	}
	
	.listTop h1{
		color: #313131;
		margin-left: 40px;
		margin-top: 20px;
	}
	
	.li a {
		text-decoration: none !important;
		transition: transform 0.2s; /* 박스 확대 효과에 대한 부드러운 전환 */
		width: 400px; 
		align-items: flex-start;
	}
	
	a:hover { 
		text-decoration:none !important ;
		transform: scale(1.05); /* 박스를 1.05배 확대 */
	}
	.carList{
		background-color: #fafafa;
		display:flex;
		flex-direction: column;
	    padding:0px;
	    box-sizing: border-box;
	    width: 100%;
	    min-width:400px;
	    max-width:400px;
		box-shadow: 0 0 10px 5px rgb(0,0,0,0.04);
	}
	
	.card-text_2 {
		font-size: 14px;
		color: #313131;
		margin: 20px 20px 20px 20px;
	}
	
	#plzA {
		width: 400px;
	}
	.div_kakao {
	    position: relative;
	    z-index: 10;
	    bottom: -800px;
	}
	
	.div_footer{
	    z-index: 1;
	}
        

    </style>
    
    
    
    
    <script type="text/javascript">

    	function chk(){
			if(!frm.model_name.value){
				alert("모델명을 입력해주세요");
				frm.model_name.focus();
				return false;
			}
			if(!frm.min_price.value){
				alert("최소 예산을 입력해주세요");
				frm.min_price.focus();
				return false;
			}
		    if(isNaN(frm.min_price.value)){
		        alert("최소 예산은 숫자로 입력해주세요");
		        frm.min_price.focus();
		        return false;
		    }
			if(!frm.max_price.value){
				alert("최대 예산을 입력해주세요");
				frm.max_price.focus();
				return false;
			}
			if(isNaN(frm.max_price.value)){
		        alert("최대 예산은 숫자로 입력해주세요");
		        frm.max_price.focus();
		        return false;
		        }
			if(!frm.searchkeyword.value){
				alert("키워드를 입력해주세요");
				frm.searchkeyword.focus();
				return false;
			}
			return true;
		}
    	
    	function chkDetailB() {
    		 // 브랜드 확인
    	    if (!document.querySelector('input[name="brand"]:checked')) {
    	        alert("브랜드를 선택해주세요");
    	        return false;
    	    }
    	    // 연식 확인
    	    if (!document.querySelector('input[name="manu_date"]:checked')) {
    	        alert("연식을 선택해주세요");
    	        return false;
    	    }
    	    // 연료 확인
    	    if (!document.querySelector('input[name="fuel"]:checked')) {
    	        alert("연료를 선택해주세요");
    	        return false;
    	    }
    	    return true;
    	}
    	
    	
	</script>


		
<body>
	<div class="detailSearch">
        <form class="detailForm" onsubmit="return chk()" name="frm" action="/view_sh/detailSearch">
            <div class="dsBox">
                <div class="ds1">
                    <div id="dsText">모델명</div>
                    <input type="text" id="sb1" placeholder="검색할 모델명 입력" name="model_name">
                </div>
                <div class="ds2">
                    <div id="dsText">예산범위</div>
                    <div class="price">
                        <input type="text" id="minPrice" placeholder="최소 예산" name="min_price">
                        &nbsp;~ &nbsp;
                        <input type="text" id="maxPrice" placeholder="최대 예산" name="max_price">
                    </div>
                </div>
                <div class="ds3">
                    <div id="dsText">검색</div>
                    <input type="text" placeholder="검색할 키워드 입력" name="searchkeyword">
                </div>
                <button class="searchButton" type="submit">검색하기</button>
            </div>
        </form>
    </div>

        <div class="gray">
            <form class="detail" action="/detailB" name="dFrm" onsubmit="return chkDetailB()">
                <div id="detailB">
                	<div id="mainDtext">세부옵션</div>
                	<div id="dtext">브랜드</div>
	                <input type="radio" value="1100" name="brand" onclick="chkBrand(1100)" class="tSelect"><label for="tSelect">&nbsp; 현대&nbsp;</label><p></p>
	                <input type="radio" value="1200" name="brand" onclick="chkBrand(1200)" class="tSelect"><label for="tSelect">&nbsp; 기아&nbsp;</label><p></p>
	                <input type="radio" value="1300" name="brand" onclick="chkBrand(1300)" class="tSelect"><label for="tSelect">&nbsp; KGM&nbsp;</label><p></p>
	                <input type="radio" value="1400" name="brand" onclick="chkBrand(1400)" class="tSelect"><label for="tSelect">&nbsp; GM&nbsp;</label><p></p>
	                <input type="radio" value="1500" name="brand" onclick="chkBrand(1500)" class="tSelect"><label for="tSelect">&nbsp; SM&nbsp;</label><p></p>
	                <input type="radio" value="1600" name="brand" onclick="chkBrand(1600)" class="tSelect"><label for="tSelect">&nbsp; 국내기타&nbsp;</label><p></p>
	                <input type="radio" value="2100" name="brand" onclick="chkBrand(2100)" class="tSelect"><label for="tSelect">&nbsp; BENZ&nbsp;</label><p></p>
	                <input type="radio" value="2200" name="brand" onclick="chkBrand(2200)" class="tSelect"><label for="tSelect">&nbsp; BMW&nbsp;</label><p></p>
	                <input type="radio" value="2300" name="brand" onclick="chkBrand(2300)" class="tSelect"><label for="tSelect">&nbsp; AUDI&nbsp;</label><p></p>
	                <input type="radio" value="2400" name="brand" onclick="chkBrand(2400)" class="tSelect"><label for="tSelect">&nbsp; MINI&nbsp;</label><p></p>
	                <input type="radio" value="2500" name="brand" onclick="chkBrand(2500)" class="tSelect"><label for="tSelect">&nbsp; VW&nbsp;</label><p></p>
	                <input type="radio" value="2600" name="brand" onclick="chkBrand(2600)" class="tSelect"><label for="tSelect">&nbsp; USA&nbsp;</label><p></p>
	                <input type="radio" value="2700" name="brand" onclick="chkBrand(2700)" class="tSelect"><label for="tSelect">&nbsp; JPN&nbsp;</label><p></p>
	                <input type="radio" value="2800" name="brand" onclick="chkBrand(2800)" class="tSelect"><label for="tSelect">&nbsp; 해외기타&nbsp;</label><p></p>
	                <hr width = "150px" color="#ededed" align="left" size=2px/>
	
	                <div id="dtext">연식</div>
	                <input type="radio" value="70~90" name="manu_date" class="tSelect"><label for="tSelect">&nbsp; ~1990년&nbsp;</label><p></p>
	                <input type="radio" value="90~99" name="manu_date" class="tSelect"><label for="tSelect">&nbsp; 1990년~1999년&nbsp;</label><p></p>
	                <input type="radio" value="00~09" name="manu_date" class="tSelect"><label for="tSelect">&nbsp; 2000~2009년&nbsp;</label><p></p>
	                <input type="radio" value="09~19" name="manu_date" class="tSelect"><label for="tSelect">&nbsp; 2010~2019년&nbsp;</label><p></p>
	                <input type="radio" value="19~99" name="manu_date" class="tSelect"><label for="tSelect">&nbsp; 2020년~&nbsp;</label><p></p>
	                <hr width = "150px" color="#ededed" align="left" size=2px/>
	
	                <div id="dtext">연료</div>
	                <input type="radio" value="가솔린" 	name="fuel" class="tSelect"><label for="tSelect">&nbsp; 가솔린&nbsp;</label><p></p>
	                <input type="radio" value="디젤" 		name="fuel" class="tSelect"><label for="tSelect">&nbsp; 디젤&nbsp;</label><p></p>
	                <input type="radio" value="하이브리드" name="fuel" class="tSelect"><label for="tSelect">&nbsp; 하이브리드&nbsp;</label><p></p>
	                <input type="radio" value="전기" 		name="fuel" class="tSelect"><label for="tSelect">&nbsp; 전기&nbsp;</label><p></p>
	                <input type="radio" value="lpg" 	name="fuel" class="tSelect"><label for="tSelect">&nbsp; LPG&nbsp;</label><p></p>
                </div>
                <button class="dSubmit" type="submit" >검색</button>
            </form>
            
            
            
           
            
            <!-- 검색 결과 리스트로 출력 -->
            <!-- <div class="listBackGround"> -->
            
            <div class="list">
            
             <div class="listTop">
            	<c:if test="${total > 0 }">
            			<h1>전체 매물 수 : ${total}</h1><br>
            		<!-- <a href="/getCarNum">차번호 가져오기</a> -->
            	</c:if>
            </div>
            
            	<c:if test="${total > 0 }">
					<c:forEach var="car" items="${valueList}">
						<a href="/carInfo?sellNum=${car.sell_num }&id=${car.user_id}" id="plzA">
							<div class="card">
								<div class="carList">
								    <div class="imgBlock">  
								    	<c:choose>
										    <c:when test="${empty car.img_url}">
										        <img src="<%=request.getContextPath()%>/images/sellMyCar/이미지가 없어용.png" class="card-img-top" alt="이미지선택해주세요" id="imgSize">
										    </c:when>
										    <c:otherwise>
										        <img src="..${car.img_url}" class="card-img-top" alt="DB에는 저장되어있는데 이미지가 없는 경우" id="imgSize">
										    </c:otherwise>
										</c:choose>  
									</div>  
									<div class="card-body">
						                <h4 class="card-title">${car.model}</h4>
						                <!-- <hr width="150px" color="#ededed" align="left" size="2px"/> -->
						                <h2 id="card-text">${car.price }만원</h2>
						                <div class="infor">
						                	<div class="card-text_2">${car.munu_date_cos }&emsp;&emsp;${car.mileage }km&emsp;&emsp;${car.fuel }</div>
						                </div>
						            </div>
					            </div>
							</div>
						</a>
					</c:forEach>
				</c:if>
				<!-- 검색결과 값이 없는 경우 -->			
				<c:if test="${total == 0 }">
					<div id="result0">
						<h1>
							검색결과 값이 없습니다
						</h1>
					</div>
					
				</c:if>
				
				<%-- 페이징 --%>
				<%-- 디테일 서치 >> test="${not empty model_name} --%>
				<%-- 키워드 서치 test="${not empty keyword}" --%>
				<!-- otherwise >> 국내, 해외, 친환경 -->
				<div class="listBottom">
            		<c:if test="${total > 0 }">
            			<div class="page">
							<c:choose>
							    <c:when test="${not empty keyword}">
							        <c:if test="${page.startPage > page.pageBlock}">
							            <c:choose>
							                <c:when test="${not empty model_name}">
							                    <a href="/view_sh/page?url=${url}&currentPage=${page.startPage-page.pageBlock}&total=${total}&keyword=${keyword}&model_name=${model_name}&min_price=${min_price}&max_price=${max_price}">&nbsp; 이전 &nbsp;</a>
							                </c:when>
							
							                <c:when test="${empty model_name}">
							                    <a href="/view_sh/page?url=${url}&currentPage=${page.startPage-page.pageBlock}&total=${total}&keyword=${keyword}">&nbsp; 이전 &nbsp;</a>
							                </c:when>
							
							                <c:when test="${not empty fuel}">
							                    <a href="/view_sh/page?url=${url}&currentPage=${page.startPage-page.pageBlock}&total=${total}&brand=${brand}&manu_date=${manu_date}&fuel=${fuel}">&nbsp; 이전 &nbsp;</a>
							                </c:when>
							            </c:choose>
							        </c:if>
							    </c:when>
							
							    <c:otherwise>
							        <c:if test="${page.startPage > page.pageBlock}">
							            <a href="/view_sh/page?url=${url}&currentPage=${page.startPage-page.pageBlock}&total=${total}">&nbsp; 이전 &nbsp;</a>
							        </c:if>
							    </c:otherwise>
							</c:choose>

							
							<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							    <c:choose>
							        <c:when test="${not empty keyword and not empty model_name}">
							            <a href="/view_sh/page?url=${url}&currentPage=${i}&total=${total}&keyword=${keyword}&model_name=${model_name}&min_price=${min_price}&max_price=${max_price}">&nbsp; ${i} &nbsp;</a>
							        </c:when>
							
							        <c:when test="${not empty keyword}">
							            <a href="/view_sh/page?url=${url}&currentPage=${i}&total=${total}&keyword=${keyword}">&nbsp; ${i} &nbsp;</a>
							        </c:when>
							
							        <c:when test="${not empty fuel}">
							            <a href="/view_sh/page?url=${url}&currentPage=${i}&total=${total}&brand=${brand}&manu_date=${manu_date}&fuel=${fuel}">&nbsp; ${i} &nbsp;</a>
							        </c:when>
							
							        <c:otherwise>
							            <a href="/view_sh/page?url=${url}&currentPage=${i}&total=${total}">&nbsp; ${i} &nbsp;</a>
							        </c:otherwise>
							    </c:choose>
							</c:forEach>


							
							<c:choose>
							    <c:when test="${not empty keyword}">
							        <c:if test="${page.endPage < page.totalPage}">
							            <c:choose>
							                <c:when test="${not empty model_name}">
							                    <a href="/view_sh/page?url=${url}&currentPage=${page.startPage+page.pageBlock}&total=${total}&keyword=${keyword}&model_name=${model_name}&min_price=${min_price}&max_price=${max_price}">&nbsp; 다음 &nbsp;</a>
							                </c:when>
							
							                <c:when test="${empty model_name}">
							                    <a href="/view_sh/page?url=${url}&currentPage=${page.startPage+page.pageBlock}&total=${total}&keyword=${keyword}">&nbsp; 다음 &nbsp;</a>
							                </c:when>
							
							                <c:when test="${not empty fuel}">
							                    <a href="/view_sh/page?url=${url}&currentPage=${page.startPage+page.pageBlock}&total=${total}&brand=${brand}&manu_date=${manu_date}&fuel=${fuel}">&nbsp; 다음 &nbsp;</a>
							                </c:when>
							            </c:choose>
							        </c:if>
							    </c:when>
							
							    <c:otherwise>
							        <c:if test="${page.endPage < page.totalPage}">
							            <a href="/view_sh/page?url=${url}&currentPage=${page.startPage+page.pageBlock}&total=${total}">&nbsp; 다음 &nbsp;</a>
							        </c:if>
							    </c:otherwise>
							</c:choose>

							
						</div>
            		</c:if>
            	</div>
				
			</div>
			<!-- </div>  -->
			 
        </div>
        
        <footer>
				<%@ include file="../footer.jsp" %>
			</footer>

        
</body>
	
</html>