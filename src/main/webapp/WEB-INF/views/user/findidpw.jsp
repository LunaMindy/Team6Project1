<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="<%=application.getContextPath() %>/resources/css/findidpw.css" rel="stylesheet" type="text/css"/>


<!-- 컨텐츠 -->
<div class="login-content">
	<div class="container-fluid">
		<div class="login-wrapper">
			<div class="login-path">
				<p>로그인 > 아이디,비밀번호 찾기</p>
			</div>
		</div>
		<div class="container-find">
			<!-- 아이디찾기 카드 -->
			<div class="d-flex justify-content-around">
				<div class="card-find">
					<div class="card-header">
						<h6>아이디 찾기 / 비밀번호 변경</h6>
					</div>

					<!-- 이름과 전화번호를 데이터베이스와 대조해 아이디 리턴 -->
					<div class="card-body-find">
						<form action="<%=application.getContextPath()%>/findid" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="input-group form-group">
								<input type="text" class="form-control" placeholder="이름"
									id="userName" name="userName">
							</div>

							<div class="input-group form-group">
								<input type="text" class="form-control" placeholder="전화번호"
									id="userPhone" name="userPhone">
							</div>

							<div class="form-group">
								<input type="submit" value="아이디 찾기" class="btn float-right"
									id="find_btn">
							</div>
						</form>
					</div>
				</div>
			</div>

		
		</div>
	</div>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>


