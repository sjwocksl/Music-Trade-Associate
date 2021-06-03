<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<!DOCTYPE html>
<!-- 문서 유형 : 현재 웹 문서가 어떤 HTML 버전에 맞게 작성되었는지를 알려준다. -->

<!--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
     DTD 선언문이 HTML 페이지의 가장 첫 라인에 명시되어야 웹 브라우저가 HTML 버전을 인식.
     HTML태그나 CSS를 해당 버전에 맞도록 처리하므로 웹 표준 준수를 위하여 반드시 명시되어야 한다.-->
<html lang="ko">
<head>

<!-- html5 : 파일의 인코딩 방식 지정 - 한국어 처리를 위한 euc-kr과 다국어 처리를 위한 utf-8로 설정.-->
<meta charset="utf-8" />
<!-- html4 : 파일의 인코딩 방식 지정 -->
<!--<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />-->

<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<!-- 브라우저의 호환성 보기 모드를 막고, 해당 브라우저에서 지원하는 가장 최신 버전의 방식으로 HTML 보여주도록 설정.-->

<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<!--viewport : 화면에 보이는 영역을 제어하는 기술. width는 device-width로 설정(브라우저 너비를 장치 너비에 맞추어 표시). initial-scale는 초기비율(보이는 영역과 웹 페이지를 맞춤). user-scalable는 사용자가 화면축소를 하지 못하도록 설정.-->

<!-- 모바일 웹 페이지 설정 -->
<link rel="shortcut icon" href="/resources/images/icon.png" />
<link rel="apple-touch-icon" href="/resources/images/icon.png" />
<!-- 모바일 웹 페이지 설정 끝 -->
<link rel="stylesheet"
	href="/resources/include/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/include/dist/css/bootstrap-theme.css">

<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>

<script src="/resources/include/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript" src="/resources/include/js/cart.js">
	</script>
<script type="text/javascript">
var total = 0;
	$(function(){
		$("#ListBtn").click(function(){
			location.href ="/mboard/boardList";
		});
		
		
		
		//checkOut buttion controll 
		$("#checkOutBtn").click(function(){
			if(confirm("결제페이지로 이동하시겠습니까?")){
				  location.href="/order/orderList";
			}
			 
		
			   });
			   
			 
			    
		

		//장바구니 리스트 전체 선택  
		$("#allCheck").click(function(){
			 var chk = $("#allCheck").prop("checked");
			 if(chk) {
			  $(".chkbox").prop("checked", true);
			  itemSum();
			 } else {
			  $(".chkbox").prop("checked", false);
			  itemSum();
			 }
			});
		 
		 //개별 선택 시 전체 선택 해제
		 $(".chkbox").click(function(){
			  $("#allCheck").prop("checked", false);
			  itemSum();
			 });
		 
		 
		 var total =0 ;

		 //장바구니 가격 구하기. 
		 $(".check").click(function(){
			 if($("input[class='chkbox']").is(":checked")){
		            itemSum();

		        }else {
		        	itemSum();
		        }
		 });
		 
		 
		 
		//선택된 항목 장바구니 삭제 
		 $("#selectDelete_btn").click(function(){
			  var confirm_val = confirm("정말 삭제하시겠습니까?");
			  
			  if(confirm_val) {
			   var checkArr = new Array();
			   
			   $("input[class='check']:checked").each(function(){
			    checkArr.push($(this).attr("data-cartNum"));
			   });
			    
			   $.ajax({
			    url : "/order/deleteCart",
			    type : "get",
			    data : { check : checkArr },
			    success : function(result){
			    	if(result ==1){
			    			$("#f_data").attr({
			    				"method" : "get",
			    				"action" : "/order/cartList"
			    			});
			    			$("#f_data").submit();
			    		
			    	}else{
			    		alert("장바구니 삭제 실패. 관리자에게 문의하세요.");
			    	}
			     
			    }
			   });
			  } 
			 });
		
		
		
	});// 최상위 종결 . 
	
	
	function itemSum(){
	    var str = "";
	    var sum = 0;
	    var count = $(".chkbox").length;
	    for(var i=0; i < count; i++ ){
	        if( $(".chkbox")[i].checked == true ){
	         sum += parseInt($(".chkbox")[i].value);
	        }
	    }
	    $("#total").val(sum);
	     
	 }

</script>

<!-- 모바일 웹 페이지 설정 끝 -->
<style type="text/css">
	img{
		height: 70px;
		width : 70px;
	
	}

</style>
</head>
<body>
	<h3>Cart List</h3>
	<form name= "f_data" id = "f_data">
				<input type ="hidden" name = "m_no" value ="${cart.m_no}"/>
			<input type = "hidden" name = "user_id" id = "user_id" value = "${userInfo.user_id}"/>

			</form>	
		<div id="boardsList">
			<table summary="장바구니 리스트" class="table">

				<colgroup>
					<col width="10%" />
					<col width="10%" />
					<col width="15%" />
					<col width="13%" />
					<col width="12%" />
				</colgroup>
				<thead>
					<tr>
						<th>선택</th>
						<th>앨범커버</th>						
						<th>제목</th>
						<th>가격</th>
					
					</tr>
				</thead>
				<tbody id = "list" class ="table table-hover">
					<!-- 데이터 출력 -->
					
					
					<c:choose>
						<c:when test ="${not empty cartList }"> <!-- if 문으로 not empty가 true 일때, list가 있을 때 실행되는 구문. -->
						<tr class = "text-center">
						<td class = "text-left"><input type ="checkbox" name = "allCheck" id = "allCheck" class =""/><label for ="allCheck" class ="">&nbsp;&nbsp;&nbsp;전체선택</label></td></tr>
						<c:set var="sum" value="0" />
							<c:forEach var ="cart" items="${cartList}" varStatus="status"> <!-- items 의 항목을 모두 반복 -->
								<tr class ="text-center" > 
									<td class ="text-left"><input type="checkbox" class ="chkbox" name ="check" data-cartNum ="${cart.cart_id}" data-mPrice= "${cart.m_price}" value ="${cart.m_price}"/></td>
									<td class = "text-left"><img src="/uploadStorage/coverImg/${cart.m_coverimage}"/></td>
									<td class = "goDetail text-left">${cart.m_title}</td>
									<td class ="text-left">${cart.m_price}</td>
									<td class ="name">${cart.m_name}</td>													
								</tr>
								
								<c:set var="sum" value="0" />
							</c:forEach>
							<div class="text-right">
								 <div class="sum">
									  총 합계 : <input type = "number" id ="total" readonly="readonly" value ="0"/>원
									 </div>
								</div>
						</c:when>
						<c:otherwise> <!-- if문의 else -->
							<tr>
								<td colspan="4" class ="tac text-center">장바구니에 담긴 상품이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class ="text-center">
				<button id = "checkOutBtn" class ="btn btn-success" data-cartNum ="${cart.cart_id}">Check Out</button>
				<button id = "ListBtn" class ="btn btn-success">Back to List</button>	
				<button id = "selectDelete_btn" class ="btn btn-success" data-cartNum ="${cart.cart_id}">Delete Selected items</button>
			</div>		
		</div>
</body>
</html>