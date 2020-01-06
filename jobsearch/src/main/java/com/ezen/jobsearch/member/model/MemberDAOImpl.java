package com.ezen.jobsearch.member.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDAOImpl implements MemberDAO{
	
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	private String nameSpace = "config.mybatis.mapper.oracle.member.";
	
	//회원가입
	@Override
	public int insertMember(MemberVO memberVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert(nameSpace + "insertMember" ,memberVo);
	}

	@Override
	public int selectMaxmemSeq() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace+"selectMaxmemSeq");
	}

	@Override
	public int dupchkIdCount(String memberId) {
		
		return sqlSession.selectOne(nameSpace+"dupchkIdCount",memberId);
	}
	

	@Override
	public String selectPwd(String memberId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace+"selectPwd", memberId);
	}

	@Override
	public MemberVO selectMember(String memberId , String regType) {
		// TODO Auto-generated method stub
		
		HashMap<String, String> hMap = new HashMap<String, String>();
		
		hMap.put("memberId", memberId);
		hMap.put("regType", regType);
		
		MemberVO memberVo = sqlSession.selectOne(nameSpace+"selectMember", hMap);
		
	
		return memberVo;
	}

	@Override
	public List<HashMap<String, String>> findId(String memberName, String phone) {
		// TODO Auto-generated method stub
		HashMap<String,String> hMap = new HashMap<String,String>();
		
		hMap.put("memberName",memberName);
		hMap.put("phone",phone);
		
		List<HashMap<String, String>> aList = new ArrayList<HashMap<String,String>>();
	
		
		aList = sqlSession.selectList(nameSpace+"findId",hMap);
		
		
		return aList;
	}

	@Override
	public int updatePassword(HashMap<String, String> hMap) {
		int result = sqlSession.update("updatePwd",hMap);
		
		return result;
	}

	
	
}
