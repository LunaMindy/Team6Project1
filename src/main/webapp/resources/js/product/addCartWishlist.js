var amount;

const addCartCheck = () => {
	
		event.preventDefault();
		
		var data = {
				userId : $("#userId").val(),
				productNo : $("#productNo").val(),
				price : $("#price").val(),
				amount : $("#amount").val()
			}
				$.ajax({
						url: "user/addcart",
						data: data,
						method: "post"
					}).done(data => {
						if(data.result == "success"){
							swal({
							  title: "Success",
							  text: "장바구니에 추가되었습니다.",
							  dangerMode: false,
							  button: "확인",
							});
					 	}else if(data.result == "danger"){
					 		swal({
							  title: "Error",
							  text: "이미 추가된 상품입니다.",
							  dangerMode: true,
							  button: "확인",
							});
					 	}
				});
	}
	
const addwishlistCheck = () => {
	
	event.preventDefault();
	
	var data = {
			userId : $("#userId").val(),
			productNo : $("#productNo").val()
		}
			$.ajax({
					url: "user/addwishlist",
					data: data,
					method: "post"
				}).done(data => {
					if(data.result == "success"){
						console.log("실행");
						swal({
							  title: "Success",
							  text: "찜 목록에 추가되었습니다.",
							  dangerMode: false,
							  button: "확인",
							});
				 	}else if(data.result == "danger"){
				 		swal({
							  title: "Error",
							  text: "이미 추가된 상품입니다.",
							  dangerMode: true,
							  button: "확인",
							});
				 	}
			});
}

