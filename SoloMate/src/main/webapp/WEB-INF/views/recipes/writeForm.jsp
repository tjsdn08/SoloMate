<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
	.label-col { background-color: #f8f9fa; font-weight: bold; display: flex; align-items: center; justify-content: center; border-right: 1px solid #ddd; }
	.input-group-text { background-color: #f8f9fa; font-weight: bold; }
	.preview-img { max-width: 100%; max-height: 300px; border-radius: 8px; display: none; }
</style>
<script type="text/javascript">
$(function(){
	// 이미지 미리보기 로직
	$("#imageInput").change(function(){
		if (this.files && this.files[0]) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$("#preview").attr("src", e.target.result).show();
				$("#noImageText").hide();
			}
			reader.readAsDataURL(this.files[0]);
		}
	});

	// 취소 버튼
	$("#cancelBtn").click(function(){
		if(confirm("작성을 취소하고 리스트로 돌아가시겠습니까?")) {
			location.href = "list.do";
		}
	});
});
</script>
</head>
<body>

<div class="container mt-5 mb-5">
    <div class="card p-3 mb-4 shadow-sm">
        <h2 class="text-center m-0">새 레시피 등록</h2>
    </div>

    <form action="write.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${login.id}">

        <div class="card shadow-sm mb-4">
            <div class="card-body p-0">
                <div class="row m-0 border-bottom">
                    <div class="col-md-2 label-col p-3">레시피 제목</div>
                    <div class="col-md-10 p-2">
                        <input type="text" name="recipes_title" class="form-control" placeholder="예: 매콤 달콤 떡볶이" required>
                    </div>
                </div>

                <div class="row m-0 border-bottom">
                    <div class="col-md-2 label-col p-3">한줄 설명</div>
                    <div class="col-md-10 p-2">
                        <input type="text" name="description" class="form-control" placeholder="레시피를 한 줄로 짧게 소개해 주세요." required>
                    </div>
                </div>

                <div class="row m-0 border-bottom">
                    <div class="col-md-2 label-col p-3">주재료</div>
                    <div class="col-md-4 p-2">
                        <input type="text" name="food" class="form-control" placeholder="예: 떡볶이떡, 고추장, 어묵" required>
                    </div>
                    <div class="col-md-1 label-col p-3">시간</div>
                    <div class="col-md-2 p-2">
                        <div class="input-group">
                            <input type="number" name="recipes_time" class="form-control" min="1" required>
                            <span class="input-group-text">분</span>
                        </div>
                    </div>
                    <div class="col-md-1 label-col p-3">난이도</div>
                    <div class="col-md-2 p-2">
                        <select name="recipes_level" class="form-select">
                            <option value="초급">초급</option>
                            <option value="중급" selected>중급</option>
                            <option value="고급">고급</option>
                        </select>
                    </div>
                </div>

                <div class="row m-0">
                    <div class="col-md-8 p-4 border-end">
                        <div class="mb-3">
                            <label class="fw-bold mb-2" style="font-size: 1.2rem;">👨‍🍳 레시피 상세 내용</label>
                            <textarea name="recipes_content" class="form-control" rows="15" 
                                placeholder="요리 순서대로 상세히 적어주세요.&#10;1. 재료를 손질합니다.&#10;2. 팬을 달굽니다." required></textarea>
                        </div>
                    </div>
                    
                    <div class="col-md-4 p-4 bg-light text-center">
                        <label class="fw-bold d-block mb-3">대표 이미지 등록</label>
                        <div class="border rounded bg-white p-2 mb-3 d-flex align-items-center justify-content-center" style="min-height: 200px;">
                            <img id="preview" src="#" class="preview-img">
                            <span id="noImageText" class="text-muted">이미지를 선택해주세요</span>
                        </div>
                        <input type="file" name="imageFile" id="imageInput" class="form-control" accept="image/*" required>
                        <p class="text-muted small mt-2">레시피를 대표하는 사진을 올려주세요.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-center gap-3 mt-4">
            <button type="submit" class="btn btn-dark btn-lg px-5">레시피 등록</button>
            <button type="button" id="cancelBtn" class="btn btn-outline-secondary btn-lg px-5">취소</button>
        </div>
    </form>
</div>

</body>
</html>