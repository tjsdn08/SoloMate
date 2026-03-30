package com.webjjang.member.vo;

public class Login {

	private static LoginVO loginVO = null;
	
	public static void setLoginVO(LoginVO loginVO) {
		Login.loginVO = loginVO;
	}
	
	public static String getId() throws Exception{
		return loginVO.getId();
	}
	
	public static boolean isLogin() {
		if(loginVO == null) return false;
		return true;
	}
	
	public static boolean isAdmin() {
		if (loginVO == null) return false;
		if (loginVO.getGradeNo() == 9) return true;
		return false;
	}
	
	public static int getGradeNo() {
		return loginVO.getGradeNo();
	}
	
	public static void loginPrint() {
		if(isLogin()) {
			System.out.println("+ " + loginVO.getName() + "(" + loginVO.getId() + ")" 
			+ "님은 " + loginVO.getGradeName() + "으로 로그인하셨습니다." + "+");
		} else System.out.println("비회원입니다. \n");
	}
	
	
}
