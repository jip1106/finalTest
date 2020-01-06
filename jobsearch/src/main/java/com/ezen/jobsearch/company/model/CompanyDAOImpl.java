package com.ezen.jobsearch.company.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CompanyDAOImpl implements CompanyDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String namespace = "config.mybatis.mapper.oracle.company.";
	
	//기업정보 insert
	@Override
	public int insertCompany(CompanyVO companyVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace + "insertCompany", companyVo);
	}


}
