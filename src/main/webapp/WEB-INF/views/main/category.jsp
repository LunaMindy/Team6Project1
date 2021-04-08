<%@ page contentType="text/html; charset=UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 

<%@ page import="java.util.*"%>
<%@ page import="com.mycompany.webapp.dto.*"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<link href="<%=application.getContextPath() %>/resources/css/category.css" rel="stylesheet" type="text/css"/>

<div class="category-content">
            <!-- 컨텐츠 -->
            <div class="container-fluid">
                <div class="new-popular-wrapper">
                    <div class="category-path">
                    <c:if test="${product.categoryName eq '캔들'}">
                    	<p>HOME > CANDLE</p>
                    </c:if>
                    <c:if test="${product.categoryName eq '조명'}">
                    	<p>HOME > LIGHT</p>
                    </c:if>
                    <c:if test="${product.categoryName eq '트리'}">
                    	<p>HOME > TREE</p>
                    </c:if>
                    <c:if test="${product.categoryName eq '기타'}">
                    	<p>HOME > ETC</p>
                    </c:if>
                        
                    </div>
                    <div class="new-popular">
                    	<c:if test="${kind==0}">
							<a class="text" href="<%=application.getContextPath()%>/category?cno=${cno}&kind=12&pageNo=1">new</a>
                        	<a class="text" href="<%=application.getContextPath()%>/category?cno=${cno}&kind=2&pageNo=1">best</a>
						</c:if>
						<c:if test="${kind==1}">
							<a class="text" style="color:red; text-decoration:underline;"href="<%=application.getContextPath()%>/category?cno=${cno}&kind=12&pageNo=1">new</a>
                        	<a class="text" href="<%=application.getContextPath()%>/category?cno=${cno}&kind=22&pageNo=1">best</a>
						</c:if>
						<c:if test="${kind==2}">
							<a class="text" href="<%=application.getContextPath()%>/category?cno=${cno}&kind=12&pageNo=1">new</a>
                        	<a class="text" style="color:red; text-decoration:underline;" href="<%=application.getContextPath()%>/category?cno=${cno}&kind=22&pageNo=1">best</a>
						</c:if>
                    </div>
                </div>
                <div class="product-wrapper">
                    <!--카테고리 12개-->
                    <c:forEach var="product" items="${list}" varStatus="status">
                    	<c:if test="${status.count % 4 eq 1}"> 
						   		<div class="row">     
						</c:if>
								<div class="col-3">
                            		<a href="<%=application.getContextPath() %>/product?productNo=${product.productNo}">
										   	<div class="cetegory-product">
										   		<c:if test="${cno eq 3}"> 
													<img style="height:175%" src="<%=application.getContextPath()%>/getphoto?cno=${cno}&imgSname=${product.imgSname}&imgType=${product.imgType}">
												</c:if>
												<c:if test="${cno != 3}"> 
													<img src="<%=application.getContextPath()%>/getphoto?cno=${cno}&imgSname=${product.imgSname}&imgType=${product.imgType}">
												</c:if>
		                                	</div>
                            		</a>
                            		<c:if test="${cno eq 3}"> 
										<div class="category-title" style="margin-top:50%;">
	                                	<p>${product.productName}</p>
	                                	<p class="price">${product.productPrice}₩</p>
                            			</div>
									</c:if>
									<c:if test="${cno != 3}"> 
										<div class="category-title">
	                                	<p>${product.productName}</p>
	                                	<p class="price">${product.productPrice}₩</p>
                            			</div>
									</c:if>
               			            
                        		</div>
   						<c:if test="${status.count % 4 eq 0}"> 
						   		</div>
						</c:if>
   					</c:forEach>
                    
                </div>
            </div>

            <!--페이징-->
            <table style="margin-left:45%; margin-top:5%;">
		       <tr>
				<td colspan="5" style="text-center;">
						<a class="btn btn-sm page-item"
							href="category?cno=${product.productCategoryNo}&pageNo=1&kind=${kind}">&laquo;</a>

						<c:if test="${pager.groupNo>1}">
							<a class="btn btn-sm page-item"
							href="category?cno=${product.productCategoryNo}&pageNo=${pager.startPageNo-1}&kind=${kind}">before</a>
						</c:if>
						
						<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
							<c:if test="${pager.pageNo == i}">
								<a class="btn btn-sm page-now" 
									href="category?cno=${product.productCategoryNo}&pageNo=${i}&kind=${kind}">${i}</a>
							</c:if>
							<c:if test="${pager.pageNo != i}">
								<a class="btn btn-sm page-item" 
									href="category?cno=${product.productCategoryNo}&pageNo=${i}&kind=${kind}">${i}</a>
							</c:if>
						</c:forEach>
						
						<c:if test="${pager.groupNo<pager.totalGroupNo}">
							<a class="btn btn-sm page-item"
							href="category?cno=${product.productCategoryNo}&pageNo=${pager.endPageNo+1}&kind=${kind}">next</a>
						</c:if>
							
						<a class="btn btn-sm page-item"
							href="category?cno=${product.productCategoryNo}&pageNo=${pager.totalPageNo}&kind=${kind}">&raquo;</a>
								
								<!-- [<<][<] 1 2 3 4 5 [>][>>] -->
					</td>
				</tr>
			</table>
  </div>
  
            

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


