<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">
.admin-page {
    padding: 30px;
    min-height: 100vh;
}

.admin-card {
    background: #fff;
    border-radius: 18px;
    padding: 30px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
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
    font-size: 28px;
    font-weight: 800;
    color: #111;
}

/* 수정 폼 그리드 레이아웃 */
.info-section {
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 번호, 이름, 작성자 */
    gap: 20px;
    margin-bottom: 25px;
}

.info-item {
    padding: 15px;
    background: #f8f9fc;
    border-radius: 12px;
}

.info-label {
    font-size: 13px;
    font-weight: 700;
    color: #6b7280;
    margin-bottom: 8px;
    display: block;
}

/* 입력 요소 스타일 */
.form-control-custom {
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 10px 15px;
    font-size: 15px;
    font-weight: 600;
    width: 100%;
    transition: all 0.2s;
}

.form-control-custom:focus {
    border-color: #111827;
    outline: none;
    box-shadow: 0 0 0 3px rgba(17, 24, 39, 0.05);
}

/* 읽기 전용 텍스트 스타일 */
.readonly-text {
    font-size: 16px;
    font-weight: 700;
    color: #4b5563;
    padding: 10px 0;
    display: block;
}

/* 섹션별 포인트 컬러 */
.ingredient-box { background: #f0fdf4; } /* 초록색 포인트 (재료) */
.tip-box { background: #fdf2f2; border-left: 5px solid #c62828; } /* 빨간색 포인트 (한줄팁) */

/* 본문 에디터 스타일 */
.recipes-content-edit {
    width: 100%;
    min-height: 450px;
    border: 1px solid #ddd;
    border-radius: 12px;
    padding: 20px;
    font-size: 16px;
    line-height: 1.8;
    color: #374151;
    resize: vertical;
}

/* 버튼 스타일 (기존 테마 이식) */
.btn-main, .btn-sub {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 50px;
    padding: 0 30px;
    border-radius: 12px;
    border: none;
    font-size: 16px;
    font-weight: 700;
    text-decoration: none;
    cursor: pointer;
    transition: 0.2s;
}

.btn-main { background: #111827; color: #fff; }
.btn-sub { background: #eef0f4; color: #333; }

.btn-main:hover { background: #1f2937; color: #fff; }
.btn-sub:hover { background: #e5e7eb; color: #333; }

.input-group-text-custom {
    background: transparent;
    border: none;
    font-weight: 700;
    color: #4b5563;
}
</style>
</head>
<body>

<div class="admin-page">
    <div class="admin-card">
        
        <div class="top-bar">
            <div class="top-title">👨‍🍳 레시피 수정하기</div>
            <span class="text-muted">상세 내용을 자유롭게 수정하세요.</span>
        </div>

        <form action="update.do" method="post">
            <input type="hidden" name="recipes_no" value="${vo.recipes_no}">
            <input type="hidden" name="perPageNum" value="${param.perPageNum}">

            <div class="info-section">
                <div class="info-item">
                    <span class="info-label">레시피 번호</span>
                    <span class="readonly-text">${vo.recipes_no}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">레시피 이름</span>
                    <input type="text" name="recipes_title" class="form-control-custom text-success" 
                           value="${vo.recipes_title}" required>
                </div>
                <div class="info-item">
                    <span class="info-label">작성자</span>
                    <span class="readonly-text">${vo.name}</span>
                </div>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <div class="info-item ingredient-box h-100">
                        <span class="info-label" style="color: #166534;">필요한 재료</span>
                        <input type="text" name="food" class="form-control-custom" 
                               value="${vo.food}" placeholder="예: 소고기 300g, 소금, 후추" required>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="info-item h-100">
                        <span class="info-label">조리 시간</span>
                        <div class="input-group align-items-center">
                            <input type="number" name="recipes_time" class="form-control-custom text-center" 
                                   value="${vo.recipes_time}" min="1" required style="width: 70%;">
                            <span class="input-group-text-custom ps-2">분</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="info-item h-100">
                        <span class="info-label">난이도 설정</span>
                        <select name="recipes_level" class="form-select form-control-custom" style="height: 46px;">
                            <option value="초급" ${vo.recipes_level == '초급' ? 'selected' : ''}>초급</option>
                            <option value="중급" ${vo.recipes_level == '중급' ? 'selected' : ''}>중급</option>
                            <option value="고급" ${vo.recipes_level == '고급' ? 'selected' : ''}>고급</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="info-item tip-box mb-4">
                <span class="info-label" style="color: #c62828;">레시피 한줄 설명 수정</span>
                <input type="text" name="description" class="form-control-custom" 
                       value="${vo.description}" style="background: transparent; border: none; padding-left: 0; font-size: 18px;" required>
            </div>

            <div class="mb-4">
                <h5 class="fw-bold mb-3">👨‍🍳 상세 조리 순서 수정</h5>
                <textarea name="recipes_content" class="recipes-content-edit" required>${vo.recipes_content}</textarea>
            </div>

            <div class="d-flex justify-content-end gap-2 mt-5 pt-4 border-top">
                <button type="submit" class="btn-main">수정 완료</button>
                <button type="button" class="btn-sub" onclick="history.back();">수정 취소</button>
            </div>
        </form>

    </div> 
</div>

</body>
</html>