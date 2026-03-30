<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<h2>로그인</h2>
<form action="login.do" method="post">
  <div class="mb-3 mt-3">
    <label for="id" class="form-label">아이디</label>
    <input type="text" class="form-control" id="id" placeholder="아이디 입력" name="id"
     required autocomplete="off" maxlength="20" autofocus>
  </div>
  <div class="mb-3">
    <label for="pw" class="form-label">비밀번호</label>
    <input type="password" class="form-control" id="pw" placeholder="비밀번호 입력" name="pw"
     required maxlength="20">
  </div>
  <button type="submit" class="btn btn-primary">로그인</button>
</form>
</body>
</html>