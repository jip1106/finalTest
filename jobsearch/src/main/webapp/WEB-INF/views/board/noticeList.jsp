<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

	<c:import url="/WEB-INF/views/include/header.jsp" />
	
	<c:import url="/WEB-INF/views/include/headend.jsp" />
	<style type="text/css">
		.row {
			height: 415px;
		}
		.card-body {
   			padding: 0.5rem;
		}
		.card-footer:last-child {
			padding: 2px;
			text-align: right;
		}
	</style>
	<div class="container">

  
    <h1 class="mt-4 mb-3">공지사항</h1>

    <ol class="breadcrumb">
      <li class="breadcrumb-item">
        <a href="<c:url value='/home.do'/>">Home</a>
      </li>
      <li class="breadcrumb-item active">notice</li>
    </ol>

    <div class="row">

    
      <div class="col-md-8">

        <!-- 공지사항 목록 반복 -->
        <div class="card mb-4">
          <div class="card-body">
            <p class="card-text">공지사항 제목</p>
          </div>
          <div class="card-footer text-muted">
            <small>공지사항 regdate 2020-02-02</small>
          </div>
        </div>        

        <!-- 페이징 처리 -->
        <ul class="pagination justify-content-center mb-4">
          <li class="page-item">
            <a class="page-link" href="#">&larr; 이전페이지</a>
          </li>
          <li class="page-item disabled">
            <a class="page-link" href="#">다음페이지 &rarr;</a>
          </li>
        </ul>

      </div>

   	
      <div class="col-md-4">

        <!-- 검색(전체) -->
        <div class="card mb-4">
          <h5 class="card-header">검색</h5>
          <div class="card-body">
            <div class="input-group">
              <input type="text" class="form-control" placeholder="검색">
              <span class="input-group-btn">
                <button class="btn btn-secondary" type="button">찾기</button>
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
 

  </div>
	<c:import url="/WEB-INF/views/include/navi.jsp" />

	<c:import url="/WEB-INF/views/include/footer.jsp" />
</body>

</html>