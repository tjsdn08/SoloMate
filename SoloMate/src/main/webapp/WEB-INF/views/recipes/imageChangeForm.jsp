<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대표 이미지 변경</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
.admin-page {
    padding: 30px;
    min-height: 100vh;
}

.admin-card {
    background: #fff;
    border-radius: 18px;
    padding: 35px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    max-width: 900px;
    margin: 0 auto;
}

.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    border-bottom: 2px solid #f8f9fc;
    padding-bottom: 20px;
}

.top-title {
    font-size: 24px;
    font-weight: 800;
    color: #111;
}

/* 이미지 박스 스타일 */
.image-box {
    padding: 20px;
    background: #f8f9fc;
    border-radius: 15px;
    text-align: center;
    height: 100%;
}

.image-label {
    display: block;
    font-size: 14px;
    font-weight: 700;
    color: #6b7280;
    margin-bottom: 15px;
}

.recipe-img-preview {
    max-width: 100%;
    max-height: 350px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    object-fit: cover;
}

/* 폼 요소 스타일 */
.form-control-custom {
    height: 50px;
    border: 1px solid #ddd;
    border-radius: 12px;
    padding: 10px 15px;
    font-size: 15px;
}

/* 버튼 스타일 (기존 테마 이식) */
.btn-main, .btn-sub {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 50px;
    padding: 0 24px;
    border-radius: 12px;
    border: none;
    font-size: 15px;
    font-weight: 700;
    text-decoration: none;
    cursor: pointer;
    transition: 0.2s;
}

.btn-main { background: #111827; color: #fff; }
.btn-sub { background: #eef0f4; color: #333; }

.btn-main:hover { background: #1f2937; color: #fff; }
.btn-sub:hover { background: #e5e7eb; color: #333; }

.btn-group-custom {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
    margin-top: 20px;
}
</style>
</head>
<body>

<div class="admin-page">
    <div class="admin-card">
        
        <div class="top-bar">
            <div class="top-title">📸 대표 이미지 변경</div>
            <span class="text-muted" style="font-size: 14px;">글 번호: ${vo.recipes_no}</span>
        </div>

        <form action="imageChange.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="no" value="${vo.recipes_no}">
            <input type="hidden" name="old_img" value="${vo.recipes_img}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">

            <div class="row g-4">
                <div class="col-md-6">
                    <div class="image-box">
                        <span class="image-label">현재 등록된 이미지</span>
                        <c:choose>
                            <c:when test="${not empty vo.recipes_img}">
                                <img src="${vo.recipes_img}" class="recipe-img-preview">
                            </c:when>
                            <c:otherwise>
                                <img src="https://via.placeholder.com/400x300?text=No+Image" class="recipe-img-preview">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="image-box d-flex flex-column justify-content-center">
                        <span class="image-label">새로운 이미지 선택</span>
                        
                        <input type="file" name="imageFile" class="form-control form-control-custom mb-3" 
                               accept="image/*" required>
                        
                        <p class="text-muted mb-4" style="font-size: 13px;">
                            * JPG, PNG, GIF 파일만 업로드 가능합니다.<br>
                            * 변경 시 기존 이미지는 서버에서 삭제됩니다.
                        </p>

                        <div class="btn-group-custom">
                            <button type="submit" class="btn-main">이미지 변경하기</button>
                            <button type="button" class="btn-sub" onclick="history.back()">취소</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </div>
</div>

</body>
</html>