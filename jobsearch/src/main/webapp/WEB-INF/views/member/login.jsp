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
	function inputChk(){
		if($("#memberId").val()==""){
			alert("아이디를 입력 해 주세요.");
			return false;
		}
		if($("#memberPwd").val() == "")){
			alert("비밀번호를 입력 해 주세요.");
			return false;
		}
	}
</script>

<body>

<c:import url="/WEB-INF/views/include/navi.jsp" />


  <!-- Page Content -->
  <div class="container">
    <!-- Page Heading/Breadcrumbs -->
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin mgt-10 mgb-10">
          <div class="card-body">
            <h3 class="card-title text-center">로그인</h3>
           
            <form class="form-signin" method="post" action="<c:url value='/member/loginCheck.do'/>" onsubmit="inputChk();">
              <div class="row mb-4 mt-4 text-center">
              	<div class="col-lg-6">
	              	<label class="radio-inline">
					  <input type="radio" name="regType" id="inlineRadio1" value="1" checked > 일반회원
					</label>
				</div>
				<div class="col-lg-6">	
					<label class="radio-inline">
					  <input type="radio" name="regType" id="inlineRadio2" value="2"> 기업회원
					</label>
				</div>
              </div>
              
              <div class="form-label-group mb-4">
                <input type="email" id="memberId" name="memberId" class="form-control" placeholder="test@abc.com" required autofocus>
              </div>

              <div class="form-label-group mb-4">
                <input type="password" id="memberPwd" name="memberPwd" class="form-control" placeholder="Password" required>
              </div>
              
              <div class="row mb-4 mt-4">
              	<div class="col">
              		<span style="color:red;">${message }</span>
              	</div>
              </div>
			
              <div class="row mb-4">
              	<div class="col-lg-6 text-center">
              	  <span class="findspan"><a href="<c:url value="/member/findIdPwd.do"/>">아이디 찾기</a></span>
              	</div>
              	<div class="col-lg-6 text-center">
              	  <span class="findspan"><a href="<c:url value="/member/findIdPwd.do"/>">비밀번호 찾기</a></span>
              	</div>
              	
              </div>
              
              <button class="btn btn-lg btn-primary btn-block text-uppercase" type="submit">로그인</button>
            </form>
          </div>
        </div>
      </div>
    

    </div>


  </div>
  <!-- /.container -->

	<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>

</html>
