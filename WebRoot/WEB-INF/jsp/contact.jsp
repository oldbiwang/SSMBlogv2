<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>王锐鹏博客</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/nav.css">
  <script src="js/jquery.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
</head>
<body>
 
<div class="container">
   	<ul class="navul">
		<li class="navli"><a href="${APP_PATH}/">Home</a></li>
		<li class="navli"><a href="https://github.com/oldbiwang">github</a></li>
		<li class="navli"><a target="_blank" href="${APP_PATH }/contact">Contact me</a></li>
		<li class="navli"><a target="_blank" href="${APP_PATH }/about">About me</a></li>
	</ul> 
  <h2>联系我</h2>
  <p>希望有大神带我飞</p>
  <div class="panel-group">
    <div class="panel panel-default">
      <div class="panel-heading">邮箱</div>
      <div class="panel-body">18826131900@163.com</div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading">微信</div>
      <div class="panel-body">WANGRUIPENG159</div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading">xxxxxxxx</div>
      <div class="panel-body">嘻嘻嘻嘻嘻</div>
    </div>
  </div>
  	<br></br>
	<div>
		<h3 style="text-align: center;">想对我说什么.....</h3>
		<div class="col-lg-12">
			<div class="row">
				<div class="col-md-12 form-group">
					<input class="form-control" id="name" name="name"
						placeholder="Name" type="text" required>
				</div>
			</div>
			<textarea class="form-control" id="comments" name="comment"
				placeholder="留下你的心声..." rows="8"></textarea>
			<br>
			<div class="row">
				<div class="col-lg-12 form-group">
					<button class="btn btn-success" type="submit" onclick="sendheartword(520)">Send</button>
					  <br><br>
					  <p style="text-align: center;"><a href="${APP_PATH }">
					  Powered by Springmvc&Mybatis&w3.css</a></p>
					  <p style="text-align: center;"><a href="${APP_PATH }">
					  @2018 王锐鹏 粤ICP备17002874号</a></p>
				</div>
			</div>
		</div>
	</div> 
</div>
<script>
	  function sendheartword(sid) {
            	$.ajax({
            		type: "post",
            		url: "${APP_PATH}/sendheartword",
            		data: {
            			id : sid,
            			name : $("#name").val(),
            			comment: $("#comments").val()
            		},
            		dataType: "json",
            		success : function(result) {
            			alert(result.msg);
            		} 
            	});
            }
</script>
</body>
</html>
