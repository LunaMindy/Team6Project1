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
					$("#checkUser").html("확인되었습니다.");
					check = true;
			 	}else{
			 		$("#checkUser").html("회원이 존재하지 않습니다.");
			 		check = false;
			 	}
			});
	}	

			function getContextPath() {
			  var hostIndex = location.href.indexOf( location.host ) + location.host.length;
			  return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
			};
		       
			const passwordCk = () => {
					const userPassword = $('#userPassword').val();
					const userPasswordCk = $('#userPasswordCk').val();    
	
			        if(userPassword == userPasswordCk){
			            pwckCheck = true;
			            result = true;
			            $("#errorPassword").css('display', 'none');
			            $("#nonSamePassword").css('display', 'none');
			            $("#SamePassword").html("비밀번호가 일치합니다.");
			            $("#SamePassword").css('display', 'block');
			        }else{
			            pwckCheck = false;
			            result = false;
			            $("#errorPassword").css('display', 'none');
			            $("#SamePassword").css('display', 'none');
			            $("#nonSamePassword").html("비밀번호가 일치하지 않습니다.");
			            $("#nonSamePassword").css('display', 'block');
			        }
			};

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
					$.ajax({
						url: "changepassword",
						data: data,
						method: "post"
					}).done(data => {
						if(data.result == "success"){
							if(confirm('비밀번호를 수정하시겠습니까?')) {
		               			 alert('비밀번호가 수정되었습니다.');
		                		window.location.href = getContextPath()+'/auth/login';
		           		 	}
						}
					});
				}
			};