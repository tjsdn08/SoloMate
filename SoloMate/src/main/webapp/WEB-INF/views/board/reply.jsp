<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/js/boardreply.js"></script>
<script src="/js/replyTag.js"></script>
<script type="text/javascript">
	$(function(){
		let no = ${vo.no};
		let page=1;
	
		replt.list(no, page);
		
		$("#replyWriteBtn").click(function(){
			$("#modalReplyWriteBtn").show();
			$("#modalReplyUpdateBtn").hide();
		});
		
		$("#modalReplyWirteBtn").click(function(){
			let content = $("#modalReplyContent").val();
			let replyObj={"no":no, "content":content};
			console.log("replyObj = "+JSON.stringify(replyObj));
			reply.write(replyObj);
			$("#replyWriteModal").modal("hide");
			$("#modalReplyContent").val("");
			page=1;
			reply.list(no, page);
		});
		
		#("replyBody").on("click","#replyUpdateBtn", function(){
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
			if(!confirm(rno+"번 댓글을 정말 삭제하시겠습니까?")) return;
			page=reply.delete(rno, page);
			reply.list(no, page);
		});
	})
</script>
<div class="card">
	<div class="card-header d-flex justify-content-between">
		<h3>댓글</h3>
		<c:if test="${!empty login }">
			<div>
				<button class="btn btn-primary" data-bs-toggle="modal" 
				data-bs-target="#replyWriteModal" id="replyWriteBtn">등록</button>
			</div>
		</c:if>
	</div>
	<div class="card-body" id="replyBody">
		<div class="card dataRow">
			<div class="card-header d-flex justify-content-between">
				<div class="no">번호</div>
				<div>작성날짜</div>
			</div>
			<div class="card-body content">댓글 내용</div>
			<div class="card-footer d-flex justify-content-between">
				<div>이름(아이디)</div>
				<div>
					<button class="btn btn-success btn-sm">수정</button>
					<button class="btn btn-danger btn-sm">삭제</button>
				</div>
			</div>
		</div>
	</div>
	<div class="card-footer">페이지 처리</div>
</div>

<!-- 댓글 등록과 수정할 때 상용되는 모달 -->
<!-- The Modal -->
<div class="modal" id="replyWriteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">댓글 내용 입력</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      	<input type="hidden" id="modalReplyRno">
        <textarea rows="4" class="form-control" placeholder="댓글을 입력하세요"
        id="modalReplyContent"></textarea>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="modalReplyWriteBtn">등록</button>
        <button type="button" class="btn btn-success" id="modalReplyUpdateBtn">수정</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>