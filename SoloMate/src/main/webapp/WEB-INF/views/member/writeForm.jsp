<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.admin-page {
	padding: 80px 30px 30px 30px;
	min-height: 100vh;
	display: flex;
	align-items: flex-start;
	justify-content: center;
	box-sizing: border-box;
}
.admin-card {
	background: #fff;
	border-radius: 18px;
	padding: 40px 30px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
	width: 100%;
	max-width: 500px;
}

.top-bar {
	text-align: center;
	margin-bottom: 30px;
}

.top-title {
	font-size: 28px;
	font-weight: 800;
	color: #111;
	margin: 0;
}

/* 폼 전용 스타일 */
.form-group {
	margin-bottom: 24px;
}

.form-label {
	display: block;
	font-size: 14px;
	font-weight: 600;
	color: #4b5563;
	margin-bottom: 8px;
}

.form-input {
	width: 100%;
	height: 48px;
	border: 1px solid #ddd;
	border-radius: 12px;
	padding: 0 14px;
	font-size: 15px;
	outline: none;
	box-sizing: border-box;
	transition: border-color 0.2s ease;
}

.form-input:focus {
	border-color: #111;
}

/* 인풋 곁에 버튼이 있는 경우 (아이디 중복 확인) */
.input-with-btn {
	display: flex;
	gap: 8px;
}

.input-with-btn .form-input {
	flex: 1;
}

.input-with-btn .btn-sub {
	width: auto;
	padding: 0 16px;
	white-space: nowrap;
}

/* 상태 메시지 알림 박스 (기존 jQuery 로직과 연동되는 클래스) */
.alert {
	padding: 12px 14px;
	margin-top: 10px;
	border-radius: 10px;
	font-size: 13px;
	font-weight: 500;
	display: block;
}

.alert-secondary {
	background-color: #f8f9fa;
	color: #6c757d;
	border: 1px solid #e9ecef;
}

.alert-danger {
	background-color: #fff5f5;
	color: #c92a2a;
	border: 1px solid #ffe3e3;
}

.alert-success {
	background-color: #f0fdf4;
	color: #15803d;
	border: 1px solid #dcfce7;
}

/* 하단 버튼 영역 */
.btn-main, .btn-sub {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 48px;
	border-radius: 12px;
	border: none;
	font-size: 15px;
	font-weight: 700;
	text-decoration: none;
	cursor: pointer;
	transition: background 0.2s ease;
	box-sizing: border-box;
}

.btn-main {
	background: #111827;
	color: #fff;
	flex: 2; /* 메인 버튼 강조 */
}

.btn-main:hover {
	background: #374151;
	color: #fff;
}

.btn-sub {
	background: #eef0f4;
	color: #333;
	flex: 1;
}

.btn-sub:hover {
	background: #e5e7eb;
}

.bottom-buttons {
	display: flex;
	justify-content: space-between;
	gap: 10px;
	margin-top: 32px;
}
</style>

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
<body>

	<div class="admin-page">
		<form action="write.do" method="post" id="writeForm" class="admin-card">
			
			<div class="top-bar">
				<h2 class="top-title">회원 가입</h2>
			</div>

			<div class="form-group">
				<label for="id" class="form-label">아이디</label>
				<div class="input-with-btn">
					<input type="text" class="form-input" id="id" name="id" 
						   placeholder="4~20자 영문, 숫자" required maxlength="20" 
						   pattern="[a-zA-Z][a-zA-Z0-9]{3,19}">
					<button class="btn-sub" type="button" id="checkIdBtn">중복 확인</button>
				</div>
				<div class="alert alert-secondary" id="idMsg">
					아이디 중복 확인을 해주세요.
				</div>
			</div>
			
			<div class="form-group">
				<label for="pw" class="form-label">비밀번호</label>
				<input type="password" class="form-input" id="pw" name="pw" required maxlength="20">
				<div class="alert alert-danger" id="pwMsg">비밀번호는 4~20자 사이여야 합니다.</div>
			</div>
			
			<div class="form-group">
				<label for="pw2" class="form-label">비밀번호 확인</label>
				<input type="password" class="form-input" id="pw2" required maxlength="20">
				<div class="alert alert-danger" id="pw2Msg">비밀번호를 한 번 더 입력하세요.</div>
			</div>    
			
			<div class="form-group">
				<label for="name" class="form-label">이름</label>
				<input type="text" class="form-input" id="name" name="name" required pattern="[가-힣]{2,10}">
			</div>
			
			<div class="form-group">
				<label for="tel" class="form-label">연락처</label>
				<input type="tel" class="form-input" id="tel" name="tel" 
					   placeholder="010-0000-0000" required 
					   title="010-xxxx-xxxx 형식으로 입력하세요."
					   maxlength="13">
				<div class="alert alert-danger" id="telMsg">연락처는 필수 입력 사항입니다.</div>
			</div>
			
			<div class="form-group">
				<label for="address" class="form-label">주소</label>
				<input type="text" class="form-input" id="address" name="address" required>
			</div>

			<div class="bottom-buttons">
				<button type="submit" class="btn-main">등록</button>
				<button type="reset" class="btn-sub">초기화</button>
				<button type="button" class="btn-sub cancelBtn">취소</button>
			</div>
			
		</form>
	</div>

</body>
</html>