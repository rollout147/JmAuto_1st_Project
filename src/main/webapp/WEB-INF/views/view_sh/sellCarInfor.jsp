<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

	<%@ include file="../header_white.jsp" %>

 <style>
 
 	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
 	
      body {
        background-color: #fafafa;
        font-family: 'Pretendard-Regular';
    	font-weight: 400;
    	font-style: normal;
      }

      form {
          display: grid;
          grid-template-columns: 1fr;
          grid-column-gap: 20px;
          grid-row-gap: 20px;
          width: 1020px;
          margin: 0 auto;
          background-color: #fff;
          padding: 150px;
          box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
          text-align: left;
          margin-bottom: 50px;
      }
      
     #h1Infor {
		margin-top: 50px;
		text-align: center;
		font-weight: bold;
	}
      
      .circle {
			margin-top: 50px;
			text-align: center;
		}

      .requtxt {
		    display: flex; /* 가로 정렬을 위해 플렉스 적용 */
		    align-items: center; /* 세로 중앙 정렬 */
		}

      #orange {
          color: #ff4714;
          font-weight: bold;
          display: inline;
          
      }

      #black {
          color: #070707;
          font-weight: bold;
          display: inline;
          margin-left: 50px;
      }
      
      #black2 {
          color: #070707;
          font-weight: bold;
          display: inline;
      }
      
      .inline {
          display: flex; /* 가로로 배치 */
          align-items: center; /* 세로 중앙 정렬 */
      }

      .divGroup {
          display: flex; /* 폼 그룹 내의 항목들을 플렉스 박스로 배치합니다. */
          align-items: center; /* 폼 그룹 내 항목들을 수직 중앙에 정렬합니다. */
          flex-wrap: wrap;
      }
      
      #check {
        position: relative;
	    flex-basis: 100%; /* 이 요소만 한 줄을 차지하게 함 */
	    margin-top: 0px ;
	    margin-bottom: 0px ;
	    margin-left: 25%;
	    color: #ff4714;
	    font-weight: bold;
      }

      .infor {
      	font-size: 20px;
      	font-weight: bold;
        /*margin-right: 20px;*/
        margin-left: 50px;
        margin-top: 15px;
      }

      .infor2 {
         margin-left: 10px;
         margin-right: 10px;
         font-weight: bold;
      }

      .width-2 {
         width: 22%;
         border: #e2e8ee 1px solid;
         height: 25px;
      }
      
      .yymm {
      	text-align: right;
      	height: 25px;
      }

      .inlineText {
          width: 25%;
      }
      
      .inlineText2 {
          width: 18%;
      }

	  #car_num {
          width:50%;
          height: 25px;
      }

      .oneLine {
          width: 62%;
          height: 25px;
      }

      .kmoneLine {
          width: 35%;
          height: 25px;
      }

      .note {
          margin-left: 200px;
      }  
      
      .img {
      	display: flex; /* 폼 그룹 내의 항목들을 플렉스 박스로 배치합니다. */
          align-items: center; /* 폼 그룹 내 항목들을 수직 중앙에 정렬합니다. */
          margin: 0 auto;
      }
      
      .img input{
      	display: none;
      }
      
      /* 가로세로 비율 맞추기 위해 하나만 설정함 */
      #mainImg {
      	width: 300px;
      }
      
      /* 가로세로 비율 맞추기 위해 하나만 설정함 */
      #Imgs1, #Imgs2, #Imgs3, #Imgs4 {
      	width: 150px;
      	margin-right: 50px;
      }
      
      #carNumButton {
      	width: 130px;
      	height: 30px;
      	color: white;
      	background-color: #ff4714;
      	display: flex;
	    justify-content: center; /* 가로 중앙 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
      }
      
      .carNumButton {
      	background-color: transparent;
      	border: hidden;
      	display: flex; 
      	align-items: center;
      }
      
      
      .content {
		display: flex;
		flex-direction: column; /* 세로 방향으로 배치 */
		align-items: center; /* 수평 중앙 정렬 */
		justify-content: center; /* 수직 중앙 정렬 */
        margin-bottom: 250px;
		}

	.join_step {
		display: flex;
		position: absolute;
		/* 플렉스 박스 레이아웃 사용 */
		top: 200px;
		justify-content: center;
		/* 가로 가운데 정렬 */
		list-style: none;
		/* 리스트 스타일 제거 */
		padding: 0;
		/* 기본 패딩 제거 */
		margin-bottom: 30px;
	}

	.join_step li {
		margin: 0 10px;
		/* 항목 간의 간격 설정 */
		position: relative;
		/* 텍스트 위치를 조정하기 위해 relative 유지 */
	}

	.join_step li img {
		width: 150px;
		/* 리스트 항목 내 이미지의 크기를 설정 */
	}

	.join_step li span {
		position: absolute;
		/* 텍스트를 절대 위치로 설정 */
		bottom: 0;
		left: 50%;
		/* 텍스트를 중앙 하단에 위치 */
		color: #666;
		/* 텍스트 색상 설정 */
		line-height: 1.462em;
		/* 텍스트 줄 간격 설정 */
		white-space: nowrap;
		/* 텍스트가 줄바꿈되지 않도록 설정 */
		transform: translate(-50%, 0);
		/* 텍스트를 중앙 정렬 */
	}

	#imgbutt1, #imgbutt2, #imgbutt3 {
		height: 26px;
		width: 480px;
	}
	
	#oderRow5 #upload-name {
	    display: inline-block;
	    padding-left: 20px;
	    width: 300px;
	    height: 30px;
	    padding: 0px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    color: #999999;
	}
	
	#oderRow5 label {
	    display: inline-block;
	    padding-top: 5px;
	    text-align:center;
	    color: #fff;
	    vertical-align: middle;
	    background-color: #FF4714;
	    cursor: pointer;
	    width: 150px;
	    height: 25px;
	    margin-left: 10px;
	}
	
	#oderRow5 #insureFile1, #insureFile2, #insureFile3 {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    /*overflow: hidden;*/
	    border: 0;
	}
	
	#redirectButton {
		display: inline-block;
		width: 320px;
		height: 60px;
		border: solid #ff4714 1px;
		background-color: white;
		color: #ff4714;
		font-size: 16px;
		text-align: center;
		margin-right: 7%;
		line-height: 60px; /* height와 동일하게 설정 */
	}
	
	#nextButton{
		display: inline-block;
		width: 320px;
		height: 60px;
		border: solid #ff4714 2px;
		background-color: #ff4714;
		color: white;
		font-size: 16px;
		margin-left: 7%;
		text-align: center;
	}
	
	.divGroupButton {
			display: flex;
			margin-top: 50px;
			margin-bottom: 20px;
			text-align: center;
			align-items: center;
			margin-right: auto;
			margin-left: auto;
			justify-content: center;
		}
		
	input {
		border: #e2e8ee 1px solid;	
	}


    </style>
    
    <script type="text/javascript">
    	/* 이미지 업로드시 이미지 미리보기 구현 */
    	/* 해당 버튼을 누를 때까지 대기함 */
		$(document).ready(function() {
        // 메인 이미지 선택 버튼을 누르면 파일 선택 창 열기
        $("#mainImg").on("click", function(e) {
            e.preventDefault();  // 버튼의 기본 동작을 막음 (submit 방지)
            $("#mainFileInput").click();  // 사용자가 input 버튼을 누르면 파일 선택창 출력
        });

        $("#Imgs1").on("click", function(e) {
            e.preventDefault();
            $("#img1Input").click();
        });

        $("#Imgs2").on("click", function(e) {
            e.preventDefault();
            $("#img2Input").click();
        });

        $("#Imgs3").on("click", function(e) {
            e.preventDefault();
            $("#img3Input").click();
        });

        $("#Imgs4").on("click", function(e) {
            e.preventDefault();
            $("#img4Input").click();
        });
		
        // 사용자가 input 버튼을 클릭해서 안에 내용물을 바꾸는 경우 실행
        // "change" = 각 파일 입력 요소에서 파일이 변경되면 미리보기 처리
        $("#mainFileInput").on("change", function() {
        	/* this = <input type="file">  >> 파일을 선택한 input이 무엇인지 이름을 가르킴, 이미지 아이디 "#mainImg"에 미리보기 전달*/
            fileSelect(this, "#mainImg");
        });
        $("#img1Input").on("change", function() {
            fileSelect(this, "#Imgs1");
        });
        $("#img2Input").on("change", function() {
            fileSelect(this, "#Imgs2");
        });
        $("#img3Input").on("change", function() {
            fileSelect(this, "#Imgs3");
        });
        $("#img4Input").on("change", function() {
            fileSelect(this, "#Imgs4");
        });
    });

    // fileSelect 함수 수정: 선택한 파일을 특정 img 태그로 미리보기
    function fileSelect(input, targetImg) {
    		/* 사용자가 파일을 선택하고 그 파일이 한 개 이상인 경우 (배열로 나타내는 듯..) */
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function(e) {
            	
            	// $(targetImg) = "#mainImg" 같은 전달받은 미리보기를 출력할 이미지의 id 정보 전달
                // 선택한 파일을 이미지 태그의 src 속성에 설정하여 미리보기
                // .attr = HTML 속성(attribute)을 설정 >> src 경로를 설정하기 위함
                // e.target.result = FileReader 객체를 통해 읽은 파일의 데이터 URL
                $(targetImg).attr("src", e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);  // 파일을 읽어서 DataURL 형식으로 변환
        }
    }
    
    function carNumChk() {
       if (!$('#car_num').val()) {
           alert('차량번호를 입력해주세요');
           $('#car_num').focus();
           return  0;
       } else {
           $.ajax({
               type: "POST",
               url: "/carNumChk",
               data: { "car_num": $('#car_num').val() },
               success: function(result) {
                   if (result >= 1) {
                       $('#check').html("이미 등록된 차량번호입니다");
                       $('#car_num_chk').val('2');
                       return  0;
                   } else {
                       $('#check').html("등록 가능한 차량번호입니다");
                       $('#car_num_chk').val('1');
                       return  1;
                   }
                   
               },
               error: function() {
                   alert('서버 오류가 발생했습니다. 나중에 다시 시도해주세요.');
                   $('#car_num_chk').val('0');
                   return  0;
               }
           });
       }
    }
    
    function carTypeFuel(type) {
    	console.log(type);
		var notEco = [
						{name: "연료 선택", value: "0"},
						{name: "가솔린", value: "가솔린"},
						{name: "디젤", value: "디젤"},
						{name: "전기", value: "전기"},
						{name: "하이브리드", value: "하이브리드"},
						{name: "LPG", value: "LPG"}
		];
		
		var  eco = [
					{name: "연료 선택", value: "0"},
					{name: "전기", value: "전기"},
					{name: "하이브리드", value: "하이브리드"},
					{name: "LPG", value: "LPG"}
		];
		
		var  notSel = [
					{name: "차종 먼저 선택", value: "0"}
		];
		
		var target = document.getElementById("fuel");
		
		var value = [];
		
		// type이 숫자인지 문자열인지 확인하여 비교
		// type으로 값을 넘겨놓고 type.value로 또 값을 비교해서 안됐었다...... jsp더 공부해야 할 듯..
	    if (type == "3000" || type == 3000) {
	    	console.log(type);
	        value = eco;
	        /*console.log('3000 >> ',value);*/
	    } 
	    else if (type == "0" || type == 0){
	    	value = notSel;
	    	/*console.log('0 >> ',value);*/
	    }
	    else {
	        value = notEco;
	        /*console.log('!3000 >> ',value);*/
	    }
		
		// 설정한 배열 안의 값을 확인하려고 for문 돌린거..
	    /*value.forEach(function(item) {
	        console.log('이름: ' + item.name + ', 값: ' + item.value);
	    });*/
		
		// 기존 옵션 제거(한 번 싹 밀고 우리가 설정한 배열을 넣어주기 위함)
	    target.options.length = 0;

	    // 새로운 옵션 추가
	    for (var insert in value) {
	    	//option 태그 생성
	        var opt = document.createElement("option");
	      	//우리가 선언한 opt에 value값과 html 입력
	        opt.value = value[insert].value;
	        opt.innerHTML = value[insert].name;
	        //우리가 위에서 선언한 target에다가 세팅한 opt값 전달
	        target.appendChild(opt);
	    }
	}
   

    function chkValue() {
    	/*alert('frm.car_type.value->'+frm.car_type.value);*/
        if (frm.car_type.value == 0) {
            alert('차종을 선택해주세요');
            frm.car_type.focus();
            return false;
        }
        if (frm.brand.value == 0) {
            alert('브랜드를 선택해주세요');
            frm.brand.focus();
            return false;
        }
        if (!frm.model_name.value) {
            alert('모델명을 입력해주세요');
            frm.model_name.focus();
            return false;
        }
        if (!frm.car_num.value) {
            alert('차량번호를 입력해주세요');
            frm.car_num.focus();
            return false;
        }
        
        if (!frm.manu_yy.value) {
            alert('제조년을 입력해주세요');
            frm.manu_yy.focus();
            return false;
        }
        if (isNaN(frm.manu_yy.value)) {
            alert('제조년은 숫자로 입력해주세요');
            frm.manu_yy.focus();
            return false;
        }
        if (frm.manu_mm.value == 0) {
            alert('제조월을 선택해주세요');
            frm.manu_mm.focus();
            return false;
        }
        if (!frm.mileage.value) {
            alert('주행거리를 입력해주세요');
            frm.mileage.focus();
            return false;
        }
        if (!frm.color.value) {
            alert('차량색상을 입력해주세요');
            frm.color.focus();
            return false;
        }
        if (frm.fuel.value == 0) {
            alert('차량연료를 선택해주세요');
            frm.fuel.focus();
            return false;
        }

        if (frm.transmission.value == 0) {
            alert('차량 변속기를 선택해주세요');
            frm.transmission.focus();
            return false;
        }
        if (frm.accident.value == 0) {
            alert('사고유무를 선택해주세요');
            frm.accident.focus();
            return false;
        }
        if (frm.repossession.value == 0) {
            alert('압류유무를 선택해주세요');
            frm.repossession.focus();
            return false;
        }
        if (!frm.price.value) {
            alert('차량 가격을 입력해주세요');
            frm.price.focus();
            return false;
        }
        if (!frm.sell_regi.value) {
            alert('자동차 등록증을 첨부해주세요');
            frm.sell_regi.focus();
            return false;
        }
        if (!frm.sell_certi_tax.value) {
            alert('자동차 완납증명서를 첨부해주세요');
            frm.sell_certi_tax.focus();
            return false;
        }
        if (!frm.sell_shinbun.value) {
            alert('신분증 사본을 첨부해주세요');
            frm.sell_shinbun.focus();
            return false;
        }
        
        if (frm.car_num_chk.value == '0') {
            alert('차량번호 중복 확인 버튼을 눌러주세요.');
            frm.car_num.focus();
            return false;
        }
        
        if (frm.car_num_chk.value == '2') {
            alert('이미 등록되어 있는 차량은 등록할 수 없습니다.');
            frm.car_num.focus();
            return false;
        }
        
        if (!frm.img_url_main.value) {
            alert('등록할 차량 메인 이미지를 등록해주세요');
            frm.img_url_main.focus();
            return false;
        }
        
        if (!frm.img_url_1.value) {
            alert('등록할 차량 전면 이미지를 등록해주세요');
            frm.img_url_1.focus();
            return false;
        }
        
        if (!frm.img_url_2.value) {
            alert('등록할 차량 후면 이미지를 등록해주세요');
            frm.img_url_2.focus();
            return false;
        }
        
        if (!frm.img_url_3.value) {
            alert('등록할 차량 좌측 이미지를 등록해주세요');
            frm.img_url_3.focus();
            return false;
        }
        
        if (!frm.img_url_4.value) {
            alert('등록할 차량 우측 이미지를 등록해주세요');
            frm.img_url_4.focus();
            return false;
        }
      
        return true;
    }
    
    
  //파일 이름 및 확장자 분리
	// 파일 형식 및 용량 제한	
	$(function insertFile() {
    $("#insureFile1").on('change', function() {
        var fileName = $("#insureFile1").val();
        $("#imgbutt1").val(fileName);
        return;
    });
    
    $("#insureFile2").on('change', function() {
        var fileName = $("#insureFile2").val();
        $("#imgbutt2").val(fileName);
        return;
    });
    
    $("#insureFile3").on('change', function() {
        var fileName = $("#insureFile3").val();
        $("#imgbutt3").val(fileName);
        return;
    });
});
    
</script>

</head>
<body>

		<div class="content">
			<h1 id="h1Infor">차량정보 입력</h1>
			<ul class="join_step">
				<li><img src="<%=request.getContextPath()%>/images/sellMyCar/약관동의_후.png"><span>약관동의</span></li>
				<li><img src="<%=request.getContextPath()%>/images/sellMyCar/차량등록_입력.png"><span>차량정보 입력</span></li>
				<li><img src="<%=request.getContextPath()%>/images/sellMyCar/가입완료_전.png"><span>등록완료</span></li>
			</ul>
		</div>


        <form action="/view_sh/sellMyCarInfo" method="post" enctype="multipart/form-data" name="frm" id="myForm" onsubmit="return chkValue()">


            <div class="divGroup">
				<h1 id="black">차량 정보 입력</h1>
				<h3 id="orange">[필수]</h3>
			</div>

            <!-- <div class="grid-2"> -->
    
				<div class="divGroup">
                        <div class="inlineText">
                            <p class="infor">차종</p>
                        </div>
                        <select name="car_type" class="width-2" onchange="carTypeFuel(this.value)">
                        	<option value="0">차종 선택</option>
                            <option value="1000">국내</option>
                            <option value="2000">수입</option>
                            <option value="3000">친환경</option>
                        </select>
                        <div class="inlineText2">
                            <p class="infor">제조사</p>
                        </div>
                        <select name="brand" class="width-2">
                        	<option value="0">제조사 선택</option>
                            <option value="1100">현대</option>
                            <option value="1200">기아</option>
                            <option value="1300">KGM</option>
                            <option value="1400">GM</option>
                            <option value="1500">SM</option>
                            <option value="1600">국내기타</option>
                            <option value="2100">BENZ</option>
                            <option value="2200">BMW</option>
                            <option value="2300">AUDI</option>
                            <option value="2400">MINI</option>
                            <option value="2500">VW</option>
                            <option value="2600">USA</option>
                            <option value="2700">JPN</option>
                            <option value="2800">해외기타</option>
                        </select>
                </div>
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">모델명</p>
                    </div>
                    <input type="text" name="model_name" class="oneLine">
                </div>
    
                <div class="divGroup">
			    <div class="inlineText">
			        <p class="infor">차량번호</p>
			    </div>
				    <input type="text"   name="car_num"     id="car_num">
				    <input type="hidden" name="car_num_chk" id="car_num_chk" value="0">
				    <button type="button" onclick="carNumChk()" class="carNumButton">
				    	<div id="carNumButton">차량번호 확인</div>
				    </button>
			    	<span id="check"></span> <!-- 여기에서 차량번호 확인 결과를 출력 -->
				</div>
				
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">제조일</p>
                    </div>
                    <input name="manu_yy" class="width-2 yymm" maxlength="2" placeholder="제조년도 입력(예시:00,01,02..)">
                    <p class="infor2">년</p>
                    
                    <select name="manu_mm" class="width-2 yymm">
                    	<option value="0">제조월 선택</option>
                        <c:forEach var="i" begin="01" end="12">
                            <option value="${i }"><fmt:formatNumber value="${i}" pattern="00" /></option>
                        </c:forEach>
                    </select>
    
                    <p class="infor2">월</p>
                </div>
    
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">주행거리</p>
                        </div>
                    <input type="number" name=mileage class="kmoneLine">
                    <p class="infor2">km</p>
                </div>
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">색상</p>
                        </div>
                    <input type="text" name="color" class="oneLine">
                </div>
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">연료</p>
                        </div>
                    <select name="fuel" class="width-2" id="fuel">
                    	<option value="0">차종 먼저 선택</option>

                   
                    </select>
                    <div class="inlineText2">
                        <p class="infor">변속기</p>
                        </div>
                        <select name="transmission" class="width-2">
                        	<option value="0">변속기 선택</option>
                            <option value="오토">오토</option>
                            <option value="수동">수동</option>
                        </select>
                </div>
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">사고유무</p>
                        </div>
                        <select name="accident" class="width-2">
                        	<option value="0">사고유무</option>
                            <option value="무사고">무사고</option>
                            <option value="사고">사고</option>
                            <option value="단순수리">단순수리</option>
                        </select>
                        <div class="inlineText2">
                            <p class="infor">압류유무</p>
                            </div>
                        <select name="repossession" class="width-2">
                        	<option value="0">압류유무</option>
                            <option value="무">무</option>
                            <option value="유">유</option>
                        </select>
                </div>
    
                <div class="note">
                    <h4 id="orange">첨부서류</h4><p>
                    <p id="black2">자동차 등록증 / 자동차세 완납증명서 / 신분증(사본)
                    <p>
                    첨부파일이 문제가 있을 시 판매자 본인이 부당한 대우를 받을 수 있습니다.</p>
                </div>
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">차량가격</p>
                        </div>
                    <input type="number" name="price" class="oneLine">
                    <p class="infor2">만원</p>
                </div>
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">자동차 등록증</p>
                    </div>
                    <div id="oderRow5">	
						<div>					
							<input	id="imgbutt1" 
									placeholder="첨부파일" 
									readonly="readonly"/>
							<label 	for="insureFile1">파일찾기</label> 
	    					<input 	type="file" 
	    							id="insureFile1"
	    							name="sell_regi"
	    							onchange="insertFile()"
	    							/>
	    					<br>
						</div>
					</div>
                </div>
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">자동차 완납증명서</p>
                        </div>
                    <div id="oderRow5">	
						<div>					
							<input	id="imgbutt2" 
									placeholder="첨부파일" 
									readonly="readonly"/>
							<label 	for="insureFile2">파일찾기</label> 
	    					<input 	type="file" 
	    							id="insureFile2"
	    							name="sell_certi_tax"
	    							onchange="insertFile()"
	    							/>
	    					<br>
						</div>
					</div>
                </div>
    
    
                <div class="divGroup">
                    <div class="inlineText">
                        <p class="infor">신분증 사본</p>
                    </div>
                    <div id="oderRow5">	
						<div>					
							<input	id="imgbutt3" 
									placeholder="첨부파일" 
									readonly="readonly"/>
							<label 	for="insureFile3">파일찾기</label> 
	    					<input 	type="file" 
	    							id="insureFile3"
	    							name="sell_shinbun"
	    							onchange="insertFile()"
	    							/>
	    					<br>
						</div>
					</div>
                </div>
                
                
                
                <div class="img">
			       <!-- 파일 선택 창과 연결될 숨겨진 input -->
			       <input type="file" id="mainFileInput" accept=".jpg, .jpeg, .png" name="img_url_main">
			           	<img id="mainImg" alt="" src="images/sellMyCar/이미지선택해주세요.png">
				</div>   
				
				<div class="img">
					<input type="file" id="img1Input" accept=".jpg, .jpeg, .png" name="img_url_1">
						<img id="Imgs1" alt="" src="images/sellMyCar/이미지선택해주세요.png">
						
					<input type="file" id="img2Input" accept=".jpg, .jpeg, .png" name="img_url_2">
						<img id="Imgs2" alt="" src="images/sellMyCar/이미지선택해주세요.png">
						
					<input type="file" id="img3Input" accept=".jpg, .jpeg, .png" name="img_url_3">
						<img id="Imgs3" alt="" src="images/sellMyCar/이미지선택해주세요.png">
						
					<input type="file" id="img4Input" accept=".jpg, .jpeg, .png" name="img_url_4">
						<img id="Imgs4" alt="" src="images/sellMyCar/이미지선택해주세요.png">
				</div>
				
				
				
    		<div class="divGroupButton">
	    		<a href="/view_sh/sellMyCar">
		    		<div id="redirectButton">
		    			이전
		    		</div>
		    	</a>
	    		<button type="submit" id="nextButton">
	    			다음
	    		</button>
    		</div>
    		
            <!-- </div> -->
    
        </form>
    
</body>
<%@ include file="../footer.jsp" %>
</html>