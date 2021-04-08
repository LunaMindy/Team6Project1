<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
        <link href="<%=application.getContextPath() %>/resources/css/mypage.css" rel="stylesheet" type="text/css"/>
        <link href="<%=application.getContextPath() %>/resources/css/wishlist.css" rel="stylesheet" type="text/css"/>


   <!-- 컨텐츠 -->
    <div>
        <!-- 마이페이지 타이틀 -->
        <div>
            <h3 id="mypageTitle">MY PAGE</h3>
        </div>

        <!-- 마이페이지 탭 목록 -->
        <div id="mypageList" style="height: 42px;">
            <a href="<%=application.getContextPath() %>/user/purchaselist?pageNo=1" class="mypage-tab">구매내역</a>
            <a href="<%=application.getContextPath() %>/user/wishlist?pageNo=1" class="mypage-tab-clicked">찜목록</a>
            <a href="<%=application.getContextPath() %>/user/changeinfo" class="mypage-tab">개인정보수정</a>
            <a href="<%=application.getContextPath() %>/user/withdrawal" class="mypage-tab">회원탈퇴</a>
            <a href="<%=application.getContextPath()%>/faq" class="mypage-tab">FAQ</a>
        </div>
     </div>
     
		<div class="container-fluid border">
			<div class="wishlist">
                <div class="wishlist-path">
                    <h3 id="mypageTitle-under">찜목록</h3>
                    
                </div>
            </div>
            <hr/>
            
            <c:if test="${size eq 0}">
            	<div id="wishlist-info">
            		<img id="wishlist-img" src="<%=application.getContextPath()%>/resources/images/위시리스트.png">
		  			<h3 style="margin:0;">찜목록이 비어있습니다.</h3>
            	</div>
            </c:if>
            
            <c:if test="${size != 0}">
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
	                          <a class="btn deletebtn" href="delwishlist?productNo=${wishlist.productNo}">삭제</a>
                           </p>
                        </div>
                    </div>
                    
                  </c:forEach> 
                  
        
         </div>
         
	    <div class="col text-center">
                  <div class="d-flex">
                     <div class="flex-grow-1">
                        <a class="btn btn-sm page-item"
                          href="wishlist?pageNo=1&userId=${userId}">&laquo;</a>
                           
                        <c:if test="${pager.groupNo>1}">
                           <a class="btn btn-sm page-item"
                           href="wishlist?pageNo=${pager.startPageNo-1}&userId=${userId}">before</a>
                        </c:if>
                        
                        <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
                           <c:if test="${pager.pageNo == i}">
                              <a class="btn btn-sm page-now" 
                                 href="wishlist?pageNo=${i}&userId=${userId}">${i}</a>
                           </c:if>
                           <c:if test="${pager.pageNo != i}">
                              <a class="btn btn-sm page-item" 
                                 href="wishlist?pageNo=${i}&userId=${userId}">${i}</a>
                           </c:if>
                        </c:forEach>
                        
                        <c:if test="${pager.groupNo<pager.totalGroupNo}">
                           <a class="btn btn-sm page-item"
                           href="wishlist?pageNo=${pager.endPageNo+1}&userId=${userId}">next</a>
                        </c:if>
                           
                        <a class="btn btn-sm page-item"
                           href="wishlist?pageNo=${pager.totalPageNo}&userId=${userId}">&raquo;</a>
                        <!-- [<<][<] 1 2 3 4 5 [>][>>] -->
                     </div>
                 
                  </div>
         
                </div>
             </div>
         </c:if>
       </div>
         

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


