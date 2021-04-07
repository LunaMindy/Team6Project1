<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
        <link href="<%=application.getContextPath() %>/resources/css/purchaseList.css" rel="stylesheet" type="text/css"/>
        <link href="<%=application.getContextPath() %>/resources/css/mypage.css" rel="stylesheet" type="text/css"/>


<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/review.js"></script>

  <!-- 컨텐츠 -->
  <div >
	   <!-- 마이페이지 타이틀 -->
	  <div >
	      <h3 id="mypageTitle">MY PAGE</h3>
	  </div>

      <!-- 마이페이지 탭 목록 -->
      <div id="mypageList">
          <a href="<%=application.getContextPath()%>/user/purchaselist" class="mypage-tab-clicked">구매내역</a>
          <a href="<%=application.getContextPath()%>/user/wishlist" class="mypage-tab">위시리스트</a>
          <a href="<%=application.getContextPath()%>/user/changeinfo" class="mypage-tab">개인정보수정</a>
          <a href="<%=application.getContextPath()%>/user/withdrawal" class="mypage-tab">회원탈퇴</a>
          <a href="<%=application.getContextPath()%>/faq" class="mypage-tab">FAQ</a>
      </div>
  </div>

	<!-- 구매내역 -->
   <div class="container-fluid border">
       <h3 id="mypageTitle-under">구매내역</h3>
       <hr/>
       
       	<c:if test="${size eq 0}">
             <div style="border:1px solid #f3f3f3; background-color:#f3f3f3; padding-left:38%; height:300px; margin-bottom:1%;">
             	<h1 style="padding-left:15%; margin-top:10%;">
             		<i class="bi bi-bucket"></i>
             	</h1>
          	 	<P style="padding-top:3%; font-size:2em;">구매내역이 없습니다.</P>
      		 </div>
		</c:if>
		
		<c:if test="${size eq 1}">
       
	       <c:forEach var="order" items="${list}">
	       	<form method="post" action="<%=application.getContextPath()%>/user/exchangerefund?orderNo=${order.orderNo}">
	       		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	       		<div class="row purchaseContent">
			           <div class="col purchase-details">
			               <input type="hidden" name="orderNo" value="${order.orderNo}">	               
			               <p>주문일자 : <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></p>
			               <p>주문번호 : ${order.orderNo}</p>
			               <p>주문가격 : ${order.allPrice}</p>
			               <p>선택옵션 : 단일품목</p>
			           </div>
			           
			           <div class="col">
			               <a href="<%=application.getContextPath()%>/user/purchaselistdetail?orderNo=${order.orderNo}" 
			               class="exchange-btn1">주문상세정보</a>
			           </div>
			           
	           		 	<c:if test="${order.orderState eq 0}">
	                   	 	 <div class="col">
	                   	 	   <button class="exchange-btn2" type="submit">교환/환불/구매취소</button>                        
	                   		 </div>
	                	 </c:if>
	                	 <c:if test="${order.orderState eq 1}">
	                    	 <div class="col">
	                    	   <button class="exchange-btn2" type="button" onclick="alert('이미 구매 취소된 주문입니다.')">교환/환불/구매취소</button>                        
	                    	</div>
	                	 </c:if>
			       </div>
	       	</form>
	
	       </c:forEach>
		<c:if test="${size != 0}">  
	      <div class="text-center">
	      	<div class="d-flex">
	      		<div class="flex-grow-1">
			         <a class="btn btn-outline-primary btn-sm"
			           href="purchaselist?pageNo=1&userId=${userId}">처음</a>
			            
			         <c:if test="${pager.groupNo>1}">
			            <a class="btn btn-outline-info btn-sm"
			            href="purchaselist?pageNo=${pager.startPageNo-1}&userId=${userId}">이전</a>
			         </c:if>
			         
			         <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
			            <c:if test="${pager.pageNo == i}">
			               <a class="btn btn-outline-success btn-sm" 
			                  href="purchaselist?pageNo=${i}&userId=${userId}">${i}</a>
			            </c:if>
			            <c:if test="${pager.pageNo != i}">
			               <a class="btn btn-outline-danger btn-sm" 
			                  href="purchaselist?pageNo=${i}&userId=${userId}">${i}</a>
			            </c:if>
			         </c:forEach>
			         
			         <c:if test="${pager.groupNo<pager.totalGroupNo}">
			            <a class="btn btn-outline-info btn-sm"
			            href="purchaselist?pageNo=${pager.endPageNo+1}&userId=${userId}">다음</a>
			         </c:if>
			            
			         <a class="btn btn-outline-primary btn-sm"
			            href="purchaselist?pageNo=${pager.totalPageNo}&userId=${userId}">맨끝</a>
			         <!-- [처음][이전] 1 2 3 4 5 [다음][맨끝] -->
		         </div>
		     
		      </div>
	    
    	</div>

    	</c:if>
 	</c:if>
     		
 
	</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


