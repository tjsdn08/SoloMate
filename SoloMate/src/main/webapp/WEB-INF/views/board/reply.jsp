<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/js/boardreply.js"></script>
<script src="/js/replyTag.js"></script>
<style>
    /* 댓글 카드 */
    .reply-item {
        margin-bottom: 15px;
    }

    .reply-header {
        font-size: 14px;
        color: #666;
    }

    .reply-content {
        font-size: 16px;
        padding: 10px 0;
        white-space: pre-line;
    }

    .reply-footer {
        font-size: 14px;
    }

    .reply-btn {
        font-size: 14px;
        padding: 4px 10px;
    }
</style>

<script type="text/javascript">
$(function(){
    let no = ${vo.no};
    let page=1;

    reply.list(no, page);

    $("#replyWriteBtn").click(function(){
        $("#modalReplyWriteBtn").show();
        $("#modalReplyUpdateBtn").hide();
    });

    $("#modalReplyWriteBtn").click(function(){
        let content = $("#modalReplyContent").val();
        let replyObj={"no":no, "content":content};

        reply.write(replyObj);

        $("#replyWriteModal").modal("hide");
        $("#modalReplyContent").val("");
        page=1;
        reply.list(no, page);
    });

    $("#replyBody").on("click","#replyUpdateBtn", function(){
		$("#modalReplyRno").val($(this).closest(".dataRow").find(".rno").text());
		$("#modalReplyContent").val($(this).closest(".dataRow").find(".content>pre").text());

        $("#modalReplyWriteBtn").hide();
        $("#modalReplyUpdateBtn").show();
        $("#replyWriteModal").modal("show");
    });

    $("#modalReplyUpdateBtn").click(function(){
        let rno=$("#modalReplyRno").val();
        let content = $("#modalReplyContent").val();

        let replyObj={"rno":rno, "content":content};
        console.log("replyObj = "+JSON.stringify(replyObj));
        reply.update(replyObj);

        $("#replyWriteModal").modal("hide");
        $("#modalReplyContent").val("");
        reply.list(no, page);
    });

    $("#replyBody").on("click", "#replyDeleteBtn", function(){
		let rno=$(this).closest(".dataRow").find(".rno").text();

        if(!confirm("댓글을 삭제하시겠습니까?")) return;

        page=reply.delete(rno, page);
        reply.list(no, page);
    });
})
</script>

<div class="card mt-5">

    <!-- 헤더 -->
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">댓글</h5>

        <!-- 로그인 안해도 버튼 보이게 -->
        <c:if test="${not empty login}">
	        <button class="btn btn-dark btn-sm" id="replyWriteBtn" data-bs-toggle="modal" data-bs-target="#replyWriteModal">
	            등록
	        </button>
        </c:if>
    </div>

    <!-- 댓글 리스트 -->
    <div class="card-body" id="replyBody">

        <!-- 예시 구조 (JS로 생성됨) -->
        <div class="border rounded p-3 reply-item">

            <div class="d-flex justify-content-between reply-header">
                <div>번호</div>
                <div>작성날짜</div>
            </div>

            <div class="reply-content">
                댓글 내용
            </div>

            <div class="d-flex justify-content-between reply-footer">

                <div>작성자</div>

                <div>
                    <button class="btn btn-dark btn-sm" id="replyUpdateBtn">수정</button>
                    <button class="btn btn-outline-dark btn-sm" id="replyDeleteBtn">삭제</button>
                </div>

            </div>

        </div>

    </div>

    <!-- 페이지 -->
    <div class="card-footer text-center">
        
    </div>

</div>

<!-- 모달 -->
<div class="modal" id="replyWriteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <div class="modal-header">
        <h5 class="modal-title">댓글 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <input type="hidden" id="modalReplyRno">
        <textarea rows="4" class="form-control" placeholder="댓글을 입력하세요"
        id="modalReplyContent"></textarea>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-dark" id="modalReplyWriteBtn">등록</button>
        <button type="button" class="btn btn-dark" id="modalReplyUpdateBtn">수정</button>
        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>