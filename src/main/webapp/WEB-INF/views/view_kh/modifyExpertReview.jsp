<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    

<!DOCTYPE html>
<html>
<head>
<link href="<%=request.getContextPath()%>/css/createExpertReview.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript">	
	$(function() {
		$("#expertReviewContent").keyup(function() {
			var content	= $("#expertReviewContent").val();
			var size	= content.length;
			$(".expertReviewContentSize").val(size);
			
			if(size > 1000) {
				alert("입력 글자 수가 1,000을 넘었습니다");
			}
		});
	});
	
	$(function() {
		var ess_state	= $("#ess_state2").val();
		var ess_mileage	= $("#ess_mileage2").val();
		var ess_regi	= $("#ess_regi2").val();
		var egine_oil	= $("#egine_oil2").val();
		var brake_oil	= $("#brake_oil2").val();
		var coolant		= $("#coolant2").val();
		var tire		= $("#tire2").val();
		var brake_pad	= $("#brake_pad2").val();
		var score = $("#score2").val();
		
		$("#ess_state").val(ess_state).attr("selected", "selected");
		$("#ess_mileage").val(ess_mileage).attr("selected", "selected");
		$("#ess_regi").val(ess_regi).attr("selected", "selected");
		$("#egine_oil").val(egine_oil).attr("selected", "selected");
		$("#brake_oil").val(brake_oil).attr("selected", "selected");
		$("#coolant").val(coolant).attr("selected", "selected");
		$("#tire").val(tire).attr("selected", "selected");
		$("#brake_pad").val(brake_pad).attr("selected", "selected");
		$("#exReviewScore").val(score).attr("selected", "selected");
	});
	
	
	function commitReview() {
		alert("전문가리뷰 수정을 완료합니다.");
		$("#expertReviewInformation").attr("action", "/KH/pay/updateExpertReview").submit();

	}
	
	function previewReview() {
		alert("미리보기 창을 엽니다");
		window.open('about:blank','previewExpertReview','width=700,height=2330,location=no,status=no,scrollbars=no,top=100,left=300');
	    var frm 	= document.expertReviewInformation;
	    frm.action 	= "/KH/pay/previewExpertReview";
	    frm.target 	= "previewExpertReview";
	    frm.submit();
	}
	

</script>


</head>
<body>
	<input type="hidden" id="ess_state2"	value="${experReviewDetail.ess_state }">
	<input type="hidden" id="ess_mileage2" 	value="${experReviewDetail.ess_mileage }">
	<input type="hidden" id="ess_regi2"		value="${experReviewDetail.ess_regi }">
	<input type="hidden" id="egine_oil2"	value="${experReviewDetail.egine_oil }">
	<input type="hidden" id="brake_oil2"	value="${experReviewDetail.brake_oil }">
	<input type="hidden" id="coolant2"		value="${experReviewDetail.coolant }">
	<input type="hidden" id="tire2"			value="${experReviewDetail.tire }">
	<input type="hidden" id="brake_pad2"	value="${experReviewDetail.brake_pad }">
	<input type="hidden" id="score2"	value="${experReviewDetail.score }">

	<div id="expertReviewInput">
		<div id="writerDiv">
			<table>
				<tr>
					<td class="writerDetail">
						${expert.user_id }
					</td>
				</tr>
				
				<tr>
					<td class="writerDetail">
						${expert.user_name }
					</td>
				</tr>			
			</table>		
		</div>
		
		<div id="carBasicInfo">
			<table>
				<tr>
					<td class="InfoCell" colspan="4">
						${carDetail.brand }&nbsp;
						${carDetail.model }
					</td>
				</tr>
				
				<tr>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						${carDetail.car_num }
					</td>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<fmt:formatNumber 	value="${carDetail.mileage }" 	pattern="#,###,###"/> km
					</td>
				</tr>
				
				<tr>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						${carDetail.fuel }
					</td>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						${carDetail.transmission }
					</td>
				</tr>
				
				<tr>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						${carDetail.accident }
					</td>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<fmt:formatNumber 	value="${carDetail.price * 10000}" 	pattern="#,###,###,###"/> 원
					</td>
				</tr>			
				
			</table>		
		</div>
	
	<form action="/KH/pay/insertExpertReview"	id="expertReviewInformation"	name="expertReviewInformation"	method="post">	
		<input type="hidden" name="user_id" 			value="${expert.user_id }">
		<input type="hidden" name="sell_num"			value="${carDetail.sell_num }">
		<input type="hidden" name="expert_review_num" 	value="${experReviewDetail.expert_review_num }">
		
		<div id="carReviewBasic">
			<table>
				<tr>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<select name="ess_state" id="ess_state">
						    <option value="1" selected>이상없음</option>
						    <option value="3">확인필요</option>
						</select>
					</td>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<select name="ess_mileage" id="ess_mileage">
						    <option value="1" selected>평균이하</option>
						    <option value="2">평균</option>
						    <option value="3">평균초과</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<select name="ess_regi" id="ess_regi">
						    <option value="1" selected>이상없음</option>
						    <option value="3">확인필요</option>
						</select>
					</td>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
					</td>
				</tr>

			</table>		
		</div>
		
		<div id="carReviewExpandable">
			<table>
				<tr>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<select name="egine_oil" id="egine_oil">
						    <option value="1" selected>상태양호</option>
						    <option value="3">점검필요</option>
						</select>
					</td>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<select name="brake_oil" id="brake_oil">
						    <option value="1" selected>상태양호</option>
						    <option value="3">점검필요</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<select name="coolant" id="coolant">
						    <option value="1" selected>상태양호</option>
						    <option value="3">점검필요</option>
						</select>
					</td>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<select name="tire" id="tire">
						    <option value="1" selected>상태양호</option>
						    <option value="3">점검필요</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
						<select name="brake_pad"  id="brake_pad">
						    <option value="1" selected>상태양호</option>
						    <option value="3">점검필요</option>
						</select>
					</td>
					<td class="InfoBlank"></td>
					<td class="InfoCell">
					</td>
				</tr>

			</table>		
		</div>
		
		<div id="expertReviewContentDiv">
			<textarea name="content" id="expertReviewContent"	maxlength="1000">${experReviewDetail.content }</textarea>
			<br>
			<input type="text"	class="expertReviewContentSize">
		</div>
		
		<div id="expertReviewScore">
			<select id="exReviewScore"  name="score">
				<option value="1">1</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
				<option value="13">13</option>
				<option value="14">14</option>
				<option value="15">15</option>
				<option value="16">16</option>
				<option value="17">17</option>
				<option value="18">18</option>
				<option value="19">19</option>
				<option value="20">20</option>
				<option value="21">21</option>
				<option value="22">22</option>
				<option value="23">23</option>
				<option value="24">24</option>
				<option value="25">25</option>
				<option value="26">26</option>
				<option value="27">27</option>
				<option value="28">28</option>
				<option value="29">29</option>
				<option value="30">30</option>
				<option value="31">31</option>
				<option value="32">32</option>
				<option value="33">33</option>
				<option value="34">34</option>
				<option value="35">35</option>
				<option value="36">36</option>
				<option value="37">37</option>
				<option value="38">38</option>
				<option value="39">39</option>
				<option value="40">40</option>
				<option value="41">41</option>
				<option value="42">42</option>
				<option value="43">43</option>
				<option value="44">44</option>
				<option value="45">45</option>
				<option value="46">46</option>
				<option value="47">47</option>
				<option value="48">48</option>
				<option value="49">49</option>
				<option value="50" selected>50</option>
				<option value="51">51</option>
				<option value="52">52</option>
				<option value="53">53</option>
				<option value="54">54</option>
				<option value="55">55</option>
				<option value="56">56</option>
				<option value="57">57</option>
				<option value="58">58</option>
				<option value="59">59</option>
				<option value="60">60</option>
				<option value="61">61</option>
				<option value="62">62</option>
				<option value="63">63</option>
				<option value="64">64</option>
				<option value="65">65</option>
				<option value="66">66</option>
				<option value="67">67</option>
				<option value="68">68</option>
				<option value="69">69</option>
				<option value="70">70</option>
				<option value="71">71</option>
				<option value="72">72</option>
				<option value="73">73</option>
				<option value="74">74</option>
				<option value="75">75</option>
				<option value="76">76</option>
				<option value="77">77</option>
				<option value="78">78</option>
				<option value="79">79</option>
				<option value="80">80</option>
				<option value="81">81</option>
				<option value="82">82</option>
				<option value="83">83</option>
				<option value="84">84</option>
				<option value="85">85</option>
				<option value="86">86</option>
				<option value="87">87</option>
				<option value="88">88</option>
				<option value="89">89</option>
				<option value="90">90</option>
				<option value="91">91</option>
				<option value="92">92</option>
				<option value="93">93</option>
				<option value="94">94</option>
				<option value="95">95</option>
				<option value="96">96</option>
				<option value="97">97</option>
				<option value="98">98</option>
				<option value="99">99</option>
				<option value="100">100</option>
			</select>
		</div>
		
		<div id="commitButton">
			<button	id="btnCommit"	onclick="commitReview()">
				수정하기
			</button>
			<br>
			<button	id="btnPreview"	onclick="previewReview()">
				미리보기
			</button>
							
		</div>
	
	</form>
		
	</div>
	
	
	
</body>
</html>