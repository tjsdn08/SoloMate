package com.solomate.member.dao;

import java.util.ArrayList;
import java.util.List;

import com.solomate.main.dao.DAO;
import com.solomate.member.vo.LoginVO;
import com.solomate.member.vo.MemberVO;
import com.solomate.util.db.DB;

public class MemberDAO extends DAO{

	// 1-1. 로그인 처리 
	public LoginVO login(LoginVO userVO) throws Exception{
		LoginVO vo = null;
		
		con = DB.getConnection();
		String sql = "select m.id, m.name, m.gradeNo, g.gradeName from member m, grade g "
				+ " where (id = ? and pw = ?) and (m.gradeNo = g.gradeNo)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userVO.getId());
		pstmt.setString(2, userVO.getPw());
		rs = pstmt.executeQuery();
		if(rs != null && rs.next()) {
			vo = new LoginVO();
			vo.setId(rs.getString("id"));
			vo.setName(rs.getString("name"));
			vo.setGradeNo(rs.getInt("gradeNo"));
			vo.setGradeName(rs.getString("gradeName"));
		}
		DB.close(con, pstmt, rs);
		
		return vo;
	} // login()의 끝
	
	// 1-1-1 최근 접속일 변경(U) - id
	public Integer changeConDate(String id) throws Exception {
		Integer result = 0;
		
		con = DB.getConnection();
		String sql = "update member set conDate = sysdate where id = ? ";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		result = pstmt.executeUpdate();
		DB.close(con, pstmt);
		
		return result;
	} // changeConDate()의 끝
	
	
	// 2-1. 회원가입
	public Integer write(MemberVO vo) throws Exception {
		Integer result = 0;
		
		// 1. 드라이버 확인 & 2. 연결 객체
		con = DB.getConnection();
		// 3. SQL 작성
		String sql = "insert into member(id, pw, name, tel, address) "
				+ " values(?,?,?,?,?)";
		// 4. 실행객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getId());
		pstmt.setString(2, vo.getPw());
		pstmt.setString(3, vo.getName());
		pstmt.setString(4, vo.getTel());
		pstmt.setString(5, vo.getAddress());
		// 5. 실행 //6. 데이터 저장
		// select - executeQuery() : rs, insert, update, delete - executeUpdate() : Integer
		result = pstmt.executeUpdate();
		// 7. 닫기
		DB.close(con, pstmt);
		
		return result;
	} // write()의 끝
	
	public List<MemberVO> list() throws Exception {
		List<MemberVO> list = null;
		
		list = new ArrayList<>();
		
		// 1. 드라이버 확인 & 2. 연결 객체
		con = DB.getConnection();
		
		// 3. 실행할 쿼리 작성
		String sql = "select m.id, m.name, m.tel, m.address, m.status, m.gradeNo, g.gradeName "
				+ " from member m, grade g where (m.gradeNo = g.gradeNo) order by id";
		
		// 4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		
		// 5. 실행 : select :executeQuery() -> rs, insert / update / delete :executeUpdate() -> Integer
		rs = pstmt.executeQuery();
		
		// 6. DB에서 가져온 데이터 채우기
		if(rs != null) {
			while(rs.next()) { // 데이터가 있는 만큼 반복 실행
				// 저장할 객체를 생성한다.
				MemberVO vo = new MemberVO();
				vo.setId(rs.getString("id"));
				vo.setName(rs.getString("name"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setStatus(rs.getString("status"));
				vo.setGradeNo(rs.getInt("gradeNo"));
				vo.setGradeName(rs.getString("gradeName"));
				
				list.add(vo);
			}// while의 끝
		}
		return list;
	}
	public Integer changeStatus(MemberVO vo) throws Exception {
		Integer result = 0;
		
		// 1. 드라이버 확인 & 2. 연결 객체
		con = DB.getConnection();
		// 3. SQL 작성
		String sql = "update member set status = ? where id = ? ";
		// 4. 실행객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, vo.getStatus());
		pstmt.setString(2, vo.getId());
		// 5. 실행 //6. 데이터 저장
		// select - executeQuery() : rs, insert, update, delete - executeUpdate() : Integer
		result = pstmt.executeUpdate();
		// 7. 닫기
		DB.close(con, pstmt);
		
		return result;
	} // changeStatus()의 끝
	
	public Integer changeGrade(MemberVO vo) throws Exception {
		Integer result = 0;
		
		// 1. 드라이버 확인 & 2. 연결 객체
		con = DB.getConnection();
		// 3. SQL 작성
		String sql = "update member set gradeNo = ? where id = ? ";
		// 4. 실행객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, vo.getGradeNo());
		pstmt.setString(2, vo.getId());
		// 5. 실행 //6. 데이터 저장
		// select - executeQuery() : rs, insert, update, delete - executeUpdate() : Integer
		result = pstmt.executeUpdate();
		// 7. 닫기
		DB.close(con, pstmt);
		
		return result;
	}
	
	// 아이디 중복 체크
	public String checkId(String inId) throws Exception {
		String id = null;
		
		// 1.2.
		con = DB.getConnection();
		// 3
		String sql = "select id from member where id = ?";
		//4. 
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, inId);
		// 5. 
		rs = pstmt.executeQuery();
		// 6.
		if(rs != null && rs.next())
			id = rs.getString("id");
		// 7.
		DB.close(con, pstmt, rs);
		
		return id;
	}
	
	
	// 비밀번호 중복 체크
	public String checkPw(String inPw) throws Exception {
		String pw = null;
		
		// 1.2.
		con = DB.getConnection();
		// 3
		String sql = "select pw from member where pw = ?";
		//4. 
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, inPw);
		// 5. 
		rs = pstmt.executeQuery();
		// 6.
		if(rs != null && rs.next())
			pw = rs.getString("pw");
		// 7.
		DB.close(con, pstmt, rs);
		
		return pw;
	}
	
	public MemberVO view(String id) throws Exception {
		MemberVO vo = null;
		
		// 1. 드라이버 확인 & 2. 연결 객체
		con = DB.getConnection();
		// 3. SQL
		String sql = "SELECT m.id, m.name, m.tel, m.address, m.status, m.gradeNo, m.gradeNo, g.gradeName, m.regDate, m.conDate "
				+ " FROM member m, grade g "
				+ " WHERE m.id = ? AND m.gradeNo = g.gradeNo";
		// 4. 실행 객체 & 데이터 세팅
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		// 5. 실행
		rs = pstmt.executeQuery();
		// 6. 데이터 저장
		if(rs != null && rs.next()) {
			vo = new MemberVO();
			vo.setId(rs.getString("id"));
			vo.setName(rs.getString("name"));
			vo.setTel(rs.getString("tel"));
			vo.setAddress(rs.getString("address"));
			vo.setStatus(rs.getString("status"));
			vo.setGradeNo(rs.getInt("gradeNo"));
			vo.setGradeName(rs.getString("gradeName"));
			vo.setRegDate(rs.getString("regDate"));
			vo.setConDate(rs.getString("conDate"));
		} // if 의 끝
		// 7. 닫기
		DB.close(con, pstmt, rs);
		
		return vo;
	} // view()의 끝
	
	// 아이디 찾기 - 이름과 연락처 사용
	public String searchId(MemberVO vo) throws Exception {
	    String id = null;
	    
	        con = DB.getConnection();
	        String sql = "select id from member where name = ? and tel = ?";
	        
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, vo.getName());
	        pstmt.setString(2, vo.getTel());
	        
	        rs = pstmt.executeQuery();
	        
	        if(rs != null && rs.next()) {
	            id = rs.getString("id");
	        }
	        DB.close(con, pstmt, rs);
	    
	    
	    return id;
	}
	
	// 비밀번호 변경 
	public int changePw(String id, String pw, String newPw) throws Exception {
	    int result = 0;
	    
	        con = DB.getConnection();
	        String sql = "update member set pw = ? where id = ? and pw = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, newPw); // 새 비밀번호
	        pstmt.setString(2, id);    // 로그인한 사용자 아이디
	        pstmt.setString(3, pw);    // 현재 입력한 기존 비밀번호
	        result = pstmt.executeUpdate();
	        DB.close(con, pstmt);
	    return result;
	}
	
}
