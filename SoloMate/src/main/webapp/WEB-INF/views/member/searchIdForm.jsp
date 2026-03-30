<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
    $("#searchIdForm").submit(function(e){
        e.preventDefault(); // 실제 페이지가 넘어가는 것을 방지

        let name = $("#name").val();
        let tel = $("#tel").val();

        $.ajax({
            url: "searchId.do",
            type: "post",
            data: { name: name, tel: tel },
            success: function(result){
                if(result && result !== "none") {
                    alert("찾으시는 아이디는 [" + result + "] 입니다.");
                    location.href = "loginForm.do"; 
                } else {
                    alert("일치하는 회원 정보가 없습니다. 다시 확인해주세요.");
                }
            },
            error: function() {
                alert("아이디 찾기 중 오류가 발생했습니다.");
            }
        });
    });

    $(".cancelBtn").click(function(){ history.back(); });
});
</script>

<form action="searchId.do" method="post" id="searchIdForm">
</head>
<body class="container mt-5">
    <div class="card shadow-sm p-4 mx-auto" style="max-width: 500px;">
        <h2 class="mb-4 text-center">아이디 찾기</h2>
        <form action="searchId.do" method="post" id="changePwForm">
            <input type="hidden" name="page" value="${param.page}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">
            
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


            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">아이디 찾기</button>
                <button type="reset" class="btn btn-outline-warning">새로입력</button>
                <button type="button" class="cancelBtn btn btn-link text-secondary text-decoration-none">취소</button>
            </div>
        </form>
    </div>
</body>
</html>