<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<c:import url="/WEB-INF/views/include/header.jsp" />
 <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script type="text/javascript">
$.datepicker.setDefaults({
                 dateFormat: 'yy-mm-dd' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
                ,minDate: "-80Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "-18Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)         
});
$(function() {
    $("#birthday").datepicker({

    });
    
    //아이디 이메일 체크
    $("#memberId").keyup(function(){

    	var inputVal = $(this).val();
    	
    	idEmailChk(inputVal);
    	
    })
    
    $("#comRegnumber").keyup(function(){
    	var inputVal = $(this).val();
		var message = "<span style='color:red; font-size:0.8em;'>유효하지 않은 사업자 번호 입니다.</span>";
		
    	$(this).val(licenseNum(inputVal));
    	
		if(inputVal.length==12){
			if(regNumberChk(inputVal)){
				message = "<span style='color:green; font-size:0.8em;'>사용할 수 있는 사업자 번호 입니다.</span>";
				
				$("#regnumber_ok").val('Y');
				$("#regNumberDiv").html(message);
				
			}else{
				message = "<span style='color:red; font-size:0.8em;'>유효하지 않은 사업자 번호 입니다.</span>";
				
				$("#regnumber_ok").val('N');
				$("#regNumberDiv").html(message);
			}
		}
    });
    
    $("#phone").keyup(function(){
    	var hypenPhone = autoHypenPhone($(this).val());

    	$(this).val(hypenPhone);
    })
    
    
});


//아이디체크(이메일 형식 체크)
function idEmailChk(email){
	var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	
	var message = "<span style='color:red; font-size:0.8em;'>이메일 형식이 일치하지 않습니다.</span>";
	
	if (!re.test(email)) {
  	  $("#idchkdiv").html(message);
  	  $("#id_ok").val('N');
  	  $("#certiDiv").hide();
  	}else{	//ajax id 중복검사 추가
  	  
  		var requestData = $("#memberId").val();
		
		$.ajax({ 
			type:"POST", 
			url: '/jobsearch/member/dupchk.do', 
			data:{"memberId": requestData },
			dataType: "json", 
			cache : false, 
			success : function(resData){ 
				
				console.log(resData);
				if(resData > 0){
					message="<span style='color:red; font-size:0.8em;'>중복된 id 입니다. 다른 id를 사용 해 주세요.</span>";
					$("#id_ok").val('N');
					$("#certiDiv").hide();
				}else{
					message="<span style='color:green; font-size:0.8em;'>사용 가능합니다. 인증을 완료 해 주세요.</span>";
					$("#id_ok").val('Y');
					$("#certiDiv").show();
				}
				 
				$("#idchkdiv").html(message);
				
			}, 
			error : function(xhr, status, e){ 
				console.log(status);
			} 
		});
  	}
}

//인증번호 메일발송
function certificationEmail(){
	var inputMail=$("#memberId").val();
	
	$.ajax({ 
		type:"POST", 
		url: '/jobsearch/member/certiNumber.do', 
		data:{"inputMail": inputMail },
		dataType: "json", 
		cache : false, 
		success : function(resData){ 
			
			if(resData!=null){
				alert("인증번호가 발송되었습니다. 메일을 확인 해 주세요.");
				$("#certiNumChk").val(resData);
			}
			
			
		}, 
		error : function(xhr, status, e){ 
			console.log(status);
		} 
	});
}

//인증번호 확인
function chkCertiNum(){
	var certiNumChk = $("#certiNumChk").val();
	var certiNum = $("#certiNum").val();
	
	if(certiNum != null && certiNum != ""){
		if(certiNumChk == certiNum){
			alert("인증되었습니다.");
			$("#certi_ok").val('Y');
			
		}else{
			alert("인증번호가 일치하지 않습니다.");
			$("#certi_ok").val('N');
		}
	}else{
		alert("인증번호를 입력 해 주세요.");
		$("#certi_ok").val('N');
	}
	
}

//사업자등록번호 체크
function regNumberChk(regNumber){
	console.log(regNumber);
    var valueMap = regNumber.replace(/-/gi, '').split('').map(function(item) {
        return parseInt(item, 10);
    });

    if (valueMap.length === 10) {
        var multiply = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5);
        var checkSum = 0;

        for (var i = 0; i < multiply.length; ++i) {
            checkSum += multiply[i] * valueMap[i];
        }

        checkSum += parseInt((multiply[8] * valueMap[8]) / 10, 10);
        return Math.floor(valueMap[9]) === ( (10 - (checkSum % 10)) % 10);
    }

    return false;

}

//사업자등록번호 자동 하이푼
//000-00-00000
function licenseNum(str){
    
	str = str.replace(/[^0-9]/g, '');
    
	var tmp = '';
    
	if( str.length < 4){
        return str;
    }else if(str.length < 7){
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3);
        return tmp;
    }else if(str.length < 13){
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 2);
        tmp += '-';
        tmp += str.substr(5);
        return tmp;
    }
    
    return str;
}

//전화번호
function autoHypenPhone(str){
		
        str = str.replace(/[^0-9]/g, '');
        
        var tmp = '';
        
        if( str.length < 4){
            return str;
        }else if(str.length < 7){
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3);
            return tmp;
        }else if(str.length < 11){
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3, 3);
            tmp += '-';
            tmp += str.substr(6);
            return tmp;
        }else{              
            tmp += str.substr(0, 3);
            tmp += '-';
            tmp += str.substr(3, 4);
            tmp += '-';
            tmp += str.substr(7);
            return tmp;
        }
        
        return str;
      
}






//회원가입 submit 값체크
function inputChk(){
	var id_ok	=	$("#id_ok").val();		//아이디 중복 확인
	var certi_ok = $("#certi_ok").val();	//이메일 인증 확인
	var reg_type = ${regType};
	var regnumber_ok = $("#regnumber_ok").val();	//사업자 등록번호 인증 확인
	
	var memberPwd = $("memberPwd").val();
	var memberPwd2 = $("#memberPwd2").val();

	if(reg_type==1){		//일반회원
		if(id_ok=='N'){
			alert("다른 아이디를 사용 해 주세요.");
			return false;
		}
		if(certi_ok=='N'){
			alert('이메일 인증을 진행 해 주세요.');
			return false;
		}
		
		if(memberPwd.length < 6 || memberPwd.length >=20 ){
			alert('비밀번호는 6자 이상, 20자 미만으로 입력 해 주세요.');
			return false;
		}
		
		if(memberPwd != memberPwd2){
			alert('비밀번호가 일치하지 않습니다.');
			return false;
		}
		
	}else{					//기업회원
		var com_name = $("#comName").val();
		var ceo_name = $("#ceoName").val();
		
		if(id_ok=='N'){
			alert("다른 아이디를 사용 해 주세요.");
			return false;
		}
		if(certi_ok=='N'){
			alert('이메일 인증을 진행 해 주세요.');
			return false;
		}
		if(regnumber_ok == 'N'){
			alert('사업자 등록번호가 유효하지 않습니다.');
			return false;
		}
		
		
		if(memberPwd.length < 6 || memberPwd.length >=20 ){
			alert('비밀번호는 6자 이상, 20자 미만으로 입력 해 주세요.');
			return false;
		}
		
		if(memberPwd != memberPwd2){
			alert('비밀번호가 일치하지 않습니다.');
			return false;
		}
		
		if(com_name == ""){
			alert("기업명을 입력 해 주세요.");
			return false;
		}
		if(ceo_name == ""){
			alert("대표자명을 입력 해 주세요.");
			return false;
		}
		
		
	}
	
}

</script>

<c:import url="/WEB-INF/views/include/headend.jsp" />

<style>
	.mgt-10{
		margin-top:10%;
	}
	
	.mgb-10{
		margin-bottom:10%;
	}
	
	.mytab-ul{
		padding:0 0 0 0;
		list-style:none;
		float:left;
		width:100%;
		height:50px;
	}
	.mytab-li{
		float:left;
		border:1px solid #6c757d;
		width:50%;
		height:50px;
		text-align:center;
		line-height:45px;
	}
	
	.activeTab{
		background-color:gray;
	}
	
	.mytab-li a{
		text-decoration:none !important;
		color:black !important;
	}	
	
	.chkmessage{
		font-size:0.8em;
		
	}
</style>

<body>

<c:import url="/WEB-INF/views/include/navi.jsp" />
	


  <!-- Page Content -->
  <div class="container">
    <!-- Page Heading/Breadcrumbs -->
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-8 mx-auto">
        <div class="card card-signin mgt-10 mgb-10">
          <div class="card-body">
            <h3 class="card-title text-center">회원가입</h3>
           
              <div class="row mb-4 mt-4 text-center">
				<ul class="mytab-ul">

					<li class="mytab-li" <c:if test="${regType==1}"> style="background-color:gray;" </c:if>>
						<a href="${pageContext.request.contextPath }/member/register.do">일반회원</a>
					</li>
					<li class="mytab-li" <c:if test="${regType==2}"> style="background-color:gray;" </c:if>>
						<a href="${pageContext.request.contextPath }/member/register.do?regType=2">기업회원</a>
					</li>
				</ul>
              </div>
              
              <!-- 일반회원 -->
             	<c:if test="${regType ==1}">
             	
             	  <form name="memberFrm" action="/jobsearch/member/insertMember.do" method="post" onsubmit="return inputChk();">
             	  <input type="hidden" value="${regType }" name="regType">
             	  
             	  <input type="hidden" value="N" name="id_ok" id="id_ok">
             	  <input type="hidden" value="N" name="certi_ok" id="certi_ok">
             	  
             	  
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">아이디  </div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="email" id="memberId" name="memberId" class="form-control" placeholder="test@abc.com" required autofocus>
		              <div id="idchkdiv" class="chkmessage"> </div>
		            </div>
	              </div>
	            
	              <div class="row mb-4 mt-4" id="certiDiv" style="display:none;">
	              	<div class="col-lg-4">인증번호  </div>
		            <div class="col-lg-4 form-label-group mb-2">
		              <input type="hidden" id="certiNumChk" name="certiNumChk">
		              <input type="text" id="certiNum" name="certiNum" class="form-control" placeholder="" required autofocus>
		            </div>
		            <div class="col-lg-4 certi-btn">
		            	<a href="#" class="btn btn-primary" onclick="certificationEmail()">인증번호받기</a>
		            	<a href="#" class="btn btn-success" onclick="chkCertiNum()">인증</a>
		            </div>
	              </div>	              
	              
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">비밀번호 </div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="password" id="memberPwd" name="memberPwd" class="form-control" placeholder="6자 이상 15자 미만" required>
		            </div>
	              </div>     
	              
				  <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">비밀번호 확인</div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="password" id="memberPwd2" name="memberPwd2" class="form-control" placeholder="6자 이상 15자 미만" required>
		            </div>
	              </div>     	              
	
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">이름 </div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="text" id="memberName" name="memberName" class="form-control" placeholder="" required>
		            </div>
	              </div>
	              
	               <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">휴대폰번호</div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="text" id="phone" name="phone" class="form-control" placeholder="010-1234-5678" maxlength="13">
		            </div>
	              </div>    
	              
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">성별</div>
	              	<div class="col-lg-8">
	              		<div class="row">
		              		<div class="col-lg-4">
		              			<label for="genderType1"><input type="radio" name="genderType" id="genderType1" value="M" checked>남자</label>
		              		</div>
		              		<div class="col-lg-4">
		              			<label for="genderType2"><input type="radio" name="genderType" id="genderType2" value="W">여자</label>
		              		</div>	
	              		</div>
	              	</div>
	              </div> 
	              
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">생년월일</div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="text" id="birthday" name="birthday" class="form-control" readonly>
		            </div>
	              </div>	              
	              
	              <div class="row mb-4 mt-4">
		              	<div class="col-lg-4">주소 </div>
			            <div class="col-lg-4 form-label-group mb-2">
			              <input type="text" id="zipCode" name="zipCode" class="form-control" placeholder="우편번호" required readonly>
			            </div>
			            <div class="col-lg-4"><a href="#" class="btn btn-primary" onclick="sample3_execDaumPostcode()">검색</a></div>
			        
		              	<div class="col-lg-4"> </div>
			            <div class="col-lg-8 form-label-group mb-2">
			              <input type="text" id="address" name="address" class="form-control" placeholder="주소" required>
			            </div>
			            <div class="col-lg-4"> </div>
			            <div class="col-lg-8 form-label-group mb-2">
			              <input type="text" id="detailAddress" name="detailAddress" class="form-control" placeholder="상세주소" required>
			            </div>
			            <div class="col-lg-4"> </div>
			            <div class="col-lg-8 form-label-group mb-2">
			              <input type="text" id="extraAddress" name="extraAddress" class="form-control" placeholder="참고항목" required>
			            </div>
	              </div>
	
					<div id="wrap" style="display:none;border:1px solid;width:100%;height:150px;margin:5px 0;position:relative">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" 
						style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
	            </div>
	              
	              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">회원가입</button>
           	 	</form>   
          	 
          	 </c:if>
	     	  <!-- 일반회원 끝 -->     
	     	 
	     	 
	     	 
	     	 <!-- 기업회원 --> 
	     	 <c:if test="${regType ==2}">
	     	 	<form name="companyMember" method="post" action="/jobsearch/member/insertMember.do" onsubmit="return inputChk();">
	     	 	 <input type="hidden" value="${regType }" name="regType">
	     	 	 <input type="hidden" value="N" name="id_ok" id="id_ok">
             	 <input type="hidden" value="N" name="certi_ok" id="certi_ok">
             	 <input type="hidden" value="N" name="regnumber_ok" id="regnumber_ok">
             	  
	     	 		<!-- 회사정보 -->
	              <div class="row mb-4 mt-4">
	              	<!-- 회원 가입시 tbl_company insert -->
	              	<div class="col-lg-4">사업자등록번호  </div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="text" id="comRegnumber" name="comRegnumber" class="form-control" maxlength="12" placeholder="000-00-00000" required autofocus>
		              <div id="regNumberDiv"></div>
		            </div>
		         
	              </div>
	              
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">기업명</div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="text" id="comName" name="comName" class="form-control" placeholder="" required autofocus>
		            </div>
	              </div>
	              
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">대표자명</div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="text" id="ceoName" name="ceoName" class="form-control" placeholder="" required autofocus>
		            </div>
	              </div>
	              <!-- 회원 가입시 tbl_company insert -->
	              
	              <!-- 회원 가입시 tbl_member insert -->
	              <div class="row mb-4 mt-4">
		              	<div class="col-lg-4">기업주소지 </div>
			            <div class="col-lg-4 form-label-group mb-2">
			              <input type="text" id="zipCode" name="zipCode" class="form-control" placeholder="우편번호" required readonly>
			            </div>
			            <div class="col-lg-4"><a href="#" class="btn btn-primary" onclick="sample3_execDaumPostcode()">검색</a></div>
			        
		              	<div class="col-lg-4"> </div>
			            <div class="col-lg-8 form-label-group mb-2">
			              <input type="text" id="address" name="address" class="form-control" placeholder="주소" required>
			            </div>
			            <div class="col-lg-4"> </div>
			            <div class="col-lg-8 form-label-group mb-2">
			              <input type="text" id="detailAddress" name="detailAddress" class="form-control" placeholder="상세주소" required>
			            </div>
			            <div class="col-lg-4"> </div>
			            <div class="col-lg-8 form-label-group mb-2">
			              <input type="text" id="extraAddress" name="extraAddress" class="form-control" placeholder="참고항목" required>
			            </div>
	              </div>
	
				  <div id="wrap" style="display:none;border:1px solid;width:100%;height:150px;margin:5px 0;position:relative">
						<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" 
						style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				  </div>

	            		  
				  <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">담당자명</div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="text" id="memberName" name="memberName" class="form-control" placeholder="" required autofocus>
		            </div>
	              </div>	              
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">담당자 전화번호</div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="text" id="phone" name="phone" class="form-control" placeholder="010-1234-5678" maxlength="13">
		            </div>
	              </div>
				  
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">아이디  </div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="email" id="memberId" name="memberId" class="form-control" placeholder="test@abc.com" style="width:200px;" required autofocus>
		              <span id="idchkdiv" class="chkmessage"></span>
		            </div>
	              </div>
	              
	              <div class="row mb-4 mt-4" id="certiDiv" style="display:none;">
	              	<div class="col-lg-4">인증번호  </div>
		            <div class="col-lg-4 form-label-group mb-2">
		              <input type="hidden" id="certiNumChk" name="certiNumChk">
		              <input type="text" id="certiNum" name="certiNum" class="form-control" placeholder="" required autofocus>
		            </div>
		            <div class="col-lg-4 certi-btn">
		            	<a href="#" class="btn btn-primary" onclick="certificationEmail()">인증번호받기</a>
		            	<a href="#" class="btn btn-success" onclick="chkCertiNum()">인증</a>
		            </div>
	              </div>	              
	              
	              <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">비밀번호 </div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="password" id="memberPwd" name="memberPwd" class="form-control" placeholder="6자 이상 15자 미만" required>
		            </div>
	              </div>     
	              
				  <div class="row mb-4 mt-4">
	              	<div class="col-lg-4">비밀번호 확인</div>
		            <div class="col-lg-8 form-label-group mb-2">
		              <input type="password" id="memberPwd2" name="memberPwd2" class="form-control" placeholder="6자 이상 15자 미만" required>
		            </div>
	              </div>   
	              
	              <!-- 회원 가입시 tbl_member insert -->  	              
	
	              
	              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">회원가입</button>
	              
           	 	</form>   
	     	 
	     	  
	     	 </c:if>   
	     	 <!-- 기업회원 끝 -->   
          </div>
        </div>
      </div>
    

    </div>

  </div>
  <!-- /.container -->
  
  
  
  
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipCode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script> 
  

	<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>

</html>
