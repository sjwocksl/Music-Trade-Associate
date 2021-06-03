<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags/"%>


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
<script type="text/javascript"
	src="/resources/include/js/jquery-1.12.4.min.js"></script>


<link rel="stylesheet"
	href="/resources/include/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/include/dist/css/bootstrap-theme.css">
<link rel="stylesheet" href="/resources/include/css/mboard/MusicBoard.css">



<script src="/resources/include/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>



<!--[if lt IE 9]>
		<script src="../js/html5shiv.js"></script>
		<![endif]-->
<style type="text/css">



.required {
	color: red;
}

.goDetail, .img {
	height: 140px;
	width: 140px;
	border-radius: 30px;
	cursor: pointer;
}
.goDetail{
	font-size: 12px; 
}

.goDetailRank {
	height: 220px;
	width: 220px;
	border-radius: 10px 100px/120px;
	cursor: pointer;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th,
	.table>thead>tr>td, .table>thead>tr>th {
	vertical-align: middle;
}
/* -webkit-box-shadow: 15px 15px 20px rgba(0,0, 0, 0.4);
-moz-box-shadow: 15px 15px 20px rgba(0,0, 0, 0.4);
box-shadow: 15px 15px 20px rgba(0,0, 0, 0.4);
-webkit-transform: scale(1.05);
-moz-transform: scale(1.05);
transform: scale(1.05);
}
with:-

audio
{
-webkit-transition:all 0.5s linear;
-moz-transition:all 0.5s linear;
-o-transition:all 0.5s linear;
transition:all 0.5s linear;
-moz-box-shadow: 2px 2px 4px 0px #006773;
-webkit-box-shadow:  2px 2px 4px 0px #006773;
box-shadow: 2px 2px 4px 0px #006773;
-moz-border-radius:7px 7px 7px 7px ;
-webkit-border-radius:7px 7px 7px 7px ;
border-radius:7px 7px 7px 7px ;
} */

/* audio::-webkit-media-controls-fullscreen-button
 */
</style>
<script type="text/javascript">
function goPage() {
	if($("#search").val()=="all"){
		$("#keyword").val("");
	}
	$("#f_search").attr({
		"method" : "get",
		"action" :"/mboard/boardList"
	});
	$("#f_search").submit();	
}

// 좋아요 여부 체크function
	

/* 	function likeCheck(m_no) {
		var like_Check ;
		$.ajax({
			url : "/board/likeCheck",
			type : "get",
			data : {
				m_no : m_no
			},
			success : function(result) {
				like_Check = result;
				console.log(like_Check);
			},
			error : function() {
				alert("system error !!");
			}
		});
		return like_Check;
	} */

/* 	 function likeCheck(m_no) {
	
	 
	
	 console.log(m_no);
	 $("#m_no").val(m_no);
	 $("#detailForm").attr({
	 "method" : "get",
	 "action" : "/board/likeCheck"
	 });
	 $("#detailForm").submit();
	 } */
	

	$(function() {
		//새로운 글 불러오기
		
		
		
		
		
				//좋아요 버튼 클릭 이벤트 
		$(".btn.btn-default.btn-xs").click(
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
														".btn[data-num='"+ m_no + "']").html(recommend_no).append(하트);

											} else {
												alert("이미 추천하신 게시물입니다.");
											}
										}
									}).fail(function() {
								alert("시스템오류");
							});

						}

					

				});

		// 글 작성 버튼 이벤트 
		$("#insertFormBtn").click(function() {
			location.href = "/mboard/writeForm";
		});

		/* 제목 클릭 시 상세 페이지 이동을 위한 이벤트  */
		$(".goDetail,.img").click(function() {
			var m_no = $(this).parents("tr").attr("data-num");
			console.log(m_no);
			$("#m_no").val(m_no);
			$("#detailForm").attr({
				"method" : "get",
				"action" : "/mboard/boardDetail"
			});
			$("#detailForm").submit();
		});
		//buy button event
		$(".btn.btn-default.payment").click(function() {
			//console.log("filedownlaod btn clicked ");
			var m_no = $(this).parents("tr").attr("data-num");
			console.log(m_no);
			$("#m_no").val(m_no);
			$("#detailForm").attr({
				"method" : "get",
				"action" : "/mboard/payment"
			});
			$("#detailForm").submit();

		});

		//장바구니 버튼 이벤트 
		$(".btn.btn-success.cart").click(function() {
			if (confirm("장바구니에 담으시겠습니까?")) {
				var m_no = $(this).parents("tr").attr("data-num");

				$.ajax({
							url : "/basket/cart",
							type : "get",
							data : {m_no : m_no},
							success : function(result) {
								if (result == 1) {
								if(confirm("장바구니에 상품을 담았습니다. 장바구니로 이동하시겠습니까?")){
									location.href = "/order/cartList";
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
		
		
		/*rank 영역 클릭 시 상세 페이지 이동 */
		$(".goDetailRank").click(function() {
			var m_no = $(this).parents("figure").attr("data-num");
			//console.log(m_no);
			$("#m_no").val(m_no);
			$("#detailForm").attr({
				"method" : "get",
				"action" : "/mboard/boardDetail"
			});
			$("#detailForm").submit();
		});

		/* 검색 후 검색 대상과 검색 단어 출력 */
		let word = "<c:out value ='${data.keyword}'/>";
		let value = "";

		if (word != "") {
			$("#keyword").val("<c:out value ='${data.keyword}'/>");
			$("#search").val("<c:out value ='${data.search}'/>");

			if ($("#search").val() != 'm_explain') {
				//:contains()는 특정 텍스틀 포함한 요소 반환
				if ($("#search").val() == 'm_title')
					value = "#list tr td.goDetail";
				else if ($("#search").val() == 'm_name')
					value = "#list tr td.name";

				console.log($(value + ":contains('" + word + "')").html());

				$(value + ":contains('" + word + "')").each(
						function() {
							var regex = new RegExp(word, 'gi');
							$(this).html(
									$(this).html().replace(
											regex,
											"<span class = 'required'>" + word
													+ "</span>"));
						});

			}
		}
		


		/* 검색 버튼 클릭 시 처리 이벤트 */
		$("#searchData").click(function() {
			if ($("#search").val() != "all") {
				if (!chkData("#keyword", "검색어를")) return;
			} else if ($("#search").val() == "all") {
				$("#keyword").val("");
			}
			$("#f_search").attr({
				"method" : "GET",
				"action" : "/mboard/boardList"

			});
			$("#f_search").submit();
		});

		/* pageMaker */
    	$(".paginate_button a").click(function (e) {
			e.preventDefault();
			$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
			goPage();
		});
	
	}); // 최상위 종료
</script>

<title>BoardList</title>
</head>

<body>
	<div class="container">
		<div id="music_rank">
			<c:choose>
				<c:when test="${not empty recentList }">
					<!-- if 문으로 not empty가 true 일때, list가 있을 때 실행되는 구문. -->


					<c:forEach var="board" items="${recentList}" varStatus="status">
						<figure class="rank_track" data-num="${board.m_no}">

							<!-- click function() -->
							<img src="/uploadStorage/coverImg/${board.m_coverimage}"
								class="goDetailRank" />
							<figcaption>
								<p class="track_nm">${board.m_title}</p>
								<p class="artist_nm">${board.m_name}</p>
							</figcaption>
						</figure>
					</c:forEach>

				</c:when>


				<c:otherwise>
					<!-- if문의 else -->
					<p class="tac text-center">등록된 게시물이 존재하지 않습니다.</p>
				</c:otherwise>
			</c:choose>

		</div>




		<form id="detailForm">
			<input type="hidden" id="m_no" name="m_no" />
		</form>
		<form id="f_data">
				<input type="hidden" id="user_id"  name="user_id" value="${userInfo.user_id}" />
				<input type="hidden" id="m_no"  name="m_no" />
		</form>
		<%-- =====================검색기능 시작 =========================== --%>
		<div id="boardSearch" class="text-right">
			<form id="f_search" name="f_search" class="form-inline">
				<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}"> 
				<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				<div class="form-group">
					<label>검색조건</label> <select id="search" name="search"
						class="form-control">
						<option value="all">전체</option>
						<option value="m_title">제목</option>
						<option value="m_explain">내용</option>
						<option value="m_name">작성자</option>
					</select> <input type="text" id="keyword" name="keyword"
						placeholder="검색어를 입력하세요" class="form-control">
					<button type="button" id="searchData"
						class="btn btn-primary btn-sm">검색</button>
				</div>
			</form>
		</div>
		<%-- =====================검색기능 종료 =========================== --%>
		<div class="text-center">
			<!-- <h3>글목록</h3> -->
		</div>
		<%-- ==================== 리스트 시작 =========================== --%>
		<div id="boardsList">
			<table summary="게시판 리스트" class="table">

				<colgroup>
					<col width="10%" />
					<col width="50%" />
					<col width="21%" />
					<col width="13%" />
					<col width="24%" />
					<col width="50%" />
				</colgroup>
				<thead>
					<tr>
						<th>앨범커버</th>
						<th>제목</th>
						<th>가격</th>
						<th>작성자</th>
						<th>장르</th>
						<th>추천수</th>
						<th></th>

					</tr>
				</thead>
				<tbody id="list" class="table">
					<!-- 데이터 출력 -->
					
					<c:choose>
						<c:when test="${not empty boardList }">
							<!-- if 문으로 not empty가 true 일때, list가 있을 때 실행되는 구문. -->
							<c:forEach var="board" items="${boardList}" varStatus="status">
								<!-- items 의 항목을 모두 반복 -->
								
								
								<tr class="text-center" data-num="${board.m_no}">
									
									<!-- data-num 이 해당 글번호를 가지고있다. -->
									<td><img class = "img"
										src="/uploadStorage/coverImg/${board.m_coverimage}" /></td>
									<td class="goDetail text-left">${board.m_title}</td>
									<c:choose>
										<c:when test ="${board.m_price != 0}">
											<td class="text-center"> <fmt:formatNumber value="${board.m_price}" type="currency"  currencyCode ="KRW" pattern="₩ ###,###,###" /></td>
										</c:when>
										<c:otherwise>
											<td class="text-center">무료 배포</td>
										</c:otherwise>
									</c:choose>								
									<td class="name">${board.user_id}</td>
									<td class ="genre">${board.m_genre}</td>
									<td class="">
										<button type="button" class="btn btn-default btn-xs"  data-num="${board.m_no}" data-recom ="${board.m_recommentcnt }">				
											${board.m_recommentcnt}
											<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
											</button>
											
									<td class="player-container" oncontextmenu='return false'>
									
									<audio id="player" controls controlsList="nodownload"
											src="/uploadStorage/audioFile/${board.m_file}"></audio></td>
									<c:choose>
									
										<c:when test ="${board.m_price !=0}">
											<c:if test ="${board.m_stock !=0}">
												<td><button type="button" class="btn btn-default payment"
														 aria-label="Left Align">
														<span aria-hidden="true">BUY</span>
													</button></td>
													<td>
														<button type="button" class="btn btn-success cart" data-no="${board.m_no}" >
															 <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>	
														</button>
														</td>
											</c:if>
											<c:if test = "${board.m_stock !=1}">
												<td><button type="button" class="btn btn-default payment" disabled="disabled"
														 aria-label="Left Align">
														<span aria-hidden="true">SOLD</span>
													</button></td>
											</c:if>
										</c:when>
										
										<c:otherwise>
											<td><a href="/uploadStorage/audioFile/${board.m_file}" downlaod><button type="button" class="btn btn-default"
											id="fileDownBtn" aria-label="Left Align">
											<span class="glyphicon glyphicon-save" aria-hidden="true"></span>
										
										</button></a></td>
										</c:otherwise>
									</c:choose>	
											
									
								</tr>
						

							</c:forEach>
						</c:when>
						<c:otherwise>
							<!-- if문의 else -->
							<tr>
								<td colspan="4" class="tac text-center">등록된 게시물이 존재하지 않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
					
				</tbody>
			</table>
		</div>
		<!-- ==========================리스트 종료============================== -->
		<!--==========================pagination============================== -->
		<tag:simple endPage="${pageMaker.endPage }"
			startPage="${pageMaker.startPage }" amount="${pageMaker.cvo.amount }"
			next="${pageMaker.next }" prev="${pageMaker.prev }"
			pageNum="${pageMaker.cvo.pageNum }" />


		<!-- ==========================글쓰기 버튼 출력 시작====================== -->
		<div class="contentBtn text-right">
			<input type="button" id="insertFormBtn" class="btn btn-success"
				value="글쓰기">
		</div>
		<!— ==========================글쓰기 버튼 출력 종료======================= —>
	</div>

	<form id = "like_f">
	<input type ="hidden" id="likecnt" name ="likecnt" value ="${result.likecnt}"/>
	</form>

</body>
</html>