<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="<%=application.getContextPath() %>/resources/css/mypage.css" rel="stylesheet" type="text/css"/>
<link href="<%=application.getContextPath() %>/resources/css/purchaseListDetail.css" rel="stylesheet" type="text/css"/>
	
	<script type="text/javascript">
		$(document).on('click','#btnRefund',function(e){
			e.preventDefault();
			
			var url="${pageContext.request.contextPath}/exchangerefund";
			
			url = url + "?orderNo="+$('#orderNo'.val();
			
			location.href = url;
			
			console.log(url);
			
		});
	</script>
	
	
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

  <div class="container-fluid border">
     <!-- 구매내역-교환/환불신청 타이틀 -->
     <h3 id="mypageTitle-under">구매 상세 내역</h3>
     <hr/>

     <!-- 구매내역 -->
         <div class="row exchange-box">
         
         	<c:forEach var="orderProducts" items="${list}">
         		<form method="post" action="<%=application.getContextPath()%>/user/review?cno=${orderProducts.productCategoryNo}&orderNo=${orderProducts.orderNo}&productNo=${orderProducts.productNo}" id="detail-box">
         			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
         			<div class="col exchange-content">
	         			<a href="<%=application.getContextPath() %>/product?productNo=${orderProducts.productNo}">
		               <img src="<%=application.getContextPath() %>/getphoto?cno=${orderProducts.productCategoryNo}&imgSname=${orderProducts.imgSname}&imgType=${orderProducts.imgType}"id="changeImg">
	              </a>
	             </div>
	             <div class="col product-details">
								<p>
									상품번호 : ${orderProducts.productNo}<br/>
									주문상품 : ${orderProducts.productName}<br/>
									선택옵션 : 단일품목<br/>
									구매수량 : ${orderProducts.amount}<br/>
									구매가격 : ${orderProducts.price}
             		</p>
	             </div>
	             <div class="col">
		             <c:if test="${orderProducts.reviewState eq 0}">
		             		 <button class="btn btn-sm review-btn" type="submit">리뷰 작성</button> 	
		              </c:if>
	       			</div>
         		</form>
          </c:forEach>
             
 
     </div>
 </div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


