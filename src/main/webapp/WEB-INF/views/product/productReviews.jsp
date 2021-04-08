<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 
<link href="<%=application.getContextPath() %>/resources/css/review.css" rel="stylesheet" type="text/css"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
function popupReview(){
	swal({
		  title: "Error",
		  text: "삭제할 수 없습니다.",
		  dangerMode: true,
		  button: "확인",
		});
}

</script>


<div class="row review-section">
   <div class="col-md-12" >
       <hr>
       <h3 style="display:inline-block;">| Reviews |</h3> 
       <p style="float:right; margin-right:120px;">전체 리뷰 수 : ${size}</p>
       <hr>
   </div>
     
   <c:forEach var="reviews" items="${rlist}">
    	<div class="col-md-12">
	        <div class="row">
	            <div class="col-md-4 review-part-left">
	                <div class="row">
	                    <div class="col-md-4">
	                        <img src="http://placekitten.com/400/252">
	                    </div>
	                    <div class="col-md-4">
	                        <p><fmt:formatDate value="${reviews.reviewRegdate}" pattern="yyyy-MM-dd"/></p>
	                        <span>${reviews.userId}</span><br>
	                    </div>
	                </div>
	            </div>
	            <div class="col-md-6 review-part-right">
	                <p>${reviews.reviewContent}</p>
	            </div>
	            <div class="col-md-2 review-part-right">
	            	<c:if test="${loginId == reviews.userId}">
	            		<a class="btn review-btn" href="<%=application.getContextPath()%>/user/delreview?reviewNo=${reviews.reviewNo}&productNo=${reviews.productNo}">remove</a>
	            	</c:if>
	            	<c:if test="${loginId != reviews.userId}">
	            		<button class="btn review-btn" onclick="popupReview()" type="button">remove</button>
	            	</c:if>			            		                        	                                                 	                         
	            </div>
	        </div>
    	</div>
    </c:forEach>     
   
   <c:if test="${size != 0}">
   	 <div class="col text-center">
		<div class="d-flex">
			<div class="flex-grow-1">							
			<!-- [<<][<] 1 2 3 4 5 [>][>>] -->
				<button class="btn btn-sm page-item"
					onclick="getList(${productNo}, 1)">&laquo;</button>
		
				<c:if test="${pager.groupNo>1}">
				<button class="btn btn-sm page-item"
				onclick="getList(${productNo}, ${pager.startPageNo-1})">before</button>
				</c:if>
		
				<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
					<c:if test="${pager.pageNo!=i}">
						<button class="btn btn-sm page-item"
						onclick="getList(${productNo},${i})">${i}</button>
					</c:if>
					<c:if test="${pager.pageNo==i}">
						<button class="btn btn-sm page-now"
						onclick="getList(${productNo},${i})">${i}</button>
					</c:if>
				</c:forEach>
		
				<c:if test="${pager.groupNo<pager.totalGroupNo}">
					<button class="btn btn-sm page-item"
					onclick="getList(${productNo},${pager.endPageNo+1})">next</button>
				</c:if>
		
				<button class="btn btn-sm page-item"
					onclick="getList(${productNo},${pager.totalPageNo})">&raquo;</button>
			</div>
		</div>
	 </div> 
   </c:if>                   
</div>




