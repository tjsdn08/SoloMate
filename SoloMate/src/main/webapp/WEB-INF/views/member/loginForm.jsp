<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .login-box { max-width: 450px; margin: 100px auto; }
</style>
</head>
<body class="bg-light">

<div class="container login-box shadow p-4 bg-white rounded-4">
    <h2 class="text-center mb-4 fw-bold">로그인</h2>
    
    <form action="login.do" method="post">
        <div class="mb-3 mt-3">
            <label for="id" class="form-label text-secondary">아이디</label>
            <input type="text" class="form-control" id="id" placeholder="아이디 입력" name="id"
                   required autocomplete="off" maxlength="20" autofocus>
        </div>
        
        <div class="mb-3">
            <label for="pw" class="form-label text-secondary">비밀번호</label>
            <input type="password" class="form-control" id="pw" placeholder="비밀번호 입력" name="pw"
                   required maxlength="20">
        </div>

        <div class="d-grid mb-3">
            <button type="submit" class="btn btn-primary btn-lg fw-bold">로그인</button>
        </div>

        <div class="d-flex justify-content-between gap-2">
            <a href="searchIdForm.do" class="btn btn-outline-info flex-fill">아이디 찾기</a>
            <a href="searchPwForm.do" class="btn btn-outline-warning flex-fill">비밀번호 찾기</a>
        </div>
        
        <div class="text-center mt-4">
            <small class="text-muted">계정이 없으신가요? <a href="writeForm.do" class="text-decoration-none">회원가입</a></small>
        </div>
    </form>
</div>

</body>
</html>