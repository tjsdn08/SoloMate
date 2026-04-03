<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
	.label-col { background-color: #f8f9fa; font-weight: bold; text-align: center; vertical-align: middle; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; }
	.value-col { padding: 10px 15px; vertical-align: middle; border-bottom: 1px solid #ddd; }
	.form-control-plaintext { font-weight: bold; padding-left: 10px; }
	.recipes-content-edit { min-height: 400px; line-height: 1.8; }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="container mt-5 mb-5">
    <div class="card p-3 mb-4 shadow-sm">
        <h2 class="text-center m-0">레시피 수정하기</h2>
    </div>

    <form action="update.do" method="post">
        <input type="hidden" name="recipes_no" value="${vo.recipes_no}">
        <input type="hidden" name="perPageNum" value="${param.perPageNum}">

        <div class="card shadow-sm mb-4">
            <div class="row m-0 border-top">
                <div class="col-md-1 label-col p-2">번호</div>
                <div class="col-md-1 value-col text-center">
                    <span class="form-control-plaintext">${vo.recipes_no}</span>
                </div>
                
                <div class="col-md-2 label-col p-2">레시피 이름</div>
                <div class="col-md-5 value-col">
                    <input type="text" name="recipes_title" class="form-control fw-bold text-success" 
                           value="${vo.recipes_title}" required>
                </div>
                
                <div class="col-md-1 label-col p-2">작성자</div>
                <div class="col-md-2 value-col text-center">
                    <span class="form-control-plaintext">${vo.name}</span>
                </div>
            </div>
            
            <div class="row m-0">
                <div class="col-md-2 label-col p-2">재료</div>
                <div class="col-md-4 value-col">
                    <input type="text" name="food" class="form-control" value="${vo.food}" 
                           placeholder="재료를 쉼표(,)로 구분하여 입력" required>
                </div>
                <div class="col-md-1 label-col p-2">시간</div>
                <div class="col-md-2 value-col">
                    <div class="input-group">
                        <input type="number" name="recipes_time" class="form-control text-center" 
                               value="${vo.recipes_time}" min="1" required>
                        <span class="input-group-text">분</span>
                    </div>
                </div>
                <div class="col-md-1 label-col p-2">난이도</div>
                <div class="col-md-2 value-col">
                    <select name="recipes_level" class="form-select">
                        <option value="초급" ${vo.recipes_level == '초급' ? 'selected' : ''}>초급</option>
                        <option value="중급" ${vo.recipes_level == '중급' ? 'selected' : ''}>중급</option>
                        <option value="고급" ${vo.recipes_level == '고급' ? 'selected' : ''}>고급</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="card p-3 mb-4 shadow-sm bg-light">
            <div class="d-flex align-items-center">
                <span class="fw-bold me-3" style="white-space: nowrap;">레시피 한줄 설명</span>
                <input type="text" name="description" class="form-control" value="${vo.description}" required>
            </div>
        </div>

        <div class="card p-4 mb-4 shadow-sm">
            <div class="d-flex align-items-center mb-3">
                <span class="fw-bold me-3" style="font-size: 1.2rem;">👨‍🍳 레시피 상세 내용 수정</span>
            </div>
            <textarea name="recipes_content" class="form-control recipes-content-edit fs-5 text-secondary" 
                      style="white-space: pre-wrap;" required>${vo.recipes_content}</textarea>
        </div>

        <div class="d-flex justify-content-end gap-2 mt-4">
            <button type="submit" class="btn btn-dark px-4">수정 완료</button>
            <button type="button" class="btn btn-outline-dark px-4" onclick="history.back();">취소</button>
        </div>
    </form>
</div>

</body>
</html>