<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
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
		
		<!--[if lt IE 9]>
		<script src="../js/html5shiv.js"></script>
		<![endif]-->
		<script type="text/javascript">
			$(function() {
				$("#boardUpdateBtn").click(function() {
					if(!chkData("#m_text","제목을")) return;
					else if(!chkData("#m_text","내용을")) return ;
					else{
						$("#f_updateForm").attr({
							"method":"post",
							"action":"/mboard/boardUpdate"
						});
						$("#f_updateForm").submit();
					}
				});
				$("#boardCancelBtn").click(function() {
					$("#f_updateForm").each(function(){
						this.reset();
					});
				});
				
				$("#boardListBtn").click(function() {
					location.href = "/mboard/boardList";
				});
			});
		</script>
		<title>UpdateForm.jsp</title>
	</head>
	<body>

	<div class="container">
	
		<h3><b>작성자 : ${userInfo.user_id}</b></h3>
		<div class="text-cencter">
			<form id="f_updateForm" name="f_updateForm">
				<input type="hidden" id="m_no" name="m_no" value="${updateData.m_no }"/>
				<table class="table table-bordered">
					<colgroup>
						<col width="17%" />
						<col width="33%" />
						<col width="17%" />
						<col width="33%" />
					<tbody>
						<tr>
							<td>글번호</td>
							<td colspan="3" class="text-left">${updateData.m_no}</td>
						</tr>
						<tr>
							<td>작성일</td>
							<td colspan="3" class="text-left">${updateData.m_regdate}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="3" class="text-left">${userInfo.user_id}</td>
						</tr>
						<tr>
							<td>글제목</td>
							<td colspan="3" class="text-left" ><input type="text" id="m_title" name="m_title"
								value="${updateData.m_title }" class="form-control" /></td>
						</tr>
						<tr class="table-height">
							<td>글내용</td>
							<td colspan="3" class="text-left"><textarea rows="8px"
									id="m_text" name="m_text" class="form-control"
									style="resize: none;">${updateData.m_text}</textarea></td>
						</tr>
						
					</tbody>
				</table>
			</form>
		</div>
	</div>

	<div class="text-center">
		<input type="button" value="수정" id="boardUpdateBtn" class="btn btn-success"/> 
		<input type="button" value="취소" id="boardCancelBtn" class="btn btn-success"/> 
		<input type="button" value="목록" id="boardListBtn" class="btn btn-success"/>
	</div>
</body>
</html>