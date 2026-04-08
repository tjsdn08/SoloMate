<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식품 폴더 목록 보기</title>
<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<!-- 스타일 -->
<style type="text/css">
	.custom-card {
      background: white;
      border-radius: 15px;
      border: none;
      padding: 30px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
      margin-top: 30px;
	}
	.card .icon {
		color: #0d6efd;
		font-size: 3em;
	}
	.card .card-text {
		color: grey;
	}
	.card:hover {
	  background-color: #212529;
	  color: #ffffff;
	  cursor: pointer;
	}	
	.card:hover .icon, 
	.card:hover .card-text {
	  color: #ffffff;
	}

</style>

<!-- key, word 초기화 -->
<c:if test="${!empty pageObject.key && !empty pageObject.word }">
	<script type="text/javascript">
		$(function() {
			$("#key").val("${pageObject.key}");
			$("#word").val("${pageObject.word}");
		});
	</script>

</c:if>

<!-- 클릭 이동 -->
<script type="text/javascript">
	$(function(){
		$(".card").click(function(){
			let no = $(this).data("no");
			location = "view.do?no=" + no;
		})
	});
</script>

</head>
<body class="bg-light">

<div class="custom-card">

    <h2 class="mb-4">식품 폴더 목록 보기</h2>
    	<c:if test="${empty login }">
		<h3>로그인 해주세요</h3>
	</c:if>
    
    	<!-- 검색란 처리 --------------------------------------------------->
	<div class="mb-3">
		<form action="list.do" method="get">
			<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
			
			<div class="d-inline-flex">
				<!-- 넘어오는 검색 정보는 JavaScript로 처리하겠다. -->
				<div class="input-group mb-3">
				
				  <input type="text" class="form-control" placeholder="폴더명 검색"
				   value="${param.word }" name="word" id="word">
				   
				  <button class="btn btn-dark" type="submit">검색</button>
				  
				</div>
			</div>
					
		</form>
	</div>
	<!-- 검색란 처리 끝 ---------------------------------------------------->
    

    <div class="row row-cols-1 row-cols-md-4 g-4">
        <!-- 4열 → 총 4개 (페이지 기준) -->

        <c:forEach var="folder" items="${list}">
            <div class="col">

                <div class="card shadow-sm h-100 text-center" data-no="${folder.no }">

                    <div class="card-body">
                        <!-- 아이콘 -->
                        <div class="icon">
                        		<i class="bi bi-folder-fill"></i>
                        </div>
                        <!-- 폴더명 -->
                        <h5 class="card-title text-truncate">
                            ${folder.name}
                        </h5>
                        <!-- 생성일 -->
                        <p class="card-text">
                            생성일: ${folder.createdAt}
                        </p>
                    </div>

                </div>

            </div>
        </c:forEach>

    </div>
    
    <div class="d-flex justify-content-between mb-3 mt-4">
    
	    	<div>
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
		</div>
		
		<!-- 권한 처리 전 임시 방편 -->
		<c:if test="${!empty login && pageObject.accepter == login.id }">
			<div>
				<a href="writeForm.do?perPageNum=${param.perPageNum }" class="btn btn-dark">폴더 등록</a>
				<a href="list.do" class="btn btn-dark">새로고침</a>
			</div>
		</c:if>
	
	</div>
</div>
</body>
</html>