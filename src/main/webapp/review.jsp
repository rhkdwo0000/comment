<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/js/jquery.min.js"></script>
<script type="text/javascript">


function Reply(bnum) {//댓글눌렀을때 다이얼로그 보여주는 함수
 	$("#updateDialog").css('display', 'none');
	var num = "#" + bnum;
	$(num).after($("#replyDialog").css('display', 'block'));
	$("#input").val(bnum);//댓글번호로 컨트롤러가서 select로 찾아서 대댓글을 등록함 
	
	return false;
}

function comment() {//대댓글 등록시 처리함수
	
	if ($("#content2").val() == "") {
		alert("내용을 입력해주세요")
	}else{
	//alert("여기는오나")
	var data = $("#formSecond").serialize();
	//alert(data);
	$.ajax({
		url : "review2",
		Type : "POST",
		data : data,
		success : function (result) {
			alert("dd");
			$("#content2").val("");
			 $("#temp").after($("#replyDialog").css('display', 'none'));
			if (result != null) {
				$("#replyList").empty();
				 $("#replyList").append(result); 
			}//if문 끝
			
		}//success끝
	})//ajax끝
}
}

function Update(bnum) {//댓글의 수정버튼 클릭시 다이얼로그 창 띄우는 함수
	alert(bnum);
	var num = "#" + bnum;
	alert(num);	
	$("#updateDialog").css('display', 'block');
	$(num).after($("#updateDialog"));
	$("#replyDialog").css('display', 'none');
	$("#input2").val(bnum);//댓글번호로 컨트롤러가서 select로 찾아서 대댓글을 등록함
	
	return false;
}

function updateResult() {
	if ($("#content3").val() == "") {
		alert("내용을 입력해주세요")
	}else{
	//alert("여기는오나")
	var data = $("#updateForm").serialize();
	//alert(data);
	$.ajax({
		url : "reviewUpdate",
		Type : "POST",
		data : data,
		success : function (result) {
			alert("dd");
			$("#content3").val("");	
			 $("#temp").after($("#updateDialog").css('display', 'none'));
			if (result != null) {
				$("#replyList").empty();
				 $("#replyList").append(result); 
			}//if문 끝
			
		}//success끝
	})//ajax끝
	}
}


function updateCancel() {
	$("#content3").val("");	
	$("#updateDialog").css('display', 'none')
}

function commentCancel() {
	$("#content2").val("");
	$("#replyDialog").css('display', 'none');
}


function Delete(bnum) {//댓글 삭제 함수
	var num = "#" + bnum;
	var data = $(num).serialize();//폼 아이디가 댓글번호와 같다
	
	$.ajax({
		url : "reviewDelete",
		Type : "POST",
		data : data,
		success : function (result) {
			alert("삭제되었습니다");
		}//success끝
	})//ajax끝
}

var time = 0;

$(function() {
	 if (time==0) {//최초실행시 댓글 리스트 보여주는 조건문
		$.ajax({
			url : "reviewAll",
			Type : "POST",
			success : function(result) {
				if (result != null) {
					$("#replyList").append(result);
				}//if문 끝
			}//success끝
		})//ajax끝
	}
	 time += 1; 
	
	$("#b1").click(function() {//댓글입력시 등록해주는 함수 
		
		if ($("#content").val() == "") {
			alert("내용을 입력해주세요 ");
		}else{
		
		  var data = $("#form").serialize();
		$.ajax({
			url : "review",
			Type : "POST",
			data : data,
			success : function(result) {
				if (result != null) {
					$("#replyList").empty();
					 $("#replyList").append(result); 
				}//if문 끝
			}//success끝
		})//ajax끝
		
		}//else문 끝
	})//click끝
})//ready끝

</script>
</head>
<body>
<div style="border: 1px solid; width: 600px; padding: 5px">
    <form id="form" name="form" action="review" method="post" >
        <input type="hidden" name="pid" value="id"> <!-- 각 게시물의 고유아이디가 들어간다. -->
        <textarea name="content" id = "content" rows="3" cols="60" maxlength="500" placeholder="댓글을 달아주세요."></textarea>
    </form>
		<input type="button" value="넘어가요" id = "b1" >
</div>	


<div id = "temp"></div>


<div id="replyList"> 

</div>

 <div id="replyDialog" style="width: 99%; display:none">
    <form id= "formSecond"  action="review2" method="post">
        <input type="hidden" name="pid" value="id"> 
        <input type="hidden" name="parents"> 
        <input type="hidden" id = "input" name = "input">
        작성자: <input type="hidden" name="id"><br>
        <textarea name="content" id = "content2"rows="3" cols="60" maxlength="500"></textarea>
        <a href="#" id ="onclick" onclick="comment()">등록</a>
        <a href="#" onclick="commentCancel()">취소</a>
    </form>
</div>  



 <div id="updateDialog" style="width: 99%; display:none">
    <form id= "updateForm"  action="review2" method="post">
        <input type="hidden" name="pid" value="id"> 
        <input type="hidden" name="parents"> 
        <input type="hidden" id = "input2" name = "input2">
        작성자: <input type="hidden" name="id"><br>
        <textarea name="content" id  = "content3" rows="3" cols="60" maxlength="500"></textarea>
        <a href="#" onclick="updateResult()">수정</a>
        <a href="#" onclick="updateCancel()">취소</a>
    </form>
</div>  
</body>
</html>