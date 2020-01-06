package com.ezen.jobsearch.member.model;

import java.util.HashMap;
import java.util.List;

public interface MemberService {
	//회원가입
	int insertMember(MemberVO memberVo);
	
	//회원 시퀀스 최대값 리턴
	int selectMaxmemSeq();
	//아이디 중복검사
	int dupchkIdCount(String memberId);
	
	//회원가입 인증번호 발송
	String sendCertiNumberMail(String inputMail);
	
	String selectPwd(String memberId);
	//로그인
	MemberVO selectMember(String memberId,String regType);
	
	//아이디찾기
	List<HashMap<String,String>> findId(String memberName, String phone);
	
	//비밀번호 랜덤 생성 발송
	String sendRandomPassword(String inputMail);
	
	//비밀번호 업데이트
	int updatePassword(HashMap<String,String> hMap);
}
