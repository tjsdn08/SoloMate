<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 레시피 등록</title>
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
    padding: 35px;
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

/* 입력 섹션 스타일 */
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

/* 커스텀 입력 요소 */
.form-control-custom {
    border: 1px solid #ddd;
    border-radius: 10px;
    padding: 12px 15px;
    font-size: 15px;
    width: 100%;
    transition: all 0.2s;
}

.form-control-custom:focus {
    border-color: #111827;
    outline: none;
    box-shadow: 0 0 0 3px rgba(17, 24, 39, 0.05);
}

/* 포인트 컬러 섹션 */
.ingredient-box { background: #f0fdf4; } /* 초록색 포인트 (재료) */
.tip-box { background: #fdf2f2; border-left: 5px solid #c62828; } /* 빨간색 포인트 (한줄설명) */

/* 본문 및 이미지 레이아웃 */
.content-layout {
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 30px;
}

.recipes-content-area {
    width: 100%;
    min-height: 500px;
    border: 1px solid #ddd;
    border-radius: 15px;
    padding: 20px;
    font-size: 16px;
    line-height: 1.8;
    resize: vertical;
}

/* 이미지 업로드/미리보기 */
.upload-zone {
    text-align: center;
    background: #f8f9fc;
    border-radius: 15px;
    padding: 25px;
}

.preview-img {
    width: 100%;
    max-height: 350px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    display: none;
    object-fit: cover;
    margin-bottom: 15px;
}

.no-image-text {
    width: 100%;
    height: 250px;
    background: #fff;
    border: 2px dashed #ddd;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #999;
    margin-bottom: 15px;
}

/* 버튼 스타일 (프로젝트 테마) */
.btn-main, .btn-sub {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 52px;
    padding: 0 40px;
    border-radius: 12px;
    border: none;
    font-size: 16px;
    font-weight: 700;
    transition: 0.2s;
}

.btn-main { background: #111827; color: #fff; }
.btn-sub { background: #eef0f4; color: #333; }

.btn-main:hover { background: #1f2937; color: #fff; }
.btn-sub:hover { background: #e5e7eb; color: #333; }
</style>

<script type="text/javascript">
$(function(){
	// [기존 로직 유지] 이미지 미리보기
	$("#imageInput").change(function(){
		if (this.files && this.files[0]) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$("#preview").attr("src", e.target.result).fadeIn();
				$("#noImageText").hide();
			}
			reader.readAsDataURL(this.files[0]);
		}
	});

	// [기존 로직 유지] 취소 버튼 확인창
	$("#cancelBtn").click(function(){
		if(confirm("작성을 취소하고 리스트로 돌아가시겠습니까?")) {
			location.href = "list.do";
		}
	});
});
</script>
</head>
<body>

<div class="admin-page">
    <div class="admin-card">
        
        <div class="top-bar">
            <div class="top-title">🍳 나만의 레시피 등록</div>
            <span class="text-muted">함께 나누고 싶은 맛있는 레시피를 공유해주세요.</span>
        </div>

        <form action="write.do" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${login.id}">

            <div class="info-item mb-4">
                <span class="info-label">레시피 제목</span>
                <input type="text" name="recipes_title" class="form-control-custom fw-bold" 
                       placeholder="예: 육즙 가득 수제 햄버거 만들기" required>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-md-6">
                    <div class="info-item ingredient-box h-100">
                        <span class="info-label" style="color: #166534;">필요한 재료 (쉼표로 구분)</span>
                        <input type="text" name="food" class="form-control-custom" 
                               placeholder="예: 소고기 패티, 번, 양상추, 치즈" required>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="info-item h-100">
                        <span class="info-label">소요 시간</span>
						<div class="d-flex align-items-center">
						    <input type="number" name="recipes_time" class="form-control-custom text-center" 
						           min="1" required style="width: 70%;">
						    <span class="ps-2 fw-bold text-muted">분</span>
						</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="info-item h-100">
                        <span class="info-label">난이도</span>
                        <select name="recipes_level" class="form-select form-control-custom" style="height: 48px;">
                            <option value="초급">초급</option>
                            <option value="중급" selected>중급</option>
                            <option value="고급">고급</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="info-item tip-box mb-4">
                <span class="info-label" style="color: #c62828;">레시피 한줄 설명</span>
                <input type="text" name="description" class="form-control-custom" 
                       placeholder="레시피를 대표하는 짧고 매력적인 문장을 적어주세요." required 
                       style="background: transparent; border: none; padding-left: 0; font-size: 18px;">
            </div>

            <div class="content-layout">
                <div>
                    <h5 class="fw-bold mb-3">👨‍🍳 조리 순서 기술</h5>
                    <textarea name="recipes_content" class="recipes-content-area" 
                              placeholder="요리 순서를 상세히 적어주세요.&#10;1. 재료를 깨끗이 씻어 손질합니다.&#10;2. 중불에 팬을 달구고 식용유를 두릅니다." required></textarea>
                </div>
                
                <div class="upload-zone">
                    <h5 class="fw-bold mb-3">대표 이미지 등록</h5>
                    <div id="noImageText" class="no-image-text">
                        <span>📷 사진을 선택하세요</span>
                    </div>
                    <img id="preview" src="#" class="preview-img">
                    
                    <input type="file" name="imageFile" id="imageInput" 
                           class="form-control form-control-custom" accept="image/*" required>
                    <p class="text-muted small mt-3">요리 완성 사진을 등록하면<br>북마크 확률이 올라가요!</p>
                </div>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-5 pt-4 border-top">
                <button type="submit" class="btn-main">레시피 등록하기</button>
                <button type="button" id="cancelBtn" class="btn-sub">작성 취소</button>
            </div>
        </form>

    </div> 
</div>

</body>
</html>