<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="<%=application.getContextPath() %>/resources/css/searchProduct.css" rel="stylesheet" type="text/css"/>


  <div class="category-content">
            <!-- 컨텐츠 -->
            <div class="container-fluid">
                <div class="new-popular-wrapper">
                    <div class="category-path">
                        <p>HOME > SEARCH</p>
                    </div>
                </div>
				<c:if test="${size eq 0}">
	            	<div id="search-info">
	            		<img id="search-img" src="<%=application.getContextPath()%>/resources/images/검색.png">
			  			<h3 style="margin:0;">검색결과가 없습니다.</h3>
	            	</div>
            	</c:if>
          		<c:if test="${size != 0}">	                
	                <div class="product-wrapper">
	                    <!--카테고리 12개-->
	                 
	                    <div class="row">
	                    	<c:forEach var="search" items="${list}">
	                        	<div class="col-3">
	                            	<a href="<%=application.getContextPath() %>/product?productNo=${search.productNo}">
	                                	<div class="cetegory-product">
	                                    	<img src="<%=application.getContextPath() %>/getphoto?cno=${search.productCategoryNo}&imgSname=${search.imgSname}&imgType=${search.imgType}">
	                                	</div>
	                            	</a>
		                            <div class="category-title">
		                                <p>${search.productName}</p>
		                                <p class="price">${search.productPrice}₩</p>
		                            </div>
	                        	</div>
	                     	</c:forEach>     
	                  </div>
	                    
	               </div> 
	                
			      <div class="col text-center">
			      	<div class="d-flex">
			      		<div class="flex-grow-1">
					         <a class="btn btn-sm page-item" href="search?pageNo=1&keyword=${keyword}">&laquo;</a>
					         <c:if test="${pager.groupNo>1}">
					            <a class="btn btn-sm page-item"href="search?pageNo=${pager.startPageNo-1}&keyword=${keyword}">before</a>
					         </c:if>
					         <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
					            <c:if test="${pager.pageNo == i}">
					               <a class="btn btn-sm page-now" href="search?pageNo=${i}&keyword=${keyword}">${i}</a>
					            </c:if>
					            <c:if test="${pager.pageNo != i}">
					               <a class="btn btn-sm page-item" 
					                  href="search?pageNo=${i}&keyword=${keyword}">${i}</a>
					            </c:if>
					         </c:forEach>
					         <c:if test="${pager.groupNo<pager.totalGroupNo}">
					            <a class="btn btn-sm page-item"
					            href="search?pageNo=${pager.endPageNo+1}&keyword=${keyword}">next</a>
					         </c:if>
					         <a class="btn btn-sm page-item"
					            href="search?pageNo=${pager.totalPageNo}&keyword=${keyword}">&raquo;</a>
					        <!-- [<<][<] 1 2 3 4 5 [>][>>] -->
				        </div>
				     
				      </div>
			      </div>
		   </c:if>
      </div>
 	</div>

            

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


