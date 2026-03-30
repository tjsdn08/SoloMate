/**
 * BoardReplyVO 객체를 HTML tag로 만들어내는 
 */

// vo는 Object로 넘어온다
function replyTag(vo){
	let tagStr="";
	tagStr += "<div class=\"card dataRow\">";
	tagStr += "	<div class=\"card-header d-flex justify-content-between\">";
	tagStr += "		<div class=\"rno\">"+vo.rno+"</div>";
	tagStr += "		<div>"+vo.writeDate+"</div>";
	tagStr += "	</div>";
	tagStr += "	<div class=\"card-body content\"><pre>"+vo.content+"</pre></div>";
	tagStr += "	<div class=\"card-footer d-flex justify-content-between\">";
	tagStr += "		<div>"+vo.name+"("+vo.id+")</div>";
	
	if(vo.sameId==1){
		tagStr += "		<div>";
		tagStr += "			<button class=\"btn btn-dark btn-sm\" id=\"replyUpdateBtn\">수정</button>";
		tagStr += "			<button class=\"btn btn-outline-dark btn-sm\" id=\"replyDeleteBtn\">삭제</button>";
		tagStr += "		</div>";
	}
	
	tagStr += "	</div>";
	tagStr += "</div>";
	
	return tagStr;
}