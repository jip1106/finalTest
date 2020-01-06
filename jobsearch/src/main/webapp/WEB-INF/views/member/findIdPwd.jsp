<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<c:import url="/WEB-INF/views/include/header.jsp" />
<c:import url="/WEB-INF/views/include/headend.jsp" />

<style>
	.mgt-30{
		margin-top:30%;
	}
	
	.mgb-30{
		margin-bottom:30%;
	}
	
	.mgt-20{
		margin-top:20%;
	}
	
	.mgb-20{
		margin-bottom:20%;
	}
	
	.mgt-10{
		margin-top:10%;
	}
	
	.mgb-10{
		margin-bottom:10%;
	}
	
	.findspan a{
		text-decoration:none;
	}
</style>

<script>
	$(function(){
		$("#phone").keyup(function(){
			var hypenPhone = autoHypenPhone($(this).val());
			//console.log(hypenPhone);
			$(this).val(hypenPhone);
		})
			
	})
	
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
	
	function findIdFnc(){
		var memberName = $("#memberName").val();
		var phone = $("#phone").val();
		var requestData = {"memberName":memberName , "phone":phone};
		$.ajax({
			type:"POST",
			url:'/jobsearch/member/findId.do',
			data:requestData,
			dataType : "json",
			cache : false,
			success : function(resData){
				
				console.log(resData);
				
				if(resData.length==0){
					$("#findUserId").css("color","red");
					$("#findUserId").html("일치하는 회원정보가 없습니다.");
				}else{
					var memberId = resData[0]["MEMBER_ID"];
					var regType = resData[0]["REG_TYPE"];
					console.log(regType);
					var sRegType = regType==1?"일반회원":"기업회원";
					
					$("#findUserId").css("color","green");
					$("#findUserId").html("회원님의 id는 : " + memberId + "<br>회원유형은 " + sRegType +" 입니다.");
				}
			},
			error: function(xhr, status, e){
				
			}
		})
	}
	
	function findPwdFnc(){
		var memberId = $("#memberId").val();
		
		$.ajax({
			type:"POST",
			url:'/jobsearch/member/dupchk.do',
			data:{"memberId":memberId},
			dataType : "json",
			cache : false,
			success : function(resData){
				
				if(resData==1){
					sendMailPwd(memberId);
				}else{
					$("#findUserPwd").css("color","red");
					$("#findUserPwd").html("회원 정보가 존재하지 않습니다.");
				}
			},
			error: function(xhr, status, e){
				
			}
		})
	}
	
	//비밀번호 수정
	function sendMailPwd(memberId){
		
		$.ajax({
			type:"POST",
			url:'/jobsearch/member/sendPwdMail.do',
			data:{"memberId":memberId},
			dataType : "json",
			cache : false,
			success : function(resData){
				
				if(resData > 0){
					$("#findUserPwd").css("color","green");
					$("#findUserPwd").html("등록하신 메일으로 임시 비밀번호가 발송 되었습니다.<br> 확인 후 로그인 해 주세요.");
				}

			},
			error: function(xhr, status, e){
				
			}
		})		
		
	}
	
</script>

<body>

<c:import url="/WEB-INF/views/include/navi.jsp" />

  <!-- Page Content -->
  <div class="container">
    <!-- Page Heading/Breadcrumbs -->
    
    <div class="row">
    
	    <div class="col-lg-12 col-md-12 col-sm-6">
	      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
	        <div class="card card-signin mgt-10 mgb-10">
	          <div class="card-body">
	            <h3 class="card-title text-center">아이디 찾기</h3>
	           
	            <form name="findId" class="form-signin" method="post" action="">
	              
	              <div class="form-label-group mb-4">
	                <input type="text" id="memberName" name="memberName" class="form-control" placeholder="이름" required autofocus>
	              </div>
	
	              <div class="form-label-group mb-4">
	                <input type="text" id="phone" name="phone" class="form-control" placeholder="010-000-0000" required autofocus>
	              </div>
	              
	              <div class="row mt-4 mb-4">
	              	<div class="col">
	              		<span style="font-size:0.8em;">회원가입시 입력했던 이름, 번호를 입력 해 주세요.</span>
	              	</div>

	              </div>
	              
	              <div class="row mt-4 mb-4">
	              	<div class="col">
	              		<span style="color:red; font-size:0.8em;" id="findUserId">
	              		
	              		</span>
	              	</div>
	              </div>	              
	              
	              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="button" onclick="findIdFnc();">찾기</button>

	            </form>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	    <div class="col-lg-12 col-md-12 col-sm-6">
	      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
	        <div class="card card-signin mgt-10 mgb-10">
	          <div class="card-body">
	            <h3 class="card-title text-center">비밀번호 찾기</h3>
	           
	            <form class="form-signin" method="post" action="">
	              
	              <div class="form-label-group mb-4">
	                <input type="email" id="memberId" name="memberId" class="form-control" placeholder="id를 입력 해 주세요." required autofocus>
	              </div>
	              
	              <div class="row mt-4 mb-4">
	              	<div class="col">
	              		<span style="color:red; font-size:0.8em;" id="findUserPwd">
	              		
	              		</span>
	              	</div>
	              </div>	
	              
	              
	              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="button" onclick="findPwdFnc()">찾기</button>
	            </form>
	          </div>
	        </div>
	      </div>
	    </div>	    



    </div>


  </div>
  <!-- /.container -->

	<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>

</html>
