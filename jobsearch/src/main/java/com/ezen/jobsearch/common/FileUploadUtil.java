package com.ezen.jobsearch.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class FileUploadUtil {
	private static final Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);
	
	//context-comon.xml 파일에 <util: > fileUpProperties
	@Resource(name = "fileUpProperties")
	private Properties props;
	
	//파일 업로드 처리
	public List<Map<String,Object>> fileUpload(HttpServletRequest request) {
		MultipartHttpServletRequest multiReq =(MultipartHttpServletRequest)request;
		
		//String -> input type = file 의 name MultipartFile -> 업로드 파일
		Map<String, MultipartFile> fileMap = multiReq.getFileMap();
		
		
		
		Iterator<String> iter = fileMap.keySet().iterator();
		
		//결과값을 넣을 List
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		
		while(iter.hasNext()) {
			String key = iter.next();
			MultipartFile tempFile = fileMap.get(key);
			
			//업로드 된 경우
			if(!tempFile.isEmpty()) {
				
				//변경전 (원래) 파일명
				String originalFileName = tempFile.getOriginalFilename();
				//변경된 파일명
				String fileName = getUniqueFileName(originalFileName);
				//파일크기
				long fileSize = tempFile.getSize();
				
				Map<String, Object> hMap = new HashMap<String,Object>();
				hMap.put("originalFileName",originalFileName);
				hMap.put("fileName",fileName);
				hMap.put("fileSize",fileSize);
				
				list.add(hMap);
				
				//업로드 처리
				//업로드 경로
				String upPath = getFilePath(request);
				File file = new File(upPath, fileName);
				
				try {
					tempFile.transferTo(file);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return list;
		
	}
	
	//업로드 경로 
	public String getFilePath(HttpServletRequest request) {
		//fileUpload.properties 프로퍼티 파일에 지정되어있음
		String type = props.getProperty("file.upload.type");
		logger.info("type={}",type);
		String path = "";
		
		if(type.equals("test")) {	//테스트 경로
			path=props.getProperty("file.upload.path.test");
		}else {	//배포시 실제 경로
			String upDir = props.getProperty("file.upload.path");
			
			//실제경로 구하기
			path = request.getSession().getServletContext().getRealPath(upDir);
		}
		logger.info("업로드 경로  path={}",path);
		
		return path;
	}
	
	//파일네임
	private String getUniqueFileName(String originalFileName) {
		//파일명에 현재시간(년월일시분초밀리초)을 붙여서 파일명 변경 

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String nowTime = sdf.format(new Date());

		int idx = originalFileName.lastIndexOf(".");
		String renameFileName = originalFileName.substring(0,idx);
		String ext = originalFileName.substring(idx);
		
		renameFileName += nowTime;
		renameFileName += ext;
		
		logger.info("renameFileName :: " + renameFileName );
								
		return renameFileName;
	}
}
