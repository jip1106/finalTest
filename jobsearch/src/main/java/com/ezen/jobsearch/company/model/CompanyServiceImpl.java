package com.ezen.jobsearch.company.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CompanyServiceImpl implements CompanyService{

	@Autowired
	private CompanyDAO companyDao;
	
	@Override
	public int insertCompany(CompanyVO companyVo) {
		// TODO Auto-generated method stub
		return companyDao.insertCompany(companyVo);
	}

	
}
