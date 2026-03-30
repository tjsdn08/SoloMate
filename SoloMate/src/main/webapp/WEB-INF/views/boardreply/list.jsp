<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{
	"list":[
	
		<c:if test="${!empty list }">
			<c:forEach items="${list }" var="vo" varStatus="vs">
				{
					"rno":${vo.rno },
					"no":${vo.no },
					"content":"${vo.content }",
					"id":"${vo.id }",
					"name":"${vo.name }",
					"sameId":${vo.sameId },
					"writeDate":"${vo.writeDate }"
				}<c:if test="${!vs.last }">,</c:if>
			</c:forEach>
		</c:if>
	],
	"pageObject":{
		"page":1,
		"perPageNum":10,
		"startPage":1,
		"endPage":1
	}
}