<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark fixed-top">
	<div class="container-fluid">
		<a class="navbar-brand" href="/">Webjjang Co.</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#mynavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="mynavbar">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" href="/notice/list.do">공지사항</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/shop/list.do">쇼핑몰</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/board/list.do">일반게시판</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/qna/list.do">질문답변</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="/image/list.do">이미지</a>
				</li>
				<c:if test="${!empty login && login.gradeNo == 9 }">
					<!-- 관리자 메뉴 -->
					<li class="nav-item"><a class="nav-link"
						href="/member/list.do">회원관리</a></li>
				</c:if>
			</ul>
			<ul class="navbar-nav d-flex justify-content-end">
				<!-- empty는 객체가 null이거나 length나 size가 0인 상태 -->
				<c:if test="${empty login }">
					<!-- 로그인을 하지 않았을 때 메뉴 시작 -->
					<li class="nav-item"><a class="nav-link"
						href="/member/loginForm.do">로그인</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/writeForm.do">회원가입</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/searchIdForm.do">아이디찾기</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/searchPwForm.do">비밀번호찾기</a></li>
					<!-- 로그인을 하지 않았을 때 메뉴 끝 -->
				</c:if>
				<!-- empty는 객체가 null이거나 length나 size가 0인 상태 -->
				<c:if test="${!empty login }">
					<!-- 로그인을 한 경우의 메뉴 시작 -->
					<li class="nav-item"><a class="nav-link"
						href="/member/view.do">${login.name }(${login.gradeName })</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/logout.do">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/searchIdForm.do">비밀번호 변경</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/searchPwForm.do">회원 탈퇴</a></li>
					<!-- 로그인을 한 경우의 메뉴 끝 -->
				</c:if>
			</ul>
		</div>
	</div>
</nav>
