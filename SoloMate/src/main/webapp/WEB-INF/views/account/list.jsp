<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 리스트</title>

<style type="text/css">
    .dataRow:hover { cursor:pointer; background-color: #f8f9fa !important; }
    .pagination { justify-content: center; }
    
    /* 금액 스타일 */
    .income { color: #007bff; font-weight: bold; } /* 수입: 파란색 */
    .expense { color: #dc3545; font-weight: bold; } /* 지출: 빨간색 */
    
    /* 검색바 정렬 */
    .search-container {
        background-color: #f1f3f5;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 20px;
    }
    
    /* 기본 */
	.pagination .page-link {
	    color: black;
	    border: 1px solid #ddd;
	    border-radius: 8px;
	    margin: 0 3px;
	}
	
	/* hover */
	.pagination .page-link:hover {
	    background-color: black;
	    color: white;
	}
	
	/* 현재 페이지 */
	.pagination .active .page-link {
	    background-color: black;
	    border-color: black;
	    color: white;
	}
</style>

<script type="text/javascript">
    $(function(){
        // 1. 행 클릭 시 상세보기 이동
        $(".dataRow").click(function(){
            let no = $(this).find(".no").text();
            location = "view.do?no=" + no + "&inc=1&${pageObject.pageQuery}";
        });

        // 2. 카테고리 자동 변경 (jQuery 방식 하나만 남김)
        // HTML의 onchange="this.form.submit()"은 삭제하는 것이 좋습니다.
        $("#category").on("change", function() {
            $(this).closest("form").submit();
        });

        // 3. 데이터 유지 (이미 서버사이드 selected 처리를 했으므로 사실상 불필요하지만 안전장치)
        $("#key").val("${pageObject.key}");
        $("#word").val("${pageObject.word}");
        $("#category").val("${pageObject.category}");
    });
</script>

<c:if test="${!empty pageObject.category}">
<script>
    $(function(){
        $("#category").val("${pageObject.category}");
    });
</script>
</c:if>

</head>
<body>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>💸 ${login.name}님의 가계부</h2>
    </div>

    <div class="search-container">
        <form action="list.do" method="get" id="searchForm">
	    <div class="row g-2 justify-content-center align-items-center bg-light p-3 rounded">
	        <input type="hidden" name="perPageNum" value="${pageObject.perPageNum}">
	        
	        <!-- 검색창 -->
            <div class="input-group" style="max-width:500px;">
                <span class="input-group-text bg-white border-end-0">
                    🔍
                </span>
                <input type="text" class="form-control border-start-0"
                       name="word" id="word"
                       placeholder="글 검색"
                       style="height:45px;">
            </div>

            <!-- 검색 조건 -->
            <select class="form-select" name="key" id="key" style="width:120px; height:45px;">
                <option value="tcw">전체</option>
                <option value="t">제목</option>
                <option value="c">내용</option>
            </select>

            <!-- 검색 버튼 -->
            <button class="btn btn-dark" style="width:100px; height:45px;">
                검색
            </button>
	
	        <div class="col-md-2">
	            <select class="form-select" name="category" id="category" onchange="this.form.submit()">
				    <option value="">전체</option>
				    
				    <option value="income" ${pageObject.category == 'income' ? 'selected' : ''} 
				            style="font-weight: bold; color: blue;">[수입 전체보기]</option>
				    <optgroup label="수입 세부항목">
				        <option value="월급" ${pageObject.category == '월급' ? 'selected' : ''}>월급</option>
				        <option value="용돈" ${pageObject.category == '용돈' ? 'selected' : ''}>용돈</option>
				        <option value="수입기타" ${pageObject.category == '수입기타' ? 'selected' : ''}>기타(수입)</option>
				    </optgroup>
				
				    <option value="expense" ${pageObject.category == 'expense' ? 'selected' : ''} 
				            style="font-weight: bold; color: red;">[지출 전체보기]</option>
				    <optgroup label="지출 세부항목">
				        <option value="식비" ${pageObject.category == '식비' ? 'selected' : ''}>식비</option>
				        <option value="교통비" ${pageObject.category == '교통비' ? 'selected' : ''}>교통비</option>
				        <option value="쇼핑" ${pageObject.category == '쇼핑' ? 'selected' : ''}>쇼핑</option>
				        <option value="생활비" ${pageObject.category == '생활비' ? 'selected' : ''}>생활비</option>
				        <option value="문화/여가" ${pageObject.category == '문화/여가' ? 'selected' : ''}>문화/여가</option>
				        <option value="지출기타" ${pageObject.category == '지출기타' ? 'selected' : ''}>기타(지출)</option>
				    </optgroup>
				</select>
	        </div>
	
	    </div>
	</form>

    </div>

    <table class="table table-hover align-middle text-center">
        <thead class="table-light">
            <tr>
			    <th style="width: 80px;">번호</th>
			    <th style="width: 120px;">날짜</th>
			    <th style="width: 100px;">카테고리</th>
			    <th>내역</th>
			    <th style="width: 150px;">금액</th>
			</tr>
        </thead>
        <tbody>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="7" class="py-5 text-muted">등록된 가계부 내역이 없습니다.</td>
                </tr>
            </c:if>
            <c:if test="${!empty list}">
                <c:forEach items="${list}" var="vo">
                    <tr class="dataRow">
                        <td class="no text-muted">${vo.no}</td>
                        <td>${vo.regDate}</td> 
                        <td><span class="badge bg-secondary">${vo.category}</span></td>
                        <td class="text-start text-truncate" style="max-width: 300px;">
                            <strong>${vo.title}</strong>
                        </td>
                        <td class="text-end">
						    <%-- DB의 type 값에 따라 클래스 결정 --%>
						    <span class="${(vo.type == 'income') ? 'income' : 'expense'}">
						        <fmt:formatNumber value="${vo.amount}" pattern="#,###" />원
						    </span>
						</td>
                    </tr>
                </c:forEach>
            </c:if>
        </tbody>
    </table>
    <div class="mt-4">
        <pageNav:pageNav listURI="list.do" pageObject="${pageObject}" />
    </div>
    <div class="d-flex justify-content-end align-items-center mb-3">
	    <div class="col-auto me-2">
	        <a href="writeForm.do?perPageNum=${pageObject.perPageNum}" class="btn btn-dark">
	            내역 기록하기
	        </a>
	    </div>
	    <div class="col-auto">
	        <a href="list.do" class="btn btn-outline-secondary">
	            새로고침
	        </a>
	    </div>
	</div>
</div>

</body>
</html>