<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark fixed-top">
	<div class="container-fluid">
		<a class="navbar-brand" href="/">SoloMate Co.</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#mynavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="mynavbar">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" href="/food/list.do">식품
						관리</a></li>
				<li class="nav-item"><a class="nav-link" href="/folder/list.do">식품
						폴더 관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/shopping/list.do">장보기 계획</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/hotdeal/list.do">핫딜 상품</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/account/list.do">가계부</a></li>
				<li class="nav-item"><a class="nav-link"
					href="/recipes/list.do">레시피 아카이브</a></li>
				<li class="nav-item"><a class="nav-link" href="/board/list.do">꿀팁
						아카이브</a></li>

				<c:if test="${!empty login && login.gradeNo == 9 }">
					<!-- 관리자 메뉴 -->
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/adminHotDeal/list.do">핫딜
							관리</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/adminCategory/list.do">카테고리
							관리</a></li>
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
						href="/member/view.do?id=${login.id}">
							${login.name}(${login.gradeName}) </a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/logout.do">로그아웃</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/changePw.do">비밀번호 변경</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/deleteForm.do">회원 탈퇴</a></li>
					<!-- 로그인을 한 경우의 메뉴 끝 -->
				</c:if>
			</ul>
		</div>
	</div>
</nav>
