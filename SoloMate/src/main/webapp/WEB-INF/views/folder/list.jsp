<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식품 폴더 목록 보기</title>
</head>
<body class="bg-light">



    <h2 class="mb-4">식품 폴더 목록 보기</h2>
    
    	<!-- 검색란 처리 ---------------수정해야된다.!!------------------------------------->
	<div>
		<form action="list.do" method="get">
			<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
			
			<div class="d-inline-flex">
				<!-- 넘어오는 검색 정보는 JavaScript로 처리하겠다. -->
				  <select class="form-select" name="key" id="key">
				  	<option value="fn">폴더명</option>
				  </select>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Some text"
				   name="word" id="word">
				  <button class="btn btn-success" type="submit">검색</button>
				</div>
			</div>
					
		</form>
	</div>
	<!-- 검색란 처리 끝 ---------------------------------------------------->
    

    <div class="row row-cols-1 row-cols-md-2 g-4">
        <!-- 2열 → 총 4개 (페이지 기준) -->

        <c:forEach var="folder" items="${list}">
            <div class="col">

                <div class="card shadow-sm h-100">

                    <div class="card-body">

                        <!-- 폴더명 -->
                        <h5 class="card-title text-truncate">
                            ${folder.name}
                        </h5>

                        <!-- 생성일 -->
                        <p class="card-text text-muted">
                            생성일: ${folder.createdAt}
                        </p>

                        <!-- 버튼 -->
                        <a href="view.do?no=${folder.no}" 
                           class="btn btn-primary btn-sm">
                           상세보기
                        </a>

                    </div>

                </div>

            </div>
        </c:forEach>

    </div>
    	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
	</div>

	<a href="writeForm.do?perPageNum=${param.perPageNum }" class="btn btn-primary">폴더 등록</a>
	<a href="list.do" class="btn btn-success">새로고침</a>


</body>
</html>