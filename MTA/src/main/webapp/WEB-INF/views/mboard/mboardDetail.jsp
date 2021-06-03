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
<link rel="shortcut icon" href="/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/resources/image/icon.png" />
<!-- 모바일 웹 페이지 설정 끝 -->
<link rel="stylesheet"
	href="/resources/include/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/include/dist/css/bootstrap-theme.css">
	<link href='https://fonts.googleapis.com/css?family=Roboto:100' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href ="/resources/include/css/mboard/musicPlayer.css">
	<link rel="stylesheet" href ="/resources/include/css/mboard/musicDetail.css">
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>

<script src="/resources/include/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>



<!-- 모바일 웹 페이지 설정 끝 -->

<!--[if lt IE 9]>
		<script src="../js/html5shiv.js"></script>
		<![endif]-->
<title></title>
<style type="text/css">
input[type="range"] {
	cursor :default;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  &:focus {
    outline: none;
  }
  &::-webkit-slider-thumb {
    -webkit-appearance: none;
  }
 
}
</style>
<script type="text/javascript">
	let buttonCheck = 0; // 수정버튼과 삭제버튼을 구별하기 위한 변수 (비밀번호가 일치했을 때 )
	
	$(function() {
		console.log(${detail.m_stock});
		
		//음악파일 가져오기 및 볼륨 제어  
		let path = $("#m_file").val();
		console.log(path);

		var audio = new Audio(path);
		console.log(audio);
		audio.volume = 0.4;
		audio.autoplay = true;

		$('.trigger').click(function(){
			if (audio.paused == false){
				audio.pause();
				$('.fa-play').show();
				$('.fa-pause').hide();
				$('.music-card').removeClass('playing');
			} else {
				audio.play();
				$('.fa-pause').show();
				$('.fa-play').hide();
				$('.music-card').addClass('playing');
			}
		});
		

		$("#volumeSlider").change(function(){
		    let volume = $(this).val();
		    audio.volume = volume ;
		});
		
		$("#pwdChk").css("visibility", "hidden"); /* 화면에 보이진 않지만, 영역은 차지할 수 있도록.(div) */
		
		
		//수정버튼 클릭 시 처리 이벤트
		$("#updateFormBtn").click(function(){
			$("#pwdChk").css("visibility", "visible");
			$("#msg").text("계정 비밀번호를 입력해 주세요.").css("color", "000099");
			buttonCheck = 1;  
		/* 	$("#f_data").attr("action", "/mboard/updateForm");
			$("#f_data").submit();
			 */
			 boardPwdConfirm();
		});
		//삭제버튼 클릭 시 처리 이벤트
		$("#boardDeleteBtn").click(function(){
			$("#pwdChk").css("visibility", "visible");
			$("#msg").text("계정 입력한 비밀번호를 입력해 주세요.").css("color", "000099"); 
		/* 	$("#f_data").attr("action", "/mboard/boardDelete");
			$("#f_data").submit(); */
			 buttonCheck = 2; 
			boardPwdConfirm();
			
		});
		
		//비밀번호 확인 버튼 클릭 시 처리 이벤트
		$("#pwdBut").click(function(event) {
			boardPwdConfirm();
		});
		$("#pwdButCancel").click(function() {
			$("#pwdChk").css("visibility", "hidden");
			buttonCheck = "";
			$("#passwd").val("");
		});
		$("#boardInsertBtn").click(function() {
			location.href = "/mboard/writeForm";
		});
		//목록 버튼 클릭 시 처리 이벤트
		$("#boardListBtn").click(function() {
			location.href = "/mboard/boardList";
		});
	
		$("#checkOutBtn").click(function() {
			$("#f_data").attr({
				"method" : "get",
				"action" : "/order/checkOut"
			});
			$("#f_data").submit();
		});
		
		
		//좋아요 버튼 클릭 이벤트 
		$("#likeBtn").click(
				function() {
						if (confirm("추천하시겠습니까?")) {
							var m_no = $(this).attr("data-num");
							var m_recommend = $(this).attr("data-recom");
							var recommend_no = parseInt(m_recommend) + 1;
							var currM_no = $(this).attr("data-num");
							var heart = $("<span>");
							heart.addClass("glyphicon glyphicon-heart");
							heart.attr("aria-hidde",true);
							/* console.log("currM_no :"+currM_no);
							console.log("m_no: "+currM_no); */

							$.ajax({
										url : "/mboard/recommend",
										type : "get",
										data : {m_no : m_no},
										success : function(result) {

											if (result == 1) {
												alert("게시물을 추천하셨습니다.");
												console.log(recommend_no);
												$(
														".btn[data-num='"+ m_no + "']").html(recommend_no).append(heart);

											} else {
												alert("이미 추천하신 게시물입니다.");
											}
										}
									}).fail(function() {
								alert("시스템오류");
							});

						}

					

				});
		
		
		//장바구니 버튼 이벤트 
		$("#addCartBtn").click(function() {
			if (confirm("장바구니에 담으시겠습니까?")) {
				var m_no = $("#m_no").val();

				$.ajax({
							url : "/order/addCart",
							type : "post",
							data : $("#f_data").serialize(),
							success : function(result) {
								if (result == 1) {
								if(confirm("장바구니에 상품을 담았습니다. 장바구니로 이동하시겠습니까?")){
									$("#f_data").attr({
										"method" : "GET",
										"action" : "/order/cartList"
									});
									$("#f_data").submit();
									
								}
										
								} else {
									alert("장바구니에 이미 추가되어있는 상품입니다.");
								}
							}
						}).fail(function() {
							alert("시스템오류");
						});

			}


		});
		
		 
        /* 댓글달기 버튼 클릭 시 처리 이벤트 */
    	   $("#mc_insertBtn").click(function () {
    		   if(${userInfo.user_id != ''}){
    			   $("#mcomment").attr({
      					"method" : "post",
      					"action" : "/mcomment/mcommentInsert"
      				});
      				$("#mcomment").submit();
       		   }else{
    			   
    			   alert("로그인후 이용 가능합니다.!");
    		}
    		
		}); 
		
		/* 댓글삭제 버튼 클릭 시 처리 이벤트 */
        $(".mcdeleteBtn").click(function(){
     	   
        	if(confirm("정말 삭제하시겠습니까?")){
        		
				$("#mc_form").attr("action","/mcomment/mcDelete");
				$("#mc_form").submit();
			}
        });
	});
		
	function boardPwdConfirm() {
		console.log($("#user_pwd").val());
		if(!chkData("#user_pwd", "비밀번호를"))return;
		else {
				$.ajax({
				url : "/mboard/pwdConfirm.json", //전송 url
				type : "post",
				data : $("#f_pwd").serialize(),
				dataType : "text",
				error : function() {
					alert("시스템 오류, 관리자에게 문의 하세요.");
				},
				success : function(resultData) {
					console.log(resultData);
					var goUrl = "";
					if (resultData == 0) {
						console.log(resultData);
						$("#msg").text("비밀번호를 확인해주세요.");
						$("#user_pwd").select();
					} else if (resultData == 1) {
						$("#msg").text("");
						console.log(resultData);
						if (buttonCheck == 1) { //수정
							goUrl = "/mboard/updateForm";
							$("#f_data").attr("action", goUrl);
							$("#f_data").submit();
						} else if (buttonCheck == 2) { //삭제
							if (confirm("정말 삭제하시겠습니까?")) {
								goUrl = "/mboard/boardDelete";
								$("#f_data").attr("action", goUrl);
								$("#f_data").submit();
							}
						}
					}
				}
			});
		}
	}
		
</script>
</head>
<body>

	
	<div class="container">
		<form name="f_data" id="f_data">
			<input type="hidden" name="m_no" id="m_no" value="${detail.m_no}" /> 
			<input type="hidden" name="user_id" id="id" value="${userInfo.user_id}" />
		</form>
		<form name="file" id="file">
			<input type="hidden" name="m_file" id="m_file"
				value="/uploadStorage/audioFile/${detail.m_file}" />
		</form>
		<div id="pwdChk" class="authArea  col-md-9 text-left">
			<form name="f_pwd" id="f_pwd" class="form-inline">
				<input type="hidden" name="b_num" id="b_num" value="${detail.m_no}">
				<input type="hidden" name="user_id" id="user_id" value="${userInfo.user_id}" />
				<label for="user_pwd">비밀번호 : </label> 
				<input type="password" name="user_passwd" id="user_pwd" class="form-control" />

				<button type="button" id="pwdBut" class="btn btn-default btn-sm">확인</button>
				<button type="button" id="pwdButCancel"
					class="btn btn-default btn-sm">취소</button>
				<span id="msg"></span>
			</form>
		</div>
		<div class="btnArea col-md-3 text-right">
			<button type="button" id="updateFormBtn"
				class="btn btn-default btn-sm">수정</button>
			<button type="button" id="boardDeleteBtn"
				class="btn btn-default btn-sm">삭제</button>
			<button type="button" id="boardInsertBtn"
				class="btn btn-default btn-sm">쓰기</button>
			<button type="button" id="boardListBtn"
				class="btn btn-default btn-sm">목록</button>
		</div>
		<%-- <div style="background-image: url('/uploadStorage/coverImg/${detail.m_coverimage}');" id ="background"> --%>
			<div class='music-card playing'>
				<div class='image'>
					<img id ="backImg" src="/uploadStorage/coverImg/${detail.m_coverimage}" />
				</div>
				<div>
					<img id ="thumbImg" src="/uploadStorage/coverImg/${detail.m_coverimage}" />
				</div>
				<div class='wave'></div>
				<div class='wave'></div>
				<div class='wave'></div>

				<div class='info'>
					<div>
						<p class="fa fa-pause trigger" style="cursor: pointer;">❚❚</p>

						<p class="fa fa-play trigger" style="cursor: pointer;">▶</p>
					</div>


					<h2 class='title'>${detail.m_title}</h2>
					<div class='artist'>${detail.m_name}</div>
					<div>
						<input id="volumeSlider" class ="range-style" type="range" min="0" max="1" step="0.01" value="0.4" />
					</div>
				</div>

			</div>
		<!-- </div> -->

		<div class="text-center">

			
			<div id="detialInfo">
			<table class = "">
					<tr>
						<td><label class="col-md-1">Author</label></td>
						<td>${detail.m_name}</td>
					</tr>
					<tr>
						<td><label class="col-md-1">Title</label></td>
						<td>${detail.m_title}</td>
					</tr>
					<tr>
						<td><label class="col-md-1">BPM</label></td>
						<td>${detail.m_bpm}</td>
					</tr>
					<tr>
						<td><label class="col-md-1">Genre</label></td>
						<td>${detail.m_genre}</td>
					</tr>
					<tr>
						<td><label class="col-md-1">Content</label></td>
						<td>${detail.m_explan}</td>
					</tr>

				</table>									

			</div>
			<div>
				<c:choose>
					<c:when test="${detail.m_price !=0}">
						
						<c:if test="${detail.m_stock !=0 }">
							<td><button type="button" class="btn btn-default"
									id="paymentBtn" aria-label="Left Align">
									<span aria-hidden="true">BUY</span>
								</button></td>
							<td>
								<button type="button" class="btn btn-success" id="addCartBtn">
									<span class="glyphicon glyphicon-shopping-cart"
										aria-hidden="true"></span>
								</button>
							</td>
						</c:if>
						<c:if test ="${detail.m_stock !=1 }">
						<td><button type="button" class="btn btn-default" disabled="disabled"
									id="paymentBtn" aria-label="Left Align">
									<span aria-hidden="true">SOLD</span>
								</button></td>
						</c:if>
					</c:when>
					<c:otherwise>
						<td><a href="/uploadStorage/audioFile/${detail.m_file}" download
							target="_blank"><button type="button" class="btn btn-default"
									id="fileDownBtn" aria-label="Left Align">
									<span class="glyphicon glyphicon-save" aria-hidden="true"></span>

								</button></a></td>
					</c:otherwise>
				</c:choose>
			</div>
			<div class = "like">
				
				<div><button type="button" class="btn btn-default btn-lg" id ="likeBtn" data-num="${detail.m_no}" data-recom ="${detail.m_recommentcnt }">
				
				${detail.m_recommentcnt }<span class="glyphicon glyphicon-heart" aria-hidden="true"></span></button>
				
			</div>
		</div>
		<hr />
			<h4 class="col-md-2" id="h">댓글 작성</h4>
			 	<div class="container-fluid">
			 	<%-- 	<form name = "f_data" id = "f_data" method = "post">
            			<input type = "hidden" name = "f_no" value = "${detail.f_no}">
         			</form> --%>
			 		<form id="mcomment" name="mcomment">
			 			 <input type = "hidden" name = "m_no" value = "${detail.m_no}" />
			 			 <input type = "hidden" name = "user_id" value = "${userInfo.user_id}" />
			 			<textarea rows="5" class="col-md-11" maxlength="2000" id="mc_text" name="mc_text"></textarea>
			 		</form>
			 		<button type="button" id="mc_insertBtn" class="btn btn-primary btn-sm" >댓글등록</button>
			 		<hr />
			 		
			 		
			 		 		
		         <%-- ====================== 댓글 리스트 시작 ====================== --%>
		         <div id = "mcommentList">
		       
		            <table summary = "댓글 리스트" class = "table">
		               <colgroup>
		               	  <col width ="100%" />
		               </colgroup>
		             
		               <tbody id="list" class="table-striped" >
		      				<!-- 데이터 출력 -->
		      				<c:choose>
		      					<c:when test="${not empty mcommentList}">
		      						<c:forEach var="comment" items="${mcommentList}" varStatus="status">
		      						  <form id="mc_form" method="post">
									         	<input type = "hidden" name = "mc_no" value = "${comment.mc_no}">
									         	<%-- <input type = "hidden" name = "fc_no" value = "${c.fc_no}"> --%>
									      		<input type = "hidden" name = "m_no" value = "${comment.m_no}">
									   </form>
		      						<tr class="text-center" data-num="${comment.mc_no}">
											<td class="text-left">
		      								<%-- <td class="text-center">${comment.fc_no}</td>  --%>
		      								 <%-- <td class="text-center">${comment.f_no}</td>  --%>
		      								<span style="font-weight:bold;">${comment.user_id}  /  ${comment.mc_regdate}</span><br/>
		      								<span class="col-md-11">${comment.mc_text }</span>
		      								
		      								<c:if test="${comment.user_id == userInfo.user_id}">
		      									<button class="mcdeleteBtn btn-primary btn-sm" type="button"  name="mcdeleteBtn">삭제</button>
		      								</c:if>
		      								
		      								
		      								</td>
		      								
		 
		      							</tr>
		      							
		      						</c:forEach>
		      					</c:when>
		      					<c:otherwise>
		      						<tr>
		      							<td colspan="4" class="tac text-center">등록된 댓글이 존재하지않습니다</td>
		      						</tr>
		      					</c:otherwise>
		      				</c:choose>
		               </tbody>
		            </table>
		           
			 	</div>  			
			</div>
		</div>
	</div>
</body>
</html>
