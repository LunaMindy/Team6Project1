<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link href="<%=application.getContextPath() %>/resources/css/mypage.css" rel="stylesheet" type="text/css"/>
<link href="<%=application.getContextPath() %>/resources/css/faq.css" rel="stylesheet" type="text/css"/>


 <div >
	   <!-- 마이페이지 타이틀 -->
	  <div >
	      <h3 id="mypageTitle">MY PAGE</h3>
	  </div>

      <!-- 마이페이지 탭 목록 -->
      <div id="mypageList">
          <a href="<%=application.getContextPath()%>/user/purchaselist?pageNo=1" class="mypage-tab">구매내역</a>
          <a href="<%=application.getContextPath()%>/user/wishlist?pageNo=1" class="mypage-tab">찜목록</a>
          <a href="<%=application.getContextPath()%>/user/changeinfo" class="mypage-tab">개인정보수정</a>
          <a href="<%=application.getContextPath()%>/user/withdrawal" class="mypage-tab">회원탈퇴</a>
          <a href="<%=application.getContextPath()%>/faq" class="mypage-tab-clicked">FAQ</a>
      </div>
  </div>

  <div class="container-fluid">
  
  
			<!-- FAQ -->
             <div class="row">
                <div class="col-lg-8 offset-lg-2">
                    <div class="accordion" id="accordionExample">
                        <h3 style="text-align: center;">FAQ</h3>
                        <div class="card">
                            <div class="card-header" id="headingOne">
								<h2 class="clearfix mb-0">

									<!-- data-target을 통해 내용물이 연결되게 함 -->
									<!-- 처음 기본값은 aria-expended를 false로 default해서 닫혀있게 설정 -->
                                    <a
                                    	class="btn btn-link"
                                        data-toggle="collapse"
                                        data-target="#collapseOne"
                                        aria-expanded="false"
                                        aria-controls="collapseOne"
                                        style="color:#f3f3f3;">[배송]배송완료인데 아직 못 받았어요.
                                        <i class="material-icons">add</i>
                                    </a>
                                </h2>
                            </div>
                            <div
                                id="collapseOne"
                                class="collapse show"
                                aria-labelledby="headingOne"
                                data-parent="#accordionExample">
                                <div class="card-body">택배사 또는 해당 지역의 택배 기사님 사정에 의해 실제 물품 전달일이 1~2일 지연될 수 있습니다. 
                                주문 시 작성하신 수령 정보 및 배송 메시지를 확인바랍니다. 이후에도 수령하지 못하셨다면 
                                고객센터 010-2902-7969 또는 QNA 문의를 통하여 연락 부탁드립니다.
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingTwo">
                                <h2 class="mb-0">
                                    <a
                                        class="btn btn-link collapsed"
                                        data-toggle="collapse"
                                        data-target="#collapseTwo"
                                        aria-expanded="false"
                                        aria-controls="collapseTwo"
                                        style="color:#f3f3f3;">[배송] 주문한 상품이 일부만 도착했어요
                                        <i class="material-icons">add</i>
                                    </a>
                                </h2>
                            </div>
                            <div
                                id="collapseTwo"
                                class="collapse"
                                aria-labelledby="headingTwo"
                                data-parent="#accordionExample">
                                <div class="card-body">[주문 내역 조회]에서 배송 조회가 가능하오니 참고 부탁드리겠습니다.</div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingThree">
                                <h2 class="mb-0">
                                    <a
                                        class="btn btn-link collapsed"
                                        data-toggle="collapse"
                                        data-target="#collapseThree"
                                        aria-expanded="false"
                                        aria-controls="collapseThree"
                                        style="color:#f3f3f3;">[환불] 상품 불량, 오배송 환불
                                        <i class="material-icons">add</i>
                                    </a>
                                </h2>
                            </div>
                            <div
                                id="collapseThree"
                                class="collapse"
                                aria-labelledby="headingThree"
                                data-parent="#accordionExample">
                                <div class="card-body">불량 또는 오배송인 경우 전액 배송비를 부담하여 교환처리 해드립니다. 불량 상품, 오배송이 된 경우라도 제품박스에 송장부착 제품만 보낸 경우
                                교환이 불가능 합니다. 초기 배송된 상태와 같이 이중 포장 부탁드립니다.</div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingFour">
                                <h2 class="mb-0">
                                    <a
                                        class="btn btn-link collapsed"
                                        data-toggle="collapse"
                                        data-target="#collapseFour"
                                        aria-expanded="false"
                                        aria-controls="collapseFour"
                                        style="color:#f3f3f3;">[배송] 주문한 상품과 다른 상품이 배송되었어요.<i class="material-icons">add</i>
                                    </a>
                                </h2>
                            </div>
                            <div
                                id="collapseFour"
                                class="collapse"
                                aria-labelledby="headingFour"
                                data-parent="#accordionExample">
                                <div class="card-body">오배송이 된 경우, 마이페이지>구매내역>교환/환불 요청을 한 뒤, QNA 폼 양식에 따라 문의해 주시면 처리 해드리겠습니다.</div>
                            </div>
                        </div>
						
						<div class="card">
                            <div class="card-header" id="headingFive">
                                <h2 class="mb-0">
                                    <a
                                        class="btn btn-link collapsed"
                                        data-toggle="collapse"
                                        data-target="#collapseFive"
                                        aria-expanded="false"
                                        aria-controls="collapseFive"
                                        style="color:#f3f3f3;">[주문취소/환불] 입금 전 주문취소는 어떻게 하나요?<i class="material-icons">add</i>
                                    </a>
                                </h2>
                            </div>
                            <div
                                id="collapseFive"
                                class="collapse"
                                aria-labelledby="headingFive"
                                data-parent="#accordionExample">
                                <div class="card-body">마이페이지>구매내역에서 주문 취소할 수 있습니다.</div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingSix">
                                <h2 class="mb-0">
                                    <a
                                        class="btn btn-link collapsed"
                                        data-toggle="collapse"
                                        data-target="#collapseSix"
                                        aria-expanded="false"
                                        aria-controls="collapseSix"
                                        style="color:#f3f3f3;">[배송] 잘못된 주소를 입력했습니다. 어떻게 해야 할까요?<i class="material-icons">add</i>
                                    </a>
                                </h2>
                            </div>
                            <div
                                id="collapseSix"
                                class="collapse"
                                aria-labelledby="headingSix"
                                data-parent="#accordionExample">
                                <div class="card-body">구매완료된 후에는 주문 정보 변경이 불가능합니다.</div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header" id="headingSeven">
                                <h2 class="mb-0">
                                    <a
                                        class="btn btn-link collapsed"
                                        data-toggle="collapse"
                                        data-target="#collapseSeven"
                                        aria-expanded="false"
                                        aria-controls="collapseSeven"
                                        style="color:#f3f3f3;">[리뷰] 리뷰를 수정하고 싶습니다. 어디서 해야하나요?<i class="material-icons">add</i>
                                    </a>
                                </h2>
                            </div>
                            <div
                                id="collapseSeven"
                                class="collapse"
                                aria-labelledby="headingSeven"
                                data-parent="#accordionExample">
                                <div class="card-body">리뷰수정은 불가합니다. 해당상세보기에서 리뷰 삭제후, 마이페이지>구매내역>상세보기에서 재등록이 가능합니다.</div>
                            </div>
                        </div>
                        <br/>
                        <br/>


						<!-- Q&A -->
                        <h3 style="text-align: center;">Q&A</h3>


						<!-- form 태그의 action, post, target 기능을 사용해 Q&A 내용을 서버로 전송할 예정 -->
                        <form action="qna" method="POST" >
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text bg-white">
                                                    <i class="fa fa-user"></i>&nbsp
                                                </span>
                                            </div>
                                            <input
                                                name="userId"
                                                type="email"
                                                placeholder="회원아이디"
                                                class="form-control border-left-0"
                                                required="required"
                                               
                                                />
                                        </div>
                                    </div>
                                </div>
                               <div class="col">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text bg-white">
                                                    <i class="fa fa-envelope"></i>
                                                </span>
                                            </div>
                                            <input
                                                name="email"
                                                type="email"
                                                placeholder="이메일"
                                                class="form-control border-left-0"
                                                required="required"
                                             
                                                >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text bg-white">
                                                    <i class="fa fa-envelope"></i>
                                                </span>
                                            </div>
                                            <input
                                                name="qnaTitle"
                                                type="text"
                                                placeholder="제목"
                                                class="form-control border-left-0"
                                                required="required"
                                                >
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <textarea
                                    class="form-control"
                                    id="qnaContent"
                                    name="qnaContent"
                                    rows="5"
                                    placeholder=""
                                    required="required"
                                    ></textarea>
                            </div>

                            <button type="submit" class="btn btn-danger float-right">
                                <i class="fa fa-paper-plane"></i>
                                제출
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

