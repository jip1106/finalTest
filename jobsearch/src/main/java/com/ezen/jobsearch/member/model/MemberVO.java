package com.ezen.jobsearch.member.model;


public class MemberVO {
	 private int memberSeq;                             
	 private String memberId;               
	 private String memberPwd;              
	 private String memberName;             
	 private String regType ;    
	 private String zipCode; 
	 private String address;                        
	 private String detailAddress;                 
	 private String extraAddress;                   
	 private String phone;                           
	 private String genderType ;                       
	 private String birthday;                        
	 private String profileImg;                    
	 private String profileRenameimg ;               
	 private String regDate;                 
	 private String delFlag; 
	 private String delDate;
	 
	public int getMemberSeq() {
		return memberSeq;
	}
	public void setMemberSeq(int memberSeq) {
		this.memberSeq = memberSeq;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPwd() {
		return memberPwd;
	}
	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getRegType() {
		return regType;
	}
	public void setRegType(String regType) {
		this.regType = regType;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getExtraAddress() {
		return extraAddress;
	}
	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getGenderType() {
		return genderType;
	}
	public void setGenderType(String genderType) {
		this.genderType = genderType;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getprofileRenameimg() {
		return profileRenameimg;
	}
	public void setProfileRenameimg(String profileRenameimg) {
		this.profileRenameimg = profileRenameimg;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public String getDelDate() {
		return delDate;
	}
	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}
	
	@Override
	public String toString() {
		return "MemberVO [memberSeq=" + memberSeq + ", memberId=" + memberId + ", memberPwd=" + memberPwd
				+ ", memberName=" + memberName + ", regType=" + regType + ", zipCode=" + zipCode + ", address="
				+ address + ", detailAddress=" + detailAddress + ", extraAddress=" + extraAddress + ", phone=" + phone
				+ ", genderType=" + genderType + ", birthday=" + birthday + ", profileImg=" + profileImg
				+ ", profileRenameimg=" + profileRenameimg + ", regDate=" + regDate + ", delFlag=" + delFlag
				+ ", delDate=" + delDate + "]";
	}
	 
	 
}
