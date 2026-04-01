<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 상세보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	.data-block {
		border: 1px solid #ddd;
		margin-bottom: 20px;
		background-color: #fff;
	}
	.label-col {
		background-color: #f8f9fa;
		font-weight: bold;
		text-align: center;
		vertical-align: middle;
		border-right: 1px solid #ddd;
	}
	.value-col {
		padding: 10px 15px;
		vertical-align: middle;
	}
	.recipes-content {
		white-space: pre-wrap;
		padding: 20px;
		min-height: 300px;
	}
	.recipe-img-container {
		text-align: center;
		padding: 20px;
	}
	.recipe-img {
		max-width: 100%;
		height: auto;
		border-radius: 8px;
	}
</style>
</head>
<body>

<div class="container mt-5 mb-5">
    <div class="card p-3 mb-4 shadow-sm">
        <h2 class="text-center m-0">레시피 상세보기</h2>
    </div>

    <div class="card shadow-sm mb-4">
        <div class="row m-0 border-bottom">
            <div class="col-md-1 label-col p-2">등록 번호</div>
            <div class="col-md-1 value-col text-center">${vo.recipes_no}</div>
            
            <div class="col-md-2 label-col p-2">레시피 이름</div>
            <div class="col-md-2 value-col fw-bold text-success">${vo.recipes_title}</div>
            
            <div class="col-md-1 label-col p-2">작성자</div>
            <div class="col-md-2 value-col">${vo.name}</div>
            
            <div class="col-md-1 label-col p-2">날짜</div>
            <div class="col-md-1 value-col text-center text-muted">${vo.date}</div>
            
            <div class="col-md-1 label-col p-2">북마크 수</div>
            <div class="col-md-1 value-col text-center">
                <span class="badge bg-danger rounded-pill">${vo.recipes_bookmark}</span>
            </div>
        </div>
        <div class="row m-0">
            <div class="col-md-2 label-col p-2">핵심 재료 3가지</div>
            <div class="col-md-5 value-col text-muted">${vo.food}</div>
            
            <div class="col-md-1 label-col p-2">조리 시간</div>
            <div class="col-md-2 value-col text-center">${vo.recipes_time} 분</div>
            
            <div class="col-md-1 label-col p-2">난이도</div>
            <div class="col-md-1 value-col text-center">${vo.recipes_level}</div>
        </div>
    </div>

    <div class="card p-3 mb-4 shadow-sm bg-light">
        <div class="d-flex align-items-center">
            <span class="fw-bold me-3">D8: 레시피 한줄 설명</span>
            <span class="fs-5 text-secondary">${vo.description}</span>
        </div>
    </div>

    <div class="data-block shadow-sm">
        <div class="row m-0">
            <div class="col-md-8 p-0 recipes-content border-end">
                <h4 class="fw-bold mb-3 border-bottom pb-2">상세 내용</h4>
                ${vo.recipes_content}
            </div>
            
            <div class="col-md-4 p-0">
                <div class="recipe-img-container">
                    <h5 class="text-center mb-3">D12: 대표 이미지</h5>
                    <c:choose>
                        <c:when test="${not empty vo.recipes_imgs}">
                            <img src="${vo.recipes_imgs}" class="recipe-img img-thumbnail" alt="레시피 이미지">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/300x200?text=No+Image" class="recipe-img img-thumbnail" alt="이미지 없음">
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="mt-3 text-center">
                        <a href="imageChange.do?no=${vo.recipes_no}" class="btn btn-sm btn-outline-secondary">L3: 변경</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-end gap-2 mt-4">
        <button type="button" class="btn btn-danger" onclick="confirmDelete()">삭제 (D13/L1)</button>
        
        <a href="recipeUpdate.do?no=${vo.recipes_no}" class="btn btn-dark">수정 (L4)</a>
        
        <a href="list.do?${pageObject.pageQuery}" class="btn btn-outline-dark">리스트 (L2)</a>
    </div>
</div>

<script type="text/javascript">
	function confirmDelete() {
		if(confirm("정말로 이 레시피를 삭제하시겠습니까?")) {
			location.href = "delete.do?no=${vo.recipes_no}";
		}
	}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>