/**
 * 댓글의 처리 객체(JSON)
 * reply 객체 생성
 * 댓글 리스트 / 등록 / 수정 / 삭제 처리
 */

// 바로 실행되는 코드
console.log("reply 객체 로딩~~~");

// reply 객체 -> JSON - {k:v,...,k:function(){},...}
reply = {
	// list 메서드 ->reply.list();
	list : function(no,page){
		console.log("댓글 리스트 처리");
		console.log("reply.list() - no = "+no+", page = "+page);

		// ajax로 서버에서 댓글 데이터를 가져온다
		$.ajax({
			url: "/boardreply/list.do?no="+no+"&page="+page,
			dataType:"json",
			success: function(result){
				// result - list, pageObject
				console.log("result = "+result);
				// 가져온 JSON 데이터 확인하기
				console.log("result str = "+JSON.stringify(result));
				console.log("result.list = "+result.list);
				console.log("result.list의 갯수 = "+result.list.length);
				
				let tagStr="";
				
				if(result.list.length == 0) {
					console.log("가져온 데이터 없음");
					tagStr+="아직 등록된 댓글이 존재하지 않습니다";
				}
				else {
					console.log("가져온 데이터 있음");
					// list 안에 데이터 있는 만큼 반복 처리한다
					$.each(result.list, function(inx, vo){
						// 댓글 내용 안에 들어갈 태그를 만들어준다 - replyTag.js에 선언이 되어있다
						tagStr+=replyTag(vo);
					});
				}
					
				// 댓글을 위치시켜야 할 장소에 넣어준다
				$("#replyBody").html(tagStr);
			}, // success의 끝
			error : function(xhr,status,error){
				console.log("댓글 리스트 가져오기 에러");
				// 오류 내용 출력
				console.log("xhr = "+xhr);
				console.log("status = "+status);
				console.log("error = "+error);
			}
		}); // $.ajax의 끝
	},
	write : function(replyObj){
		console.log("댓글 등록 처리");
		console.log("replyObj = "+JSON.stringify(replyObj));
		// Ajax를 이용해서 데이터 보내기 등록 처리
		$.ajax({
			url:"/boardreply/write.do",
			type:"POST",
			contentType:"application/JSON",
			data:JSON.stringify(replyObj),
			success:function(result){
				console.log("result = "+result);
				$("#msgModal").find(".modal-body").text(result);
				$("#msgModal").modal("show");
			},
			error : function(xhr,status,error){
				console.log("댓글 내용 에러");
				// 오류 내용 출력
				console.log("xhr = "+xhr);
				console.log("status = "+status);
				console.log("error = "+error);
				$("#msgModal").find(".modal-body").text("댓글 등록에 실패하셨습니다");
				$("#msgModal").modal("show");
			}
		}); //ajax의 끝
	}, // write의 끝
	
	update : function(replyObj){
		console.log("댓글 수정 처리");
		console.log("replyObj = "+JSON.stringify(replyObj));
		// Ajax를 이용해서 데이터 보내기 수정 처리
		$.ajax({
			url:"/boardreply/update.do",
			type:"POST",
			contentType:"application/JSON",
			data:JSON.stringify(replyObj),
			success:function(result){
				console.log("result = "+result);
				$("#msgModal").find(".modal-body").text((result==1)?"댓글이 수정되었습니다":"댓글이 수정되지 않았습니다");
				$("#msgModal").modal("show");
			},
			error : function(xhr,status,error){
				console.log("댓글 수정 에러");
				// 오류 내용 출력
				console.log("xhr = "+xhr);
				console.log("status = "+status);
				console.log("error = "+error);
				$("#msgModal").find(".modal-body").text("댓글 수정을 진행하는 중 오류가 발생되었습니다");
				$("#msgModal").modal("show");
			}
		}); //ajax의 끝
	}, // update의 끝
	
	delete : function(rno, page){
		console.log("댓글 삭제 처리");
		console.log("reply.delete().rno = "+rno);
		// Ajax를 이용해서 데이터 보내기 삭제 처리
		$.ajax({
			url:"/boardreply/delete.do?rno="+rno,
			success:function(result){
				console.log("result = "+result);
				if(result==1){
					$("#msgModal").find(".modal-body")
					.text("댓글이 삭제되었습니다");
					page=1;
				} else {
					$("#msgModal").find(".modal-body")
					.text("댓글이 삭제되지 않았습니다");
				};
				$("#msgModal").modal("show");
			},
			error : function(xhr,status,error){
				console.log("댓글 삭제 에러");
				// 오류 내용 출력
				console.log("xhr = "+xhr);
				console.log("status = "+status);
				console.log("error = "+error);
				$("#msgModal").find(".modal-body").text("댓글 삭제를 진행하는 중 오류가 발생되었습니다");
				$("#msgModal").modal("show");
			}
		}); //ajax의 끝
		
		return page;
		
	} // delete()의 끝
	
} // reply의 끝

