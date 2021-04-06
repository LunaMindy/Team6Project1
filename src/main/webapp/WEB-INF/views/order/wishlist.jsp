<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
        <link href="<%=application.getContextPath() %>/resources/css/mypage.css" rel="stylesheet" type="text/css"/>
        <link href="<%=application.getContextPath() %>/resources/css/wishlist.css" rel="stylesheet" type="text/css"/>


   <!-- 컨텐츠 -->
    <div class="container-fluid">
    

            <!-- 마이페이지 타이틀 -->
            <div>
                <h3 id="mypageTitle">MY PAGE</h3>
            </div>

            <!-- 마이페이지 탭 목록 -->
            <div id="mypageList" style="height: 42px;">
                <a href="<%=application.getContextPath() %>/user/purchaselist" class="mypage-tab">구매내역</a>
                <a href="<%=application.getContextPath() %>/user/wishlist" class="mypage-tab-clicked">위시리스트</a>
                <a href="<%=application.getContextPath() %>/user/changeinfo" class="mypage-tab">개인정보수정</a>
                <a href="<%=application.getContextPath() %>/user/withdrawal" class="mypage-tab">회원탈퇴</a>
                <a href="<%=application.getContextPath()%>/faq" class="mypage-tab">FAQ</a>
            </div>

             <div class="wishlist">
                <div class="wishlist-path">
                    <p>마이페이지 > 위시리스트</p>
                </div>
            </div>
                   
            <div class="wishlist-wrapper">
        	   
                <!--카테고리 12개-->
                <div class="row">
          
                <c:forEach var="wishlist" items="${list}">
                    <div class="col-3">
                        <a href="<%=application.getContextPath() %>/product?productNo=${wishlist.productNo}">
                            <div class="wishlist-product">
                              <img src="<%=application.getContextPath()%>/getphoto?cno=${wishlist.productCategoryNo}&imgSname=${wishlist.imgSname}&imgType=${wishlist.imgType}"> 
                            </div>
                        </a>
                        <div class="wishlist-title">
                            <p>${wishlist.productName} </p>
	                          <a class="btn btn-primary bt-sm " href="delwishlist?productNo=${wishlist.productNo}">삭제</a>
                           </p>
                        </div>
                    </div>
                    
                  </c:forEach> 
                  
        
         </div>
         
         <c:if test="${size != 0}">
	      <div class="col text-center">
	      	<div class="d-flex">
	      		<div class="flex-grow-1">
			         <a class="btn btn-outline-primary btn-sm"
			           href="wishlist?pageNo=1&userId=${userId}">처음</a>
			            
			         <c:if test="${pager.groupNo>1}">
			            <a class="btn btn-outline-info btn-sm"
			            href="wishlist?pageNo=${pager.startPageNo-1}&userId=${userId}">이전</a>
			         </c:if>
			         
			         <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
			            <c:if test="${pager.pageNo == i}">
			               <a class="btn btn-outline-success btn-sm" 
			                  href="wishlist?pageNo=${i}&userId=${userId}">${i}</a>
			            </c:if>
			            <c:if test="${pager.pageNo != i}">
			               <a class="btn btn-outline-danger btn-sm" 
			                  href="wishlist?pageNo=${i}&userId=${userId}">${i}</a>
			            </c:if>
			         </c:forEach>
			         
			         <c:if test="${pager.groupNo<pager.totalGroupNo}">
			            <a class="btn btn-outline-info btn-sm"
			            href="wishlist?pageNo=${pager.endPageNo+1}&userId=${userId}">다음</a>
			         </c:if>
			            
			         <a class="btn btn-outline-primary btn-sm"
			            href="wishlist?pageNo=${pager.totalPageNo}&userId=${userId}">맨끝</a>
			         <!-- [처음][이전] 1 2 3 4 5 [다음][맨끝] -->
		         </div>
		     
		      </div>
	
             </div>
         </c:if>
       </div>
   </div>
         

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


