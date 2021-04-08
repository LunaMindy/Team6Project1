<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
        <link href="<%=application.getContextPath() %>/resources/css/review.css" rel="stylesheet" type="text/css"/>
        <link href="<%=application.getContextPath() %>/resources/css/mypage.css" rel="stylesheet" type="text/css"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
function popup(){
	event.preventDefault();
	swal({
		  title: "리뷰 작성",
		  text: "작성 하시겠습니까?",
		  buttons: true,
		  dangerMode: false,
		}).then((willDelete) => {
		  if (willDelete) {
			 $("#reviewForm")[0].submit(); //form에서 id로 찾아서 사용
		  }
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
          <a href="<%=application.getContextPath()%>/user/purchaselist" class="mypage-tab-clicked">구매내역</a>
          <a href="<%=application.getContextPath()%>/user/wishlist" class="mypage-tab">위시리스트</a>
          <a href="<%=application.getContextPath()%>/user/changeinfo" class="mypage-tab">개인정보수정</a>
          <a href="<%=application.getContextPath()%>/user/withdrawal" class="mypage-tab">회원탈퇴</a>
          <a href="<%=application.getContextPath()%>/user/faq" class="mypage-tab">FAQ</a>
      </div>
  </div>

	<!-- 리뷰 작성 -->
   <div class="container-fluid border">
      <h3 id="mypageTitle-under">리뷰 작성</h3>
      <hr/>
       
       <div class="review-content">
	       	<form id="reviewForm" method="post" action="<%=application.getContextPath()%>/user/createreview">
	       		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	       		<div class="card-body">
	              <div class="input-group form-group">
	              		<a>주문 번호 : ${orderNo}</a>
	                  <input type="hidden" name="orderNo" value="${orderNo}" readonly>
	              </div>
	              <div class="input-group form-group">
	                  <a>상품 번호 : ${productNo}</a>
	                  <input type="hidden" name="productNo" value="${productNo}" readonly>
	              </div>
	
	              <!-- 한 줄 평 작성-->
	              <div class="input-group form-group">
	                  <input type="text" class="form-control" id="review-write" placeholder="한 줄 평 작성 (30자 이내)" name="reviewContent" maxlength='30' onclick="" required>
	              </div>
	          	</div>
	          	
	            <input class="btn review-submit-btn" type="submit" value="게시" onclick="popup()">         
	       </form>
       </div>
       
 
   </div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


