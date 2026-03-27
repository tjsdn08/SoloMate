<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장보기 수정</title>

<style>
.write-wrapper { max-width: 820px; margin: 40px auto; }
.write-card { background:#fff; border-radius:20px; box-shadow:0 4px 16px rgba(0,0,0,0.08); overflow:hidden; }
.write-header { display:flex; justify-content:space-between; align-items:center; padding:24px 30px; border-bottom:1px solid #eee; }
.write-title { font-size:28px; font-weight:700; }
.write-body { padding:30px; }
.form-label-custom { font-weight:700; margin-bottom:8px; color:#555; }
.form-control-custom, .form-select-custom {
	width:100%; height:50px; border-radius:12px; border:1px solid #ddd; padding:0 14px;
}
.form-textarea-custom {
	width:100%; min-height:120px; border-radius:12px; border:1px solid #ddd; padding:14px;
}
.form-grid { display:grid; grid-template-columns:1fr 1fr; gap:20px; margin-bottom:20px; }
.form-row-full { margin-bottom:20px; }
.write-footer { display:flex; justify-content:space-between; padding:24px 30px; background:#fafafa; border-top:1px solid #eee; }
.btn-custom { padding:12px 20px; border-radius:12px; font-weight:700; border:none; cursor:pointer; text-decoration:none; }
.btn-submit { background:#5b67f1; color:#fff; }
.btn-cancel { background:#eee; color:#333; }
</style>
</head>
<body>

<div class="write-wrapper">
	<div class="write-card">
		<div class="write-header">
			<div class="write-title">장보기 수정</div>
		</div>

		<form action="${pageContext.request.contextPath}/shopping/update.do" method="post">

			<input type="hidden" name="shoppingId" value="${vo.shoppingId}">

			<div class="write-body">

				<div class="form-row-full">
					<div class="form-label-custom">품목명</div>
					<input type="text" name="itemName" class="form-control-custom"
						value="${vo.itemName}" required>
				</div>

				<div class="form-grid">
					<div>
						<div class="form-label-custom">수량</div>
						<input type="number" name="quantity" class="form-control-custom"
							value="${vo.quantity}" min="1" required>
					</div>

					<div>
						<div class="form-label-custom">예상금액</div>
						<input type="number" name="expectedPrice" class="form-control-custom"
							value="${vo.expectedPrice}" min="0" required>
					</div>
				</div>

				<div class="form-grid">
					<div>
						<div class="form-label-custom">구매예정일</div>
						<input type="date" name="planDate" class="form-control-custom"
							value="${vo.planDate}" required>
					</div>

					<div>
						<div class="form-label-custom">상태</div>
						<select name="status" class="form-select-custom">
							<option value="PLANNED" ${vo.status eq 'PLANNED' ? 'selected' : ''}>구매예정</option>
							<option value="PURCHASED" ${vo.status eq 'PURCHASED' ? 'selected' : ''}>구매완료</option>
							<option value="CANCELED" ${vo.status eq 'CANCELED' ? 'selected' : ''}>취소</option>
						</select>
					</div>
				</div>

				<div class="form-row-full">
					<div class="form-label-custom">메모</div>
					<textarea name="memo" class="form-textarea-custom">${vo.memo}</textarea>
				</div>

			</div>

			<div class="write-footer">
				<a href="${pageContext.request.contextPath}/shopping/view.do?shoppingId=${vo.shoppingId}"
				   class="btn-custom btn-cancel">취소</a>

				<button type="submit" class="btn-custom btn-submit">수정</button>
			</div>

		</form>
	</div>
</div>

</body>
</html>