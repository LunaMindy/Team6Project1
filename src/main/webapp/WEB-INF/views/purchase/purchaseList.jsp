<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="<%=application.getContextPath() %>/resources/css/purchaseList.css" rel="stylesheet" type="text/css"/>
<link href="<%=application.getContextPath() %>/resources/css/mypage.css" rel="stylesheet" type="text/css"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
function popup(){
	swal({
		  title: "Error",
		  text: "이미 취소된 구매입니다.",
		  dangerMode: true,
		  button: "확인",
		});
}

</script>


<script type="text/javascript" src="<%=application.getContextPath() %>/resources/js/review.js"></script>

  <!-- 컨텐츠 -->
  <div >
	   <!-- 마이페이지 타이틀 -->
	  <div >
	      <h3 id="mypageTitle">MY PAGE</h3>
	  </div>

      <!-- 마이페이지 탭 목록 -->
      <div id="mypageList">
          <a href="<%=application.getContextPath()%>/user/purchaselist?pageNo=1" class="mypage-tab-clicked">구매내역</a>
          <a href="<%=application.getContextPath()%>/user/wishlist?pageNo=1" class="mypage-tab">찜목록</a>
          <a href="<%=application.getContextPath()%>/user/changeinfo" class="mypage-tab">개인정보수정</a>
          <a href="<%=application.getContextPath()%>/user/withdrawal" class="mypage-tab">회원탈퇴</a>
          <a href="<%=application.getContextPath()%>/faq" class="mypage-tab">FAQ</a>
      </div>
  </div>

	<!-- 구매내역 -->
   <div class="container-fluid border" style="padding-bottom:20px;">
       <h3 id="mypageTitle-under">구매내역</h3>
       <hr/>
       
       	<c:if test="${size eq 0}">
            <div style="border:1px solid #f3f3f3; background-color:#f3f3f3; height:300px; margin-bottom:1%; padding-top:6%;">
             	<h1 style="text-align:center;">
             		<i class="bi bi-bucket"></i>
             	</h1>
          	 	<P style="text-align:center; font-size:2em;">구매내역이 없습니다.</P>
      		 </div>
		</c:if>
		
		<c:if test="${size >= 1}">
       
	       <c:forEach var="order" items="${list}">
	       	<form method="post" action="<%=application.getContextPath()%>/user/exchangerefund?orderNo=${order.orderNo}">
	       		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	       		<div class="row purchaseContent justify-content-md-center">
			           <div class="col-4 purchase-details" style="border-bottom:0.5px solid #d9d9d9;">
			               <input type="hidden" name="orderNo" value="${order.orderNo}">	               
			               <p>주문일자 : <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></p>
			               <p>주문번호 : ${order.orderNo}</p>
			               <p>주문가격 : ${order.allPrice}</p>
			               <p>선택옵션 : 단일품목</p>
			           </div>
			           
			           <div class="col-2" style="padding-top:40px; float:left; border-bottom:0.5px solid #d9d9d9;">
			               <div>
				               <a href="<%=application.getContextPath()%>/user/purchaselistdetail?orderNo=${order.orderNo}" 
				               class="btn purchase-btn">구매상세내역</a>			               
			               </div>
			               <div>
				               <c:if test="${order.orderState eq 0}">
		                   	 	   <button class="btn purchase-btn" type="submit">환불/구매취소</button>
		                	 </c:if>
		                	 <c:if test="${order.orderState eq 1}">
		                    	   <button class="btn purchase-btn" type="button" onclick="popup()">환불/구매취소</button>
		                	 </c:if>
			               </div>
			           </div>
			           
	           		 	
			       </div>
	       	</form>
	
	       </c:forEach>
		<c:if test="${size != 0}">  
	      <div class="text-center">
	      	<div class="d-flex">
	      		<div class="flex-grow-1">
			         <a class="btn btn-sm page-item"
			           href="purchaselist?pageNo=1&userId=${userId}">&laquo;</a>
			            
			         <c:if test="${pager.groupNo>1}">
			            <a class="btn btn-sm page-item"
			            href="purchaselist?pageNo=${pager.startPageNo-1}&userId=${userId}">&lt;</a>
			         </c:if>
			         
			         <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
			            <c:if test="${pager.pageNo == i}">
			               <a class="btn btn-sm page-now" 
			                  href="purchaselist?pageNo=${i}&userId=${userId}">${i}</a>
			            </c:if>
			            <c:if test="${pager.pageNo != i}">
			               <a class="btn btn-sm page-item" 
			                  href="purchaselist?pageNo=${i}&userId=${userId}">${i}</a>
			            </c:if>
			         </c:forEach>
			         
			         <c:if test="${pager.groupNo<pager.totalGroupNo}">
			            <a class="btn btn-sm page-item"
			            href="purchaselist?pageNo=${pager.endPageNo+1}&userId=${userId}">&gt;</a>
			         </c:if>
			            
			         <a class="btn btn-sm page-item"
			            href="purchaselist?pageNo=${pager.totalPageNo}&userId=${userId}">&raquo;</a>
			         <!-- [처음][이전] 1 2 3 4 5 [다음][맨끝] -->
		         </div>
		     
		      </div>
	    
    	</div>

    	</c:if>
 	</c:if>
     		
 
	</div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


