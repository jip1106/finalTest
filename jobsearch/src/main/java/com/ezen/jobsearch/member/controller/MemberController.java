package com.ezen.jobsearch.member.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ezen.jobsearch.company.model.CompanyService;
import com.ezen.jobsearch.company.model.CompanyVO;
import com.ezen.jobsearch.member.model.MemberService;
import com.ezen.jobsearch.member.model.MemberVO;

@Controller
public class MemberController {
	//회원가입, 로그인 및 회원관련 컨트롤러
	private Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CompanyService companyService; 
	
	//암호화 의존성 주입
	//bean 등록 필요(context-common.xml) , pom.xml 수정 필요(spring security 추가)
	@Autowired
    private BCryptPasswordEncoder passwordEncoder;
	
	
	//로그인
	@RequestMapping("/member/login.do")
	public String loginPage() {
		return "member/login";
	}
	
	//회원가입
	@RequestMapping("/member/register.do")
	public String register(@RequestParam(defaultValue="1", required=false) String regType, Model model) {
		
		//1 일반회원, 2 기업회원
		if( !(regType.equals("1") || regType.equals("2")) ) {
			regType = "1";
		}
		
		model.addAttribute("regType",regType);
			
		return "member/register";
	}
	
	@RequestMapping("/member/insertMember.do")
	public String insertMember(@ModelAttribute MemberVO memberVo,Model model, @ModelAttribute CompanyVO companyVo) {
		
		logger.info("memberVo={}",memberVo);
		
		String regType = memberVo.getRegType();
		
		String encPassword = passwordEncoder.encode(memberVo.getMemberPwd());
		//암호화된 비밀번호 셋팅
		memberVo.setMemberPwd(encPassword);
		
		int memberResult = 0;
		int companyResult = 0;
		
		//회원 가입
		memberResult = memberService.insertMember(memberVo);
		
		//기업회원 가입
		if(regType.equals("2")) { 
			if(memberResult>0) {
				int refMemberSeq = memberService.selectMaxmemSeq();
				
				companyVo.setRefMemberseq(refMemberSeq);
				companyResult = companyService.insertCompany(companyVo);
			}
		}
		
		model.addAttribute("regType",regType);
		model.addAttribute("memberResult",memberResult);
		model.addAttribute("companyResult",companyResult);
		
		return "member/regcomplete";
	}
	
	//ajax 처리 회원 id 중복검사
	@RequestMapping("/member/dupchk.do")
	public @ResponseBody int  dupchkIdCount(@RequestParam String memberId) {
		int result = 0;
		
		result = memberService.dupchkIdCount(memberId);
		
		return result;
		
	}
	
	//인증번호 메일 발송
	@RequestMapping("/member/certiNumber.do")
	public @ResponseBody String sendCertiNumberMail(@RequestParam String inputMail,Model model) throws Exception{
		String certiNumber = memberService.sendCertiNumberMail(inputMail);
		
		return certiNumber;
		
	}
	
	//로그인 
	@RequestMapping("/member/loginCheck.do")
	public String loginCheck(@RequestParam String memberId, @RequestParam String memberPwd, @RequestParam String regType,
			HttpServletRequest request, Model model) {
		
		//암호화 된 비밀번호 비교를 위해 db에서 비밀번호 select
		String dbPwd = memberService.selectPwd(memberId);
		
		System.out.println("memberId : " + memberId);
		System.out.println("memberPwd : " + memberPwd);
		System.out.println("regType : " + regType);

		boolean pwdChk = false;

		//비밀번호 비교
		pwdChk = passwordEncoder.matches(memberPwd, dbPwd);
		
		System.out.println("pwdChk ::: " + pwdChk);
		
		MemberVO memberVo = null;
		
		//비밀번호 일치
		if(pwdChk) {
			memberVo = memberService.selectMember(memberId,regType);
			//System.out.println("memberVo : " + memberVo);
			
			if(memberVo == null) {
				String message="가입하지 않은 아이디 이거나, 잘못된 비밀번호 입니다.";
				
				model.addAttribute("message",message);
				
				if(regType.equals("1") || regType.equals("2")) {	//일반, 기업회원
					return "/member/login";
				}else {												//관리자
					return "/admin/login/login";
				}
			}
			
			memberVo.setMemberPwd("");
			HttpSession session = request.getSession();
			session.setAttribute("loginMember", memberVo);
			
			if(regType.equals("1") || regType.equals("2")) {	//일반, 기업회원
				return "redirect:/home.do";
			}else {												//관리자
				return "redirect:/admin/home.do";
			}
		}else {
			String message="가입하지 않은 아이디 이거나, 잘못된 비밀번호 입니다.";
			
			model.addAttribute("message",message);
			
			if(regType.equals("1") || regType.equals("2")) {	//일반, 기업회원
				return "/member/login";
			}else {					
				return "/admin/login/login";
			}
		}
		
	}
	
	//로그아웃
	@RequestMapping("/member/logout.do")
	public String logout(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO memberVo = (MemberVO)session.getAttribute("loginMember");
		String regType = memberVo.getRegType();
		
		String returnPage = "redirect:/home.do";
		
		if(regType.equals("0")) {
			returnPage = "redirect:/admin/login.do";
		}
		
		session.invalidate();
		
		
		return returnPage;
	}
	
	//id찾기, 비밀번호 찾기
	@RequestMapping("/member/findIdPwd.do")
	public String findIdPwd() {
		
		return "/member/findIdPwd";
	}
	
	//id 찾기
	@RequestMapping("/member/findId.do")
	public @ResponseBody List<HashMap<String,String>> findId(@RequestParam String memberName , @RequestParam String phone) {
	//	System.out.println("memberName : " + memberName);
	//	System.out.println("phone : " + phone);
		
		List<HashMap<String,String>> aList = memberService.findId(memberName, phone);
		System.out.println("aList :: "+aList);
		
		return aList;
	}
	
	//비밀번호 찾기(메일발송)
	@RequestMapping("/member/sendPwdMail.do")
	public @ResponseBody int sendPwdMail(@RequestParam(value="memberId") String memberId) {
		
		String randomPwd = memberService.sendRandomPassword(memberId);
		
		
		int updateCnt = 0;
		
		
		if(randomPwd.equals("0")) {	//메일발송 실패
			
		}else {	//메일발송 성공
			HashMap<String,String> hMap = new HashMap<String,String>();
			
			//비밀번호 암호화
			String encPwd = passwordEncoder.encode(randomPwd);
			
			hMap.put("memberId", memberId);
			hMap.put("memberPwd", encPwd);
			
			updateCnt = memberService.updatePassword(hMap);
		}
		
		System.out.println("updateCnt : " + updateCnt);
		return updateCnt; 
		
		
	}
	
	
}
