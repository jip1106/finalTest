<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../admin-include/admin-header.jsp"/>

  <body class="login-bg">
  	<div class="header">
	     <div class="container">
	        <div class="row">
	           <div class="col-md-12">
	              <!-- Logo -->
	              <div class="logo">
	                 <h1><a href="index.html">Bootstrap Admin Theme</a></h1>
	              </div>
	           </div>
	        </div>
	     </div>
	</div>

	<div class="page-content container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-wrapper">
			        <div class="box">
			            <div class="content-wrap">
			            	<form method = "post" action="/jobsearch/member/loginCheck.do" id="frm">
				                <h6>Sign In</h6>
				                <input class="form-control" type="text" placeholder="E-mail address" name="memberId">
				                <input class="form-control" type="password" placeholder="Password" name="memberPwd">
				                <input type="hidden" value="0" name="regType">
				                ${message }
				                <div class="action">
				                    <a class="btn btn-primary signup" href="#" onclick="fncLogin()">Login</a>
				                </div>    
			                </form>            
			            </div>
			        </div>

			    </div>
			</div>
		</div>
	</div>
	
	<script>
		function fncLogin(){
			
			var obj = document.getElementById("frm");
			obj.submit();
		}
	</script>



    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${pageContext.request.contextPath }/resources/admin/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/admin/js/custom.js"></script>
  </body>
</html>