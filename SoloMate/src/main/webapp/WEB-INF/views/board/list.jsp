<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>꿀팁 아카이브 리스트</title>

<style type="text/css">
	.dataRow:hover {
		cursor:pointer;
	}
	.pagination {
	    justify-content: center;
	}
	
	/* 기본 버튼 */
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
	
	.custom-card {
        background: white;
        border-radius: 15px; /* 모서리 둥글게 */
        border: none;
        padding: 30px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); /* 은은한 그림자 */
        margin-top: 30px;
        margin-bottom: 50px;
    }
    .top-title {
		font-size: 28px;
		font-weight: 800;
		color: #111;
		margin-bottom: 35px;
	}
</style>

<script type="text/javascript">
	$(function(){
		$(".dataRow").click(function(){
			let no=$(this).find(".no").text();
			location="view.do?no="+no+"&inc=1&${pageObject.pageQuery}";
		}).mouseover(function(){
			$(this).addClass("table-success");
		}).mouseout(function(){
			$(this).removeClass("table-success");
		});
	});
</script>

<c:if test="${!empty pageObject.key && !empty pageObject.word }">
	<script type="text/javascript">
		$(function(){
			$("#key").val("${pageObject.key}");
			$("#word").val("${pageObject.word}");
		});
	</script>
</c:if>

<c:if test="${!empty pageObject.category}">
<script>
    $(function(){
        $("#category").val("${pageObject.category}");
    });
</script>
</c:if>

</head>
<body>
<div class="custom-card">
	<div class="top-title">🍯 꿀팁 아카이브</div>
	<div class="mb-4">
    <form action="list.do" method="get">
        <input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
        <div class="d-flex align-items-center gap-2">

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
                <option value="w">작성자</option>
            </select>

            <!-- 검색 버튼 -->
            <button class="btn btn-dark" style="width:100px; height:45px;">
                검색
            </button>
            
			<select class="form-select form-select-sm w-auto" name="category" 
			        id="category" onchange="this.form.submit()">	            
			    <option value="">전체</option>
	            <option value="자유게시판">자유게시판</option>
	            <option value="질문답변">질문답변</option>
	            <option value="정보공유">정보공유</option>
	            <option value="기타">기타</option>
	        </select>
        </div>
    </form>
</div>

	<table class="table table-hover align-middle">
		<thead class="table-dark">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>댓글</th>
				<th>북마크</th>
			</tr>
		</thead>
		
		<tbody>
			<c:if test="${empty list }">
				<tr>
					<td colspan="7">데이터가 존재하지 않습니다</td>
				</tr>
			</c:if>
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="vo">
					<tr class="dataRow">
						<td class="no">${vo.no }</td>
						<td>${vo.title }</td>
						<td>${vo.writer }</td>
						<td>${vo.writeDate }</td>
						<td>${vo.hit }</td>
						<td>${vo.replyCnt}</td>
						<td>${vo.bookmark }</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	
	<div>
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"/>
	</div>
	<div class="d-flex justify-content-end gap-2 mb-3">
	    <a href="writeForm.do?perPageNum=${param.perPageNum }" class="btn btn-dark">
	        글등록
	    </a>
	    <a href="list.do" class="btn btn-outline-dark">
	        새로고침
	    </a>
	    <c:if test="${not empty login}">
		    <a href="${pageContext.request.contextPath}/boardbookmark/list.do"
		       class="btn btn-dark">
		       북마크 목록
		    </a>
		</c:if>
	</div>
</div>
</body>
</html>