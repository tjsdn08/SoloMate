<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>
  <script type="text/javascript">
  $(function(){
	  let pwCheck = false;
	  
	  $("changePw").submit(function(){
		 
		  if($("#newPw").val() != $("#newPw2").val()){
			  alert("새 비밀번호와 새 비밀번호 확인이 같지 않습니다. 재확인 하세요.");
			  $("#newPw, #newPw2").val("");
			  $("#newPw").focus();
			  return false;
		  }
		  if(!pwCheck){
			  alert("사용 가능한 비밀번호를 입력하세요.");
			  $("#id").focus();
			  return false;
		  }
	  });
	  $(".cancelBtn").click(function(){
		  history.back();
	  });
	  $("#pw,#newPw,#newPw2").keyup(function(){
		  pwCheck = false;
		 let pw = $(this).val();
		 let len1 = pw.length;
		 let newPw = $(this).val();
		 let len2 = newPw.length;
		 let newPw2 = $(this).val();
		 let len3 = newPw2.length;
		 if(len1 == 0) {
			 $("#pwMsg").removeClass("alert-danger alert-success");
			 $("#pwMsg").addClass("alert-danger");
			 $("#pwMsg").text("아이디는 필수 입력 사항입니다.");
		 } else if(len1 < 4) {
			 $("#idMsg").removeClass("alert-danger alert-success");
			 $("#idMsg").addClass("alert-danger");
			 $("#idMsg").text("아이디는 4자 이상 입력하셔야 합니다.");
		 }
		 
		 if(len2 == 0) {
			 $("#idMsg").removeClass("alert-danger alert-success");
			 $("#idMsg").addClass("alert-danger");
			 $("#idMsg").text("아이디는 필수 입력 사항입니다.");
		 } else if(len2 < 4) {
			 $("#idMsg").removeClass("alert-danger alert-success");
			 $("#idMsg").addClass("alert-danger");
			 $("#idMsg").text("아이디는 4자 이상 입력하셔야 합니다.");
		 }
		 
		 if(len3 == 0) {
			 $("#idMsg").removeClass("alert-danger alert-success");
			 $("#idMsg").addClass("alert-danger");
			 $("#idMsg").text("아이디는 필수 입력 사항입니다.");
		 } else if(len3 < 4) {
			 $("#idMsg").removeClass("alert-danger alert-success");
			 $("#idMsg").addClass("alert-danger");
			 $("#idMsg").text("아이디는 4자 이상 입력하셔야 합니다.");
		 } else {
			  $.ajax(

				{
					url: "checkId.do?id=" + id,
					success: function(result){ 
						console.log("[" + result + "]");
				    	if(result){
							 $("#idMsg").removeClass("alert-danger alert-success");
							 $("#idMsg").addClass("alert-danger");
							 $("#idMsg").text("아이디(" + id + ")는 중복 아이디입니다. 사용할 수 없습니다.");
				    	} else {
							 $("#idMsg").removeClass("alert-danger alert-success");
							 $("#idMsg").addClass("alert-success");
							 $("#idMsg").text("아이디(" + id + ")는 사용 가능합니다.");
							 idCheck = true;
				    	}
				    	
				  	},
				  	error: function(xhr,status,error){
				  		console.log("xhr=" + xhr + ", status=" + status + ", error=" + error);
				  	}
				}
			);
		 }
		 
	  });
	  
  });
  </script>
<body>
<h2>비밀번호 변경</h2>
	<form action="changePw.do" method="post">
		<input type="hidden" name="page" value="${param.page }">
		<input type="hidden" name="perPageNum" value="${param.perPageNum }">
		<input type="hidden" name="key" value="${param.key }">
		<input type="hidden" name="word" value="${param.word }">
		
	  
		<div class="mb-3">
		    <label for="pw" class="form-label">현재 비밀번호</label>
		    <input type="password" class="form-control" id="pw" placeholder="본인 확인용 현재 비밀번호 입력" name="pw"
		     required maxlength="20">
		</div>
		
		<div class="mb-3">
		    <label for="newPw" class="form-label">새 비밀번호 입력</label>
		    <input type="password" class="form-control" id="newPw" placeholder="새 비밀번호 입력" name="newPw"
		     required maxlength="20">
		</div>
	  
  	  <div class="mb-3 mt-3">
	    <label for="newPw2" class="form-label">새 비밀번호 확인</label>
	    <input type="password" class="form-control" id="newPw2" placeholder="본인 확인용 비밀번호를 입력하세요." name="newPw2">
	  </div>

	  <button type="submit" class="btn btn-primary">변경하기</button>
	  <button type="reset" class="btn btn-warning">새로입력</button>
	  <button type="button" class="cancelBtn btn btn-secondary">취소</button>
	</form>
</body>
</html>