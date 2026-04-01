<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
$(function(){
    let idCheck = false;  // 아이디 중복 체크 통과 여부
    let pwCheck = false;  // 비밀번호 양식 및 일치 여부
    let telCheck = false; // 연락처 체크 통과 여부
    
    // 1. 등록 폼 제출 전 최종 검사
    $("#writeForm").submit(function(){
        if(!idCheck){
            alert("아이디 중복 확인을 완료해야 합니다.");
            $("#checkIdBtn").focus(); 
            return false;
        }
        if(!pwCheck){
            alert("비밀번호 양식(4~20자)과 일치 여부를 확인하세요.");
            $("#pw").focus();
            return false;
        }
        if(!telCheck){
            alert("연락처를 형식(010-0000-0000)에 맞게 입력하세요.");
            $("#tel").focus();
            return false;
        }
    });

    // 2. 아이디 중복 확인 버튼 클릭 이벤트
    $("#checkIdBtn").click(function(){
        let id = $("#id").val();
        
        let idReg = /^[a-zA-Z][a-zA-Z0-9]{3,19}$/;
        
        if(!idReg.test(id)) {
            alert("아이디는 영문으로 시작하는 4~20자 영숫자여야 합니다.");
            $("#id").focus();
            return;
        }

        $.ajax({
            url: "checkId.do?id=" + id,
            success: function(result){ 
                console.log("서버 결과: [" + result + "]");
                if(result.trim() == "1" || result.trim() == "true"){ 
                     $("#idMsg").removeClass("alert-success alert-secondary").addClass("alert-danger")
                                .text("이미 사용 중인 아이디입니다.");
                     idCheck = false;
                } else { 
                     $("#idMsg").removeClass("alert-danger alert-secondary").addClass("alert-success")
                                .text("사용 가능한 아이디입니다.");
                     idCheck = true;
                }
            }
        });
    });

    // 3. 아이디를 수정하면 다시 중복 체크를 하도록 리셋
    $("#id").on("input", function(){
        idCheck = false; // 체크 상태 해제
        $("#idMsg").removeClass("alert-success alert-danger").addClass("alert-secondary")
                   .text("아이디가 변경되었습니다. 다시 중복 확인을 해주세요.");
    });

    // 4. 비밀번호 실시간 체크
    function checkPassword() {
        let pw = $("#pw").val();
        let pw2 = $("#pw2").val();
        let pwReg = /^.{4,20}$/; 

        if(!pwReg.test(pw)) {
            $("#pwMsg").removeClass("alert-success").addClass("alert-danger").text("비밀번호는 4~20자 사이여야 합니다.");
            pwCheck = false;
        } else {
            $("#pwMsg").removeClass("alert-danger").addClass("alert-success").text("사용 가능한 비밀번호 양식입니다.");
            
            // 비밀번호 확인 칸에 입력이 있을 때만 일치 여부 표시
            if(pw2.length > 0) {
                if(pw !== pw2) {
                    $("#pw2Msg").removeClass("alert-success").addClass("alert-danger").text("비밀번호가 일치하지 않습니다.");
                    pwCheck = false;
                } else {
                    $("#pw2Msg").removeClass("alert-danger").addClass("alert-success").text("비밀번호가 일치합니다.");
                    pwCheck = true;
                }
            }
        }
    }

    $("#pw, #pw2").on("keyup input", function(){
        checkPassword();
    });

    // 5. 연락처 유효성 검사
    $("#tel").on("keyup input", function(){
        let tel = $(this).val();
        let telReg = /^010-\d{3,4}-\d{4}$/;

        if(!telReg.test(tel)) {
            $("#telMsg").removeClass("alert-success").addClass("alert-danger")
                        .text("형식에 맞지 않습니다. (010-0000-0000)");
            telCheck = false;
        } else {
            $("#telMsg").removeClass("alert-danger").addClass("alert-success")
                        .text("올바른 연락처 형식입니다.");
            telCheck = true;
        }
    });

    $(".cancelBtn").click(function(){ history.back(); });
});
</script>
</head>
<body class="container">
    <h2 class="mt-5 pt-5 mb-4">🍯 회원 가입</h2>

    <form action="write.do" method="post" id="writeForm" class="card p-4 shadow-sm">
	<div class="mb-3">
	    <label for="id" class="form-label fw-bold">아이디</label>
	    <div class="input-group">
	        <input type="text" class="form-control" id="id" name="id" 
	               placeholder="4~20자 영문, 숫자" required maxlength="20" 
	               pattern="[a-zA-Z][a-zA-Z0-9]{3,19}">
	        <button class="btn btn-outline-dark" type="button" id="checkIdBtn">중복 확인</button>
	    </div>
	    <div class="alert alert-secondary mt-2 py-2" id="idMsg">
	        아이디 중복 확인을 해주세요.
	    </div>
	</div>
      
      <div class="mb-3">
        <label for="pw" class="form-label fw-bold">비밀번호</label>
        <input type="password" class="form-control" id="pw" name="pw" required maxlength="20">
        <div class="alert alert-danger mt-2 py-2" id="pwMsg">비밀번호는 4~20자 사이여야 합니다.</div>
      </div>
      
      <div class="mb-3">
        <label for="pw2" class="form-label fw-bold">비밀번호 확인</label>
        <input type="password" class="form-control" id="pw2" required maxlength="20">
        <div class="alert alert-danger mt-2 py-2" id="pw2Msg">비밀번호를 한 번 더 입력하세요.</div>
      </div>    
      
      <div class="mb-3">
        <label for="name" class="form-label fw-bold">이름</label>
        <input type="text" class="form-control" id="name" name="name" required pattern="[가-힣]{2,10}">
      </div>
      
	<div class="mb-3">
	    <label for="tel" class="form-label fw-bold">연락처</label>
	    <input type="tel" class="form-control" id="tel" name="tel" 
	           placeholder="010-0000-0000" required 
	           title="010-xxxx-xxxx 형식으로 입력하세요."
	           maxlength="13">
	    <div class="alert alert-danger mt-2 py-2" id="telMsg">연락처는 필수 입력 사항입니다.</div>
	</div>
	
      <div class="mb-4">
        <label for="address" class="form-label fw-bold">주소</label>
        <input type="text" class="form-control" id="address" name="address" required>
      </div>

      <div class="d-flex gap-2">
          <button type="submit" class="btn btn-dark px-4">등록</button>
          <button type="reset" class="btn btn-outline-secondary">초기화</button>
          <button type="button" class="cancelBtn btn btn-link text-decoration-none text-muted">취소</button>
      </div>
    </form>
</body>
</html>