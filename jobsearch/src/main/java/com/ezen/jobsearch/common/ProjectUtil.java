package com.ezen.jobsearch.common;

import java.util.Random;

public class ProjectUtil {
	
	//랜덤 비밀번호
	public static String getRandomPwd(int length) {
		
		StringBuffer sb = new StringBuffer();
		Random rnd = new Random();
		
		for (int i = 0; i < length; i++) {
		    int rIndex = rnd.nextInt(3);
		    switch (rIndex) {
		    case 0:
		        // a-z
		    	sb.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // A-Z
		    	sb.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 2:
		        // 0-9
		    	sb.append((rnd.nextInt(10)));
		        break;
		    }
		}
		
		//System.out.println("랜덤 비밀번호 : " + sb.toString());
		
		return sb.toString();
	}
	//인증번호
	public static String getCertiNum(int length) {
		StringBuffer sb = new StringBuffer();
		
		Random rnd = new Random();
		
		for(int i=0; i<length; i++) {
			sb.append(rnd.nextInt(10));
		}
		
		//System.out.println("인증번호 생성: " + sb.toString());
		return sb.toString();
	}
	
	
	
}
