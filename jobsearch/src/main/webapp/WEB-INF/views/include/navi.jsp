<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- Navigation -->
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath }/home.do">JobSearch</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">	
            <a class="nav-link" href="about.html">지역별</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="services.html">직업별</a>
          </li>
          
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              	게시판
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownPortfolio">
              <a class="dropdown-item" href="${pageContext.request.contextPath }/notice/list.do">공지사항</a>
              <a class="dropdown-item" href="portfolio-2-col.html">자유게시판</a>
              <a class="dropdown-item" href="${pageContext.request.contextPath }/faq/list.do">FAQ</a>
            </div>
          </li>

          <li class="nav-item">
            <a class="nav-link" href="contact.html">인재검색</a>
          </li>
          	 
	      <li class="nav-item dropdown">
	      	<%//로그인 X%>
	      	<c:if test="${empty sessionScope.loginMember }">
		  		<a class="nav-link dropdown-toggle" href="#" id="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		        	로그인
		        </a>
		        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownPortfolio">
		        	<a class="dropdown-item" href="${pageContext.request.contextPath }/member/login.do">로그인</a>
		            <a class="dropdown-item" href="${pageContext.request.contextPath }/member/register.do">회원가입</a>
				</div>
		            
			</c:if>
			
			<%//일반회원 %>
	      	<c:if test="${!empty sessionScope.loginMember && sessionScope.loginMember.regType == 1}">
		  		<a class="nav-link dropdown-toggle" href="#" id="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		        	${sessionScope.loginMember.memberName}님
		        </a>
		        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownPortfolio">
		        	<a class="dropdown-item" href="${pageContext.request.contextPath }/member/logout.do">로그아웃</a>
		            <a class="dropdown-item" href="${pageContext.request.contextPath }/member/mypage.do">마이페이지</a>
				</div>
		            
			</c:if>
			
	      	<c:if test="${!empty sessionScope.loginMember && sessionScope.loginMember.regType == 2}">
		  		<a class="nav-link dropdown-toggle" href="#" id="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		        	${sessionScope.loginMember.memberName}님
		        </a>
		        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownPortfolio">
		        	<a class="dropdown-item" href="${pageContext.request.contextPath }/member/logout.do">로그아웃</a>
		            <a class="dropdown-item" href="${pageContext.request.contextPath }/member/commypage.do">기업페이지</a>
				</div>
		            
			</c:if>			
						
	      </li>


        </ul>
      </div>
    </div>
  </nav>