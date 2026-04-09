<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Solomate : <decorator:title /></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.2/jquery-ui.js"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script type="text/javascript">
$(function(){
	// 모달 창을 띄운다.
	${(!empty msg)?"$('#msgModal').modal('show');":""}
});
// ${(!empty msg)?"alert('" += msg += "');":""}
</script>
<decorator:head />
</head>

<body class="d-flex flex-column min-vh-100">
	<%@ include file="../inc/mainMenu.jsp"%>
	<div class="container-fluid flex-grow-1"
		style="margin-top: 80px; margin-bottom: 40px;">
		<div class="container mt-3 mb-3">
			<decorator:body />
		</div>
	</div>

	<footer class="mt-auto" style="background-color: #f8f9fa; border-top: 1px solid #dee2e6; width: 100%;">
	    <div style="padding: 20px 0; text-align: center;">
	        <span style="color: #adb5bd; font-size: 0.85rem; font-weight: 500;">
	            Copyright &copy; SoloMate.com
	        </span>
	    </div>
	</footer>

	<div class="modal" id="msgModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<div class="modal-header">
					<h4 class="modal-title">처리 결과</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<div class="modal-body">${msg }</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>
</body>
</html>
<%
// 글등록한 결과 메시지 지우기
session.removeAttribute("msg");
%>