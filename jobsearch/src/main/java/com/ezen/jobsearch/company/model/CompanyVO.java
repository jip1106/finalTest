package com.ezen.jobsearch.company.model;

public class CompanyVO {
	
	private int comSeq;
	private String comRegnumber;  
	private String comName;
	private String ceoName;
	private String comDesc;      
	private String comTel; 
	private String setupDate;        
	private String employeeNum; 
	private String comType;
	private String comSales; 
	private String comFiled;
	private String comImg; 
	private String comRenameimage; 
	private int refMemberseq;
	
	public int getComSeq() {
		return comSeq;
	}
	public void setComSeq(int comSeq) {
		this.comSeq = comSeq;
	}
	public String getComRegnumber() {
		return comRegnumber;
	}
	public void setComRegnumber(String comRegnumber) {
		this.comRegnumber = comRegnumber;
	}
	public String getComName() {
		return comName;
	}
	public void setComName(String comName) {
		this.comName = comName;
	}
	public String getCeoName() {
		return ceoName;
	}
	public void setCeoName(String ceoName) {
		this.ceoName = ceoName;
	}
	public String getComDesc() {
		return comDesc;
	}
	public void setComDesc(String comDesc) {
		this.comDesc = comDesc;
	}
	public String getComTel() {
		return comTel;
	}
	public void setComTel(String comTel) {
		this.comTel = comTel;
	}
	public String getSetupDate() {
		return setupDate;
	}
	public void setSetupDate(String setupDate) {
		this.setupDate = setupDate;
	}
	public String getEmployeeNum() {
		return employeeNum;
	}
	public void setEmployeeNum(String employeeNum) {
		this.employeeNum = employeeNum;
	}
	public String getComType() {
		return comType;
	}
	public void setComType(String comType) {
		this.comType = comType;
	}
	public String getComSales() {
		return comSales;
	}
	public void setComSales(String comSales) {
		this.comSales = comSales;
	}
	public String getComFiled() {
		return comFiled;
	}
	public void setComFiled(String comFiled) {
		this.comFiled = comFiled;
	}
	public String getComImg() {
		return comImg;
	}
	public void setComImg(String comImg) {
		this.comImg = comImg;
	}
	public String getComRenameimage() {
		return comRenameimage;
	}
	public void setComRenameimage(String comRenameimage) {
		this.comRenameimage = comRenameimage;
	}
	public int getRefMemberseq() {
		return refMemberseq;
	}
	public void setRefMemberseq(int refMemberseq) {
		this.refMemberseq = refMemberseq;
	}
	@Override
	public String toString() {
		return "CompanyVO [comSeq=" + comSeq + ", comRegnumber=" + comRegnumber + ", comName=" + comName + ", ceoName="
				+ ceoName + ", comDesc=" + comDesc + ", comTel=" + comTel + ", setupDate=" + setupDate
				+ ", employeeNum=" + employeeNum + ", comType=" + comType + ", comSales=" + comSales + ", comFiled="
				+ comFiled + ", comImg=" + comImg + ", comRenameimage=" + comRenameimage + ", refMemberseq="
				+ refMemberseq + "]";
	}
	
	
	
}
