
var result = true;
var pwckCheck = false;
		
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
			
			const changeInfoValidate = () => {
				event.preventDefault();
			
			
				//유효성 검사 코드
				var data = {
					userId : $("#userId").val(),
					userName : $("#userName").val(),
					userPassword : $("#userPassword").val(),
					zipCode : $("#zipCode").val(),
					roadAddress : $("#roadAddress").val(),
					detailAddress : $("#sample4_detailAddress").val(),
					userPhone : $("#userPhone").val()	
				}
			
				
				if(data.userName == ""){
			         result = false;
			         $("#errorName").html("필수 사항입니다.");
			    } 
			      
				
				if (data.userPassword == "") {
					result = false;
					$("#SamePassword").css('display', 'none');
			        $("#nonSamePassword").css('display', 'none');
					$("#errorPassword").html("비밀번호를 입력하세요.");
					$("#errorPassword").css('display', 'block');
					
				}
				
				if(data.userPhone == "") {
					result = false;
					$("#errorPhone").html("필수 사항입니다.");
				}else if(data.userPhone.length > 13){
			    	 result = false;
			         $("#errorPhone").html("정확한 번호를 입력해주세요.");
			    }
				
				if (data.detailAddress == "") {
					result = false;
					$("#errorDetailAddress").html("필수 사항입니다.");
				}
				
			
				if (result && pwckCheck) {
						swal({
						  title: "개인정보 수정",
						  text: "정말 수정하시겠습니까?",
						  buttons: true,
						  dangerMode: true,
						})
						.then((willDelete) => {
						  if (willDelete) {
							  $.ajax({
									url: "changeinfo",
									data: data,
									method: "post"
								}).done(data => {
									if(data.result == "success"){
										swal({
										  title: "개인정보 수정",
										  text: "수정이 완료되었습니다. 메인으로 이동하시겠습니까?",
										  buttons: true,
										  dangerMode: false,
										}).then((willDelete) => {
										  if (willDelete) {
											 window.location.href = getContextPath()+'/main';
										  }
										});
									}
								});
						  	}							
						});
					
					
				}
			};
			 