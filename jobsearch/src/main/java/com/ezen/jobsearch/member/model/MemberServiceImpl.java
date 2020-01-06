package com.ezen.jobsearch.member.model;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.ezen.jobsearch.common.ProjectUtil;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO memberDao;

	@Override
	public int insertMember(MemberVO memberVo) {
		return memberDao.insertMember(memberVo);
	}

	@Override
	public int selectMaxmemSeq() {
		return  memberDao.selectMaxmemSeq();
	}

	@Override
	public int dupchkIdCount(String memberId) {
	
		return memberDao.dupchkIdCount(memberId);
	}

	//인증번호 메일 발송
		//context-common.xml bean 추가
	@Autowired
	private JavaMailSenderImpl javaMailSenderImpl;
		
	@Override
	public String sendCertiNumberMail(String inputMail) {
		//회원가입 인증번호 발송
		SimpleMailMessage simpleMailmessage = new SimpleMailMessage();
		
		simpleMailmessage.setFrom("pji1106@naver.com");
		simpleMailmessage.setTo(inputMail);	//사용자 입력값으로 변경
			
		simpleMailmessage.setSubject("[JobSearch]인증번호 입력");
		
		String certiNum = ProjectUtil.getCertiNum(6);
		
		simpleMailmessage.setText("인증번호를 보내드립니다. 인증번호 [" + certiNum + "]");	//인증번호 발송로직 추가
			
		javaMailSenderImpl.send(simpleMailmessage);
		
		return certiNum;
	}
	
	@Override
	public String selectPwd(String memberId) {
		
		return memberDao.selectPwd(memberId);
	}

	@Override
	public MemberVO selectMember(String memberId,String regType) {
		MemberVO memberVo = memberDao.selectMember(memberId, regType);
		
		return memberVo;
	}

	@Override
	public List<HashMap<String, String>> findId(String memberName, String phone) {
		List<HashMap<String,String>> aList = memberDao.findId(memberName, phone);
		
		return aList;
	}

	//비밀번호 랜덤 생성, 메일발송
	@Override
	public String sendRandomPassword(String inputMail) {
		//랜덤 비밀번호 생성, 발송
		String randomPwd = "";
		
		try {
			SimpleMailMessage simpleMailmessage = new SimpleMailMessage();
			
			simpleMailmessage.setFrom("pji1106@naver.com");
			simpleMailmessage.setTo(inputMail);	//사용자 입력값으로 변경
				
			simpleMailmessage.setSubject("[JobSearch]임시비밀번호 발송");
			
			randomPwd = ProjectUtil.getRandomPwd(10);	//랜덤 패스워드 생성
			
			simpleMailmessage.setText("임시 비밀번호 발송 ::  [" + randomPwd + "]");	//인증번호 발송로직 추가
				
			javaMailSenderImpl.send(simpleMailmessage);
			
			
		}catch(Exception e) {
			
			randomPwd = "0";
			e.printStackTrace();
			
		}
		
		
		return randomPwd;
	}

	//회원정보 업데이트
	@Override
	public int updatePassword(HashMap<String,String> hMap) {
		// TODO Auto-generated method stub
		int result = memberDao.updatePassword(hMap);
		
		return result;
	}


	
	
}
