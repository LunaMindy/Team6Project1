var result = true;
var pwckCheck = false;
var check = true;

	function checkUser(){
		
		event.preventDefault();
		
		var data = {
			userId : $("#userId").val(),
			userName : $("#userName").val(),
			userSsn1 : $("#userSsn1").val(),
			userSsn2 : $("#userSsn2").val()
		}
		
		if(data.userSsn1 == ""){
			data.userSsn1 = 0;
		}
		if(data.userSsn2 == ""){
			data.userSsn2 = 0;
		}
		
		$.ajax({
				url: "checkuser",
				data: data,
				method: "post"
			}).done(data => {
				if(data.result == "success"){
				 	$("#checkUserError").css('display', 'none');
			        $("#checkUserSuccess").css('display', 'block');
					$("#checkUserSuccess").html("확인되었습니다.");
					check = true;
			 	}else{
			 		$("#checkUserSuccess").css('display', 'none');
			        $("#checkUserError").css('display', 'block');
			 		$("#checkUserError").html("회원이 존재하지 않습니다.");
			 		check = false;
			 	}
			});
		}	

		function getContextPath() {
			  var hostIndex = location.href.indexOf( location.host ) + location.host.length;
			  return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
			};
		       
		$(function () {
				$('.passwordCk').on("propertychange change keydown paste input", function () {
			        const userPassword = $('#userPassword').val();
					const userPasswordCk = $('#userPasswordCk').val();    
			
					if (userPassword == "" || userPasswordCk == "") {
						pwckCheck = true;
			            result = false;
			            $("#nonSamePassword").css('display', 'none');
			            $("#SamePassword").css('display', 'none');
						$("#errorPassword").html("비밀번호를 입력하세요.");
					}else if(userPassword == userPasswordCk){
			            pwckCheck = true;
			            result = true;
			            $("#nonSamePassword").css('display', 'none');
			            $("#errorPassword").css('display', 'none');
			            $("#SamePassword").html("비밀번호가 일치합니다.");
			            $("#SamePassword").css('display', 'block');
			        }else{
			            pwckCheck = false;
			            result = false;
			            $("#SamePassword").css('display', 'none');
			            $("#errorPassword").css('display', 'none');
			            $("#nonSamePassword").html("비밀번호가 일치하지 않습니다.");
			            $("#nonSamePassword").css('display', 'block');
			            
			        }
			     });
			});

		 const changePwValidate = () => {
				event.preventDefault();

				//유효성 검사 코드
				var data = {
					userId : $("#userId").val(),
					userPassword : $("#userPassword").val()
				}

				if (data.userPassword == "") {
					result = false;
					$("#SamePassword").css('display', 'none');
		            $("#nonSamePassword").css('display', 'none');
					$("#errorPassword").html("비밀번호를 입력하세요.");
					$("#errorPassword").css('display', 'block');
					
				}
		
				if (result && pwckCheck && check) {
					swal({
						title: "비밀번호 변경",
						text: "정말 변경하시겠습니까?",
						buttons: true,
						dangerMode: true,
					}).then((willDelete) => {
					  if (willDelete) {
						  $.ajax({
								url: "changepassword",
								data: data,
								method: "post"
							}).done(data => {
								if(data.result == "success"){
									swal({
										  title: "비밀번호 변경",
										  text: "수정이 완료되었습니다. 로그인창으로 이동하시겠습니까?",
										  buttons: true,
										  dangerMode: false,
										}).then((willDelete) => {
										  if (willDelete) {
											 window.location.href = getContextPath()+'/auth/login';
										  }
									});
								}
							});
					  	}							
					});
				}
			};