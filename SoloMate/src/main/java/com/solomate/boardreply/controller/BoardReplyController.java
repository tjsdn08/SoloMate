package com.solomate.boardreply.controller;

import java.io.BufferedReader;
import java.util.List;

import org.json.JSONObject;

import com.solomate.boardreply.vo.BoardReplyVO;
import com.solomate.main.controller.Controller;
import com.solomate.main.controller.Init;
import com.solomate.main.service.Execute;
import com.solomate.member.vo.LoginVO;
import com.solomate.util.page.PageObject;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class BoardReplyController implements Controller {

	@SuppressWarnings("unchecked")
	@Override
	public String execute(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		LoginVO login=(LoginVO) session.getAttribute("login");
		String id=null;
		if(login!=null) id=login.getId();
		
		// error
		request.setAttribute("url", request.getRequestURL());
		
		try {
			
			String uri = request.getServletPath();
			
			switch (uri) {
			case "/boardreply/list.do": {
				System.out.println("BoardReplycontroller.execute() - 댓글 리스트 처리");
				
				// 페이지 처리를 위한 객체
				// getInstance() - 객체를 생성해서 넘겨주세요.
				// - 1. PageObject를 생성한다. 2. request에서 page / 검색 정보를 받아서 세팅한다.
				PageObject pageObject = PageObject.getInstance(request);
				
				// no 정보 세팅하기
				pageObject.setNo(Long.parseLong(request.getParameter("no")));
				
				// 생성된 Service를 가져와서 실행 -> Execute가 실행하면 로그를 남긴다.
				// DB에서 데이터 수집을 해온다.
				// 사용자에게 제공한다.
				// Controller - Service - DAO
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
				
				// 로그인 한 경우만 수정 / 삭제 버튼 처리를 해준다
//				if(id!=null) {
					// 작성자와 로그인 한 자람이 같은지 확인하는 처리: sameId
					List<BoardReplyVO> list=(List<BoardReplyVO>) request.getAttribute("list");
					for(BoardReplyVO vo: list) {
						// 작성된 댓글의 작성자와 로그인한 사람이 같은 경우만 처리할 수 있도록 버튼을 보여준다
						if(id!=null && id.equals(vo.getId())) vo.setSameId(1);
						// vo.setSameId(1);
						// content의 특수 문자 처리
						vo.setContent(vo.getContent()
								 .replace("\\", "\\\\").replace("\n", "\\n")
								 .replace("\"", "\\\""));
					}
//				} // if(id!=null)의 끝
				System.out.println("BoardReplyController.execute().pageObject: 처리 후 -"+pageObject);
				
				request.setAttribute("pageObject", pageObject);
				
				return "boardreply/list";
			}
			
			// 댓글 등록
			case "/boardreply/write.do":
				// 데이터 수집 - no, content -> JSON: 라이브러리 사용 - 카페 참조
				// body로 넘어오는 문자열을 저장하기 위한 객체
				StringBuilder sb = new StringBuilder();
				BufferedReader reader = request.getReader();
				String line;
				
				// post로 넘어온 데이터를 읽어오기
				while((line=reader.readLine()) != null) {
					sb.append(line);
				}
				
				// 읽어온 데이터를 문자열로 만든다
				String jsonData=sb.toString();
				
				// JSON 형식에 맞는 자바 객체로 만들기
				JSONObject jsonObject = new JSONObject(jsonData);
				
				// 데이터를 꺼내서 BoardReplyVO에 넣는다
				BoardReplyVO vo = new BoardReplyVO();
				vo.setNo(jsonObject.getLong("no"));
				vo.setContent(jsonObject.getString("content"));
				vo.setId(id); // 로그인 정보에서 아이디 꺼내기 - 코드가 위에 있음
				
				// 데이터 수집 확인
				System.out.println("BoardReplyController.execute().vo = "+vo);
				
				// DB에 등록하러 가기
				Execute.execute(Init.getService(uri), vo);
				
				return "boardreply/write";
				
			// 댓글 수정
			case "/boardreply/update.do":
				// 데이터 수집 - no, content -> JSON: 라이브러리 사용 - 카페 참조
				// body로 넘어오는 문자열을 저장하기 위한 객체
				sb = new StringBuilder();
				reader = request.getReader();
				line=null;
				
				// post로 넘어온 데이터를 읽어오기
				while((line=reader.readLine()) != null) {
					sb.append(line);
				}
				
				// 읽어온 데이터를 문자열로 만든다
				jsonData=sb.toString();
				
				// JSON 형식에 맞는 자바 객체로 만들기
				jsonObject = new JSONObject(jsonData);
				
				// 데이터를 꺼내서 BoardReplyVO에 넣는다
				vo = new BoardReplyVO();
				vo.setNo(jsonObject.getLong("no"));
				vo.setContent(jsonObject.getString("content"));
				vo.setId(id); // 로그인 정보에서 아이디 꺼내기 - 코드가 위에 있음
				
				// 데이터 수집 확인
				System.out.println("BoardReplyController.execute().vo = "+vo);
				
				// DB에 수정하러 가기 & 결과를 request에 담기 -> jsp로 넘긴다
				request.setAttribute("result", Execute.execute(Init.getService(uri), vo));
				
				return "boardreply/update";	
			
			// 댓글 삭제
			case "/boardreply/delete.do":
				// 데이터 수집 - rno / id
				vo=new BoardReplyVO();
				vo.setRno(Long.parseLong(request.getParameter("rno")));
				vo.setId(id); // login 정보 - 코드가 위에 있음
				
				// DB에 삭제하러 가기 & 결과를 request에 담기 -> jsp로 넘긴다
				request.setAttribute("result", Execute.execute(Init.getService(uri), vo));
				
				return "boardreply/delete";
				
			default:
				break;
			}
			
		}catch (Exception e) {
			// TODO: handle exception
			// 개발자를 위한 코드
			e.printStackTrace();
			// 잘못된 예외 처리 - 사용자에게 보여주기
			request.setAttribute("moduleName", "일반 게시판");
			request.setAttribute("e", e);
			// /WEB-INF/views/ + error/err_500 + .jsp
			return "error/err_500";
		}
		
		return null;
	}

}