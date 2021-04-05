<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="<%=application.getContextPath() %>/resources/css/category.css" rel="stylesheet" type="text/css"/>


  <div class="category-content">
            <!-- 컨텐츠 -->
            <div class="container-fluid">
                <div class="new-popular-wrapper">
                    <div class="category-path">
                        <p>홈 > 검색</p>
                    </div>
                    
                </div>
                <div class="product-wrapper">
                    <!--카테고리 12개-->
                 
                    <div class="row">
                    	<c:forEach var="search" items="${list}">
                        	<div class="col-3">
                            	<a href="<%=application.getContextPath() %>/product?productNo=${search.productNo}">
                                	<div class="cetegory-product">
                                    	<img src="<%=application.getContextPath() %>/getphoto?imgSname=${search.imgSname}&imgType=${search.imgType}">
                                	</div>
                            	</a>
	                            <div class="category-title">
	                                <p>${search.productName}</p>
	                                <p class="price">${search.productPrice}</p>
	                            </div>
                        	</div>
                     	</c:forEach>     
                  </div>
                    
               </div>   
		      <div class="col text-center">
		      	<div class="d-flex">
		      		<div class="flex-grow-1">
				         <a class="btn btn-outline-primary btn-sm"href="search?pageNo=1&keyword=${keyword}">처음</a>
				         <c:if test="${pager.groupNo>1}">
				            <a class="btn btn-outline-info btn-sm"href="search?pageNo=${pager.startPageNo-1}&keyword=${keyword}">이전</a>
				         </c:if>
				         <c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
				            <c:if test="${pager.pageNo == i}">
				               <a class="btn btn-outline-success btn-sm" href="search?pageNo=${i}&keyword=${keyword}">${i}</a>
				            </c:if>
				            <c:if test="${pager.pageNo != i}">
				               <a class="btn btn-outline-danger btn-sm" 
				                  href="search?pageNo=${i}&keyword=${keyword}">${i}</a>
				            </c:if>
				         </c:forEach>
				         <c:if test="${pager.groupNo<pager.totalGroupNo}">
				            <a class="btn btn-outline-info btn-sm"
				            href="search?pageNo=${pager.endPageNo+1}&keyword=${keyword}">다음</a>
				         </c:if>
				         <a class="btn btn-outline-primary btn-sm"
				            href="search?pageNo=${pager.totalPageNo}&keyword=${keyword}">맨끝</a>
				         <!-- [처음][이전] 1 2 3 4 5 [다음][맨끝] -->
			        </div>
			     
			      </div>
		      </div>
      </div>
 	</div>

            

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


