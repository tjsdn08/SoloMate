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
		
		HttpSession session = request.getSession();
		LoginVO login=(LoginVO) session.getAttribute("login");
		String id=null;
		if(login!=null) id=login.getId();
		
		request.setAttribute("url", request.getRequestURL());
		
		try {
			
			String uri = request.getServletPath();
			
			switch (uri) {
			case "/boardreply/list.do": {
				System.out.println("BoardReplycontroller.execute() - 댓글 리스트 처리");
				PageObject pageObject = PageObject.getInstance(request);
				pageObject.setNo(Long.parseLong(request.getParameter("no")));
				request.setAttribute("list", Execute.execute(Init.getService(uri), pageObject));
					List<BoardReplyVO> list=(List<BoardReplyVO>) request.getAttribute("list");
					for(BoardReplyVO vo: list) {
						if(id!=null && id.equals(vo.getId())) vo.setSameId(1);
						vo.setContent(vo.getContent()
								 .replace("\\", "\\\\").replace("\n", "\\n")
								 .replace("\"", "\\\""));
					}
//				} // if(id!=null)의 끝
				System.out.println("BoardReplyController.execute().pageObject: 처리 후 -"+pageObject);
				request.setAttribute("pageObject", pageObject);
				return "boardreply/list";
			} // list의 끝
			
			// 댓글 등록
			case "/boardreply/write.do":
				StringBuilder sb = new StringBuilder();
				BufferedReader reader = request.getReader();
				String line;
				while((line=reader.readLine()) != null) {
					sb.append(line);
				}
				String jsonData=sb.toString();
				JSONObject jsonObject = new JSONObject(jsonData);
				BoardReplyVO vo = new BoardReplyVO();
				vo.setNo(jsonObject.getLong("no"));
				vo.setContent(jsonObject.getString("content"));
				vo.setId(id);
				System.out.println("BoardReplyController.execute().vo = "+vo);
				Execute.execute(Init.getService(uri), vo);
				return "boardreply/write";
				
			// 댓글 수정
			case "/boardreply/update.do":
				sb = new StringBuilder();
				reader = request.getReader();
				line=null;
				while((line=reader.readLine()) != null) {
					sb.append(line);
				}
				jsonData=sb.toString();
				jsonObject = new JSONObject(jsonData);
				vo = new BoardReplyVO();
				vo.setNo(jsonObject.getLong("no"));
				vo.setContent(jsonObject.getString("content"));
				vo.setId(id);
				System.out.println("BoardReplyController.execute().vo = "+vo);
				request.setAttribute("result", Execute.execute(Init.getService(uri), vo));
				return "boardreply/update";	
			
			// 댓글 삭제
			case "/boardreply/delete.do":
				vo=new BoardReplyVO();
				vo.setRno(Long.parseLong(request.getParameter("rno")));
				vo.setId(id);
				request.setAttribute("result", Execute.execute(Init.getService(uri), vo));
				return "boardreply/delete";
				
			default:
				break;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("moduleName", "일반 게시판");
			request.setAttribute("e", e);
			return "error/err_500";
		}
		
		return null;
	}

}
