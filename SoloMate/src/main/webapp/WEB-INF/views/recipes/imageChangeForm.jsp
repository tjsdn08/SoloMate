<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="container mt-5">
    <div class="card p-3 mb-4 shadow-sm">
        <h4 class="text-center m-0">대표 이미지 변경</h4>
    </div>

    <form action="imageChange.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="no" value="${vo.recipes_no}">
        <input type="hidden" name="old_img" value="${vo.recipes_img}">
        <input type="hidden" name="perPageNum" value="${param.perPageNum}">

        <div class="row">
            <div class="col-md-6 text-center border-end">
                <p class="fw-bold">현재 이미지</p>
                <img src="${vo.recipes_img}" class="img-thumbnail" style="max-height: 300px;">
            </div>
            <div class="col-md-6 text-center">
                <p class="fw-bold">변경할 이미지 선택</p>
                <input type="file" name="imageFile" class="form-control mb-3" accept="image/*" required>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-dark">이미지 변경하기</button>
                    <button type="button" class="btn btn-outline-secondary" onclick="history.back()">취소</button>
                </div>
            </div>
        </div>
    </form>
</div>