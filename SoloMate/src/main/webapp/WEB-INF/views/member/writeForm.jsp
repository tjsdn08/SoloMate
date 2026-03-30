<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
  <script type="text/javascript">
  $(function(){
	  let idCheck = false;
	  
	  $("writeForm").submit(function(){
		 
		  if($("#pw").val() != $("#pw2").val()){
			  alert("비밀번호와 비밀번호 확인이 같지 않습니다. 재확인 하세요.");
			  $("#pw, #pw2").val("");
			  $("#pw").focus();
			  return false;
		  }
		  if(!idCheck){
			  alert("사용 가능한 아이디를 입력하세요.");
			  $("#id").focus();
			  return false;
		  }
	  });
	  $(".cancelBtn").click(function(){
		  history.back();
	  });
	  $("#id").keyup(function(){
		  idCheck = false;
		 let id = $(this).val();
		 let len = id.length;
		 if(len == 0) {
			 $("#idMsg").removeClass("alert-danger alert-success");
			 $("#idMsg").addClass("alert-danger");
			 $("#idMsg").text("아이디는 필수 입력 사항입니다.");
		 } else if(len < 4) {
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
<h2>회원 가입</h2>
	<form action="write.do" method="post" id="writeForm">
	  <div class="mb-3 mt-3">
	    <label for="id" class="form-label">아이디</label>
	    <input type="text" class="form-control" id="id" placeholder="아이디를 입력하세요." name="id"
	     title="아이디는 영문부터 영숫자만 4~20 사이로 입력하셔야 합니다." required autofocus maxlength="20"
	     pattern="[a-zA-Z][a-zA-Z0-9]{3,19}" >
	    <div class="alert alert-danger" id="idMsg">
		  아이디는 필수 입력 사항입니다.
		</div>
	  </div>
	  
 	  <div class="mb-3">
	    <label for="pw" class="form-label">비밀번호</label>
	    <input type="password" class="form-control" id="pw" placeholder="비밀번호를 입력하세요."
	     title="비밀번호는 4~20자 사이로 입력하셔야 합니다." maxlength="20"
	     name="pw" required pattern=".{4,20}">
	  </div>
	  
	  <div class="mb-3">
	    <label for="pw2" class="form-label">비밀번호 확인</label>
	    <input type="password" class="form-control" id="pw2" placeholder="비밀번호 확인을 입력하세요."
	     title="비밀번호확인은 4~20자 사이로 입력하셔야 합니다." maxlength="20"
	     required pattern=".{4,20}">
	  </div>	
	  
	
	  <div class="mb-3 mt-3">
	    <label for="name" class="form-label">이름</label>
	    <input type="text" class="form-control" id="name" placeholder="이름을 입력하세요."
	     title = "이름은 2~10자 한글로 입력하세요." pattern="[가-힣]{2,10}"
	     maxlength="10" name="name" required>
	  </div>
	  
	  <div class="mb-3 mt-3">
	    <label for="tel" class="form-label">연락처</label>
	    <input type="tel" class="form-control" id="tel" placeholder="연락처를 입력하세요."
	     title="02-xxx-xxxx 또는 010-xxxx-xxxx 형식으로 입력하세요."
	     name="tel" pattern="0\d{1,2}-\d{3,4}-\d{4}">
	  </div>
	  
	<div class="mb-3 mt-3">
	  <label for="address" class="form-label">주소</label>
	  <input type="text" class="form-control" id="address" placeholder="주소를 입력하세요."
	   title="주소는 상세 주소를 포함하여 100자 이내로 입력하세요."
	   maxlength="100" name="address" required>
	</div>

	  <button type="submit" class="btn btn-primary">등록</button>
	  <button type="reset" class="btn btn-warning">초기화</button>
	  <button type="button" class="cancelBtn btn btn-secondary">취소</button>
	</form>
</body>
</html>