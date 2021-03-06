<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="<%=application.getContextPath() %>/resources/css/cart.css" rel="stylesheet" type="text/css"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
function popup(){
	swal({
		  title: "Error",
		  text: "장바구니가 비었습니다.",
		  dangerMode: true,
		  button: "확인",
		});
		
}
</script>
  <!-- 컨텐츠 -->
  <div class="cart-content">
     <div class="container-fluid">
          <div class="cart-line">
              <p class="text">장바구니</p>
          </div>
  
		  <c:if test="${size eq 0}">
		  	<div id="cart-info">
		  		<img id="cart-img" src="<%=application.getContextPath()%>/resources/images/카트.png">
		  		<h3 style="margin:0;">장바구니가 비어있습니다.</h3>
		  	</div>
		  </c:if>
		  
		  <c:if test="${size > 0}">	
			<!-- 카트 목록 -->
		      <div class="cart-list">
		       		<table class="cart-table">
		              <thead>
		                  <tr>
		                      <th colspan="2">아이템</th>
		                      <th>가격</th>
		                      <th>수량</th>
		                      <th>총가격</th>
		                      <th>삭제</th>
		                  </tr>
		              </thead>
		               
		              <tbody>   
		              	<c:set var="sum" value="0"/>
		              	<c:set var="count" value="0"/>                      
		              		<c:forEach var="cart" items="${clist}">                        		                       		
		              			<tr>
		                      <td class="cart-img-line">
		                          <a href="<%=application.getContextPath() %>/product?productNo=${cart.productNo}">
		                          	<div class="cart-img">
		                              <img src="<%=application.getContextPath()%>/getphoto?cno=${cart.categoryNo}&imgSname=${cart.imgSname}&imgType=${cart.imgType}">
		                          	</div>
		                          </a>
		                      </td>
		                      <td class="cart-img-name">
		                          <p class="text" style="margin:0;">${cart.productName}</p>
		                      </td>
		                      <td class="cart-img-rightline">${cart.price}</td>
		                      <td class="cart-img-rightline">
		
		                      	<form method="post" action="<%=application.getContextPath()%>/user/updateamount">
		                      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
													<input type="text" name="amount" value="${cart.amount}">
		                      		<input type="hidden" name="productNo" value="${cart.productNo}"/>
		                     			<input type="hidden" name="price"  value="${cart.price}"/>
		                    			<input type="hidden" name="userId" value="${cart.userId}"/>
		                      		<button class="btn btn-sm" type="submit" id="change-cart">변경</button>
		                      	</form>
		                      </td>
		                      <td class="cart-img-rightline">${cart.allPrice}</td>
		                      <td><a class="btn btn-sm" id="delete-cart" href="<%=application.getContextPath()%>/user/delcart?productNo=${cart.productNo}">X</a></td>
		                      <c:set var="sum" value="${sum+cart.allPrice}"/>
		                      <c:set var="count" value="${count+cart.amount}"/>   
		                   </tr>                
		              	</c:forEach>                        
		              </tbody>
		          </table>
		      </div>
          <div class="price-check">          	           	
          		<table class="summary-table">
                  <tr class="one-line">
                      <th colspan="2" class="summary-title">SUMMARY</th>
                  </tr>
                  <tr class="two-line">
                      <td colspan="2">
                          SHOPPING AND TAX</td>
                  </tr>
                  <tr>
                      <td>주문 수량</td>
                      <td>${count}개</td>
                  </tr>
                  <tr class="three-line">
                      <td>주문 금액</td>
                      <td>${sum}₩</td>
                  </tr>
                  <tr>
                      <td>할인 금액</td>
                      <td>0₩</td>
                  </tr>
                  <tr>
                      <td class="estimated-payment">결제 예상 금액</td>
                      <td class="estimated-payment">${sum}₩</td>
                  </tr>
              </table>         

				<!-- 결제세부 창으로 넘어가는 버튼 -->
				
				<form method="post" action="<%=application.getContextPath()%>/user/order">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	   				<c:forEach var="cart" items="${clist}">										
						<input type="hidden" name="productNo" value="${cart.productNo}"/>
						<input type="hidden" name="amount" value="${cart.amount}">
		           		<input type="hidden" name="allPrice"  value="${cart.allPrice}"/>
		         		<input type="hidden" name="productName" value="${cart.productName}"/>
		         		<input type="hidden" name="price" value="${cart.price}"/>
		         		<input type="hidden" name="imgOname" value="${cart.imgOname}"/>
		         		<input type="hidden" name="imgSname" value="${cart.imgSname}"/>
		         		<input type="hidden" name="imgType" value="${cart.imgType}"/>	                  	
					</c:forEach>
					<input type="hidden" name="sum" value="${sum}"/>
	        	<input type="hidden" name="count" value="${count}"/>
	       	 		<button class="btn btn-info btn-lg btn-block" style="background-color:#39613a; border:0;">결제하기</button>
				</form>			 
        	</div>
     
 		 </c:if>
  	</div>
 </div>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>