<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="<%=application.getContextPath() %>/resources/css/product.css" rel="stylesheet" type="text/css"/>
<script src="<%=application.getContextPath() %>/resources/js/product/addCartWishlist.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>

function popup(){
	swal({
		  title: "Error",
		  text: "로그인이 필요한 서비스입니다.",
		  dangerMode: true,
		  button: "확인"
		});
}
	
function init () {
	amount = document.amountForm.amount.value;
	change();
}

function add () {
	resultAmount = document.amountForm.amount;
	resultAmount.value ++ ;

};
function del () {
	resultAmount = document.amountForm.amount;
		if (resultAmount.value > 1) {
			resultAmount.value -- ;
		}
};
function change () {
	resultAmount = document.amountForm.amount;
		if (resultAmount.value < 0) {
			resultAmount.value = 0;
		}
};  

//review paging
$(function() {
	getList(${product.productNo}, 1);
});

const getList = (productNo,pageNo) => {
	//console.log(productNo+" "+pageNo);
	$.ajax({
		url:"<%=application.getContextPath()%>/list",
		data:{productNo, pageNo},
		method:"get"
	}).then(data=>{
		 $("#review").html(data); 
		console.log(data);
	}) 
}
</script>

<!--상세페이지를 위한-->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
            rel="stylesheet">
            
       <!-- 컨텐츠 -->
        <div class="container-fluid">
            <!--여기에 작성-->

            <div class="row product-section ">
                <div class="col-md-12">
                    <hr>
                    <h3>| Product |</h3>
                    <hr>
                </div>
                <div class="preview col-md-5" style="float: left; margin-left: 8%;">
                    <div class="preview-pic tab-content">
                    	<c:forEach var="product" items="${list}" varStatus="status">
	                    	<c:if test="${status.count eq 1}"> 
								<div class="tab-pane active" id="pic-1" style="width:80%"><img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${product.imgSname}&imgType=${product.imgType}"/></div>	   		
							</c:if>
							<c:if test="${status.count eq 2}"> 
								<div class="tab-pane" id="pic-2" style="width:80%"><img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${product.imgSname}&imgType=${product.imgType}"/></div>	   		
							</c:if>
							<c:if test="${status.count eq 3}"> 
								<div class="tab-pane" id="pic-3" style="width:80%"><img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${product.imgSname}&imgType=${product.imgType}"/></div>	   		
							</c:if>
							<c:if test="${status.count eq 4}"> 
								<div class="tab-pane" id="pic-4" style="width:80%" ><img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${product.imgSname}&imgType=${product.imgType}"/></div>
							</c:if>
                    	</c:forEach>
                        
                    </div>
                    <ul class="preview-thumbnail nav nav-tabs" style="border:none;">
                    	<c:forEach var="product" items="${list}" varStatus="status">
	                    	<c:if test="${status.count eq 1}"> 
								 <li class="active">
                            		<a data-target="#pic-1" data-toggle="tab"><img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${product.imgSname}&imgType=${product.imgType}"/></a>
                       			 </li>	   		
							</c:if>
							<c:if test="${status.count eq 2}"> 
								<li>
		                            <a data-target="#pic-2" data-toggle="tab"><img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${product.imgSname}&imgType=${product.imgType}"/></a>
		                        </li>	   		
							</c:if>
							<c:if test="${status.count eq 3}"> 
								 <li>
		                            <a data-target="#pic-3" data-toggle="tab"><img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${product.imgSname}&imgType=${product.imgType}"/></a>
		                        </li>	   		
							</c:if>
							<c:if test="${status.count eq 4}"> 
								<li>
		                            <a data-target="#pic-4" data-toggle="tab"><img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${product.imgSname}&imgType=${product.imgType}"/></a>
		                        </li>	   		
							</c:if>
                    	</c:forEach>
                       
                    </ul>
                </div>
                <div
                    class="product-details col-md-6"
                    style="position:relative; left: 2%; top:25%; padding-top: 50px;">
                    <h3 class="product-title" style="padding-left: 0px;">| ${product.productName} |</h3>
                    <h5 class="product-price">price :
                        <span>${product.productPrice}₩</span></h5>
                    <div class="quantity-section">
                        <h5 class="product-quantity">amount
                        </h5>
                    </div>
                    
                    <div class="product-action">
                        <!-- 장바구니 추가 post -->
                    <form id="amountForm" name="amountForm" method="post" action="<%=application.getContextPath()%>/user/addcart" style="display:inline-block" onsubmit="addCartCheck()">
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    	<input type="hidden" id="productNo" name="productNo" value="${product.productNo}" />
                    	<input type="hidden" id="userId" name="userId" value="" />
                    	<input type="hidden" id="price" name="price" value="${product.productPrice}₩" />
                    	<div style="margin-bottom:20%;">
                    		<input type="text" id="amount" name="amount" value="1" size="3" onchange="change()">
												<input type="button" value=" + " onclick="add();">
												<input type="button" value=" - " onclick="del();"><br>
						</div>
											
						<sec:authorize access="isAnonymous()">
                     		<input class="add-to-cart btn btn-default" type="button" value="add to cart" onclick="popup()"/>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
					 		<input class="add-to-cart btn btn-default" type="submit" value="add to cart" />
						</sec:authorize>
					</form>
					<form method="post" action="<%=application.getContextPath()%>/user/addwishlist" style="display:inline-block" onsubmit="addwishlistCheck()">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						<input type="hidden" name="productNo" value="${product.productNo}" />
                    	<input type="hidden" name="userId" value="" />
                    	
                    	<sec:authorize access="isAnonymous()">
                    		<button type="button" class="like btn btn-default" onclick="popup()"><span class="fa fa-heart"></span></button>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
					 		<button type="submit" class="like btn btn-default"><span class="fa fa-heart"></span></button>
						</sec:authorize>
                        
                    </form>
                    </div>
                </div>
            </div>

            <div class="row detail-section">
                <div class="col-md-12">
                    <hr>
                    <h3>| Detail |</h3>
                    <hr>
                </div>
                <div class="col-md-12 product-description" style="margin-top:100px; margin-bottom:50px; padding-left:10%;">
                    <img class="product-img" src="<%=application.getContextPath()%>/getphoto?cno=${product.productCategoryNo}&imgSname=${detailImg.imgSname}&imgType=${detailImg.imgType}" style="padding-left:8%"/>
                </div>
            </div>
			
           
		
           <div id="review"></div>
        </div> 

<%@ include file="/WEB-INF/views/common/footer.jsp"%>


