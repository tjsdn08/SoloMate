<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
    let pwCheck = false; // 새 비밀번호 유효성 체크
    
    $("#changePwForm").submit(function(){
        if($("#newPw").val() !== $("#newPw2").val()){
            alert("새 비밀번호와 확인이 일치하지 않습니다.");
            $("#newPw2").focus();
            return false;
        }
        if(!pwCheck){
            alert("새 비밀번호를 유효하게 입력해주세요.");
            $("#newPw").focus();
            return false;
        }
        return true;
    });

    $(".cancelBtn").click(function(){ history.back(); });

    $("#pw, #newPw, #newPw2").on("keyup", function(){
        let pw = $("#pw").val();
        let newPw = $("#newPw").val();
        let newPw2 = $("#newPw2").val();

        if(pw.length < 4) {
            $("#pwMsg").text("현재 비밀번호는 4자 이상입니다.").addClass("text-danger").removeClass("text-success");
        } else {
            $("#pwMsg").text("입력 완료").addClass("text-success").removeClass("text-danger");
        }

        if(newPw.length < 4) {
            $("#newPwMsg").text("새 비밀번호는 4자 이상이어야 합니다.").addClass("text-danger").removeClass("text-success");
            pwCheck = false;
        } else if(newPw === pw) {
            $("#newPwMsg").text("현재 비밀번호와 동일합니다. 다른 비밀번호를 쓰세요.").addClass("text-danger").removeClass("text-success");
            pwCheck = false;
        } else {
            $.ajax({
                url: "checkpw.do",
                data: { pw: newPw },
                success: function(isDuplicate){ 
                    if(isDuplicate === "true"){
                        $("#newPwMsg").text("이전에 사용한 비밀번호입니다.").addClass("text-danger").removeClass("text-success");
                        pwCheck = false;
                    } else {
                        $("#newPwMsg").text("사용 가능한 비밀번호입니다.").addClass("text-success").removeClass("text-danger");
                        pwCheck = true;
                    }
                }
            });
        }

        if(newPw2.length > 0 && newPw !== newPw2) {
            $("#newPw2Msg").text("비밀번호가 일치하지 않습니다.").addClass("text-danger").removeClass("text-success");
        } else if(newPw2.length > 0 && newPw === newPw2) {
            $("#newPw2Msg").text("비밀번호가 일치합니다.").addClass("text-success").removeClass("text-danger");
        }
    });
});
</script>
</head>
<body class="container mt-5">
    <div class="card shadow-sm p-4 mx-auto" style="max-width: 500px;">
        <h2 class="mb-4 text-center">비밀번호 변경</h2>
        <form action="changePw.do" method="post" id="changePwForm">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">
            
            <div class="mb-3">
                <label for="pw" class="form-label">현재 비밀번호</label>
                <input type="password" class="form-control" id="pw" name="pw" required maxlength="20">
                <div id="pwMsg" class="form-text"></div>
            </div>
            
            <div class="mb-3">
                <label for="newPw" class="form-label">새 비밀번호</label>
                <input type="password" class="form-control" id="newPw" name="newPw" required maxlength="20">
                <div id="newPwMsg" class="form-text"></div>
            </div>
          
            <div class="mb-3">
                <label for="newPw2" class="form-label">새 비밀번호 확인</label>
                <input type="password" class="form-control" id="newPw2" name="newPw2" required maxlength="20">
                <div id="newPw2Msg" class="form-text"></div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">변경하기</button>
                <button type="reset" class="btn btn-outline-warning">새로입력</button>
                <button type="button" class="cancelBtn btn btn-link text-secondary text-decoration-none">취소</button>
            </div>
        </form>
    </div>
</body>
</html>