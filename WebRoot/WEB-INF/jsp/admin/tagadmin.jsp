<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	request.setAttribute("APP_PATH", request.getContextPath());
%>
<title>王锐鹏博客</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	 <link href="${APP_PATH}/css/bootstrap.min.css" rel="stylesheet">
	 <link href="${APP_PATH}/css/nav.css" rel="stylesheet">
     <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${APP_PATH}/js/bootstrap.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery/3.2.0/jquery.min.js"></script>
	<link href="${APP_PATH}/js/editormd/css/editormd.min.css" rel="stylesheet"
		type="text/css" />
	<script src="${APP_PATH}/js/editormd/editormd.js"></script>
	<script src="${APP_PATH}/js/editormd/editormd.amd.js"></script>
</head>
<body>
	<header>
		<ul class="navul">
				<li class="navli"><a href="${APP_PATH }/admin/">文章管理</a></li>
				<li class="navli"><a href="${APP_PATH }/commentback">评论管理</a></li>
				<li class="navli"><a href="${APP_PATH }/tagadmin">分类管理</a></li>
				<li class="navli"><a href="${APP_PATH }/logout">log out</a></li>
			</ul>
	</header>
	<div class="container">
		<div class="row">
			<h2>分类后台管理
			<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" 
			data-target="#mynewModal" style="float: right;">新建</button></h2>
			<ul class="list-group" id="taglist" style="word-wrap:break-word;
			 word-break:break-all;overflow:hidden;">
			</ul>
		</div>
		
		<!-- 新建模态框 -->
		<div id="mynewModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">新建分类!</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
					  <div class="form-group">
					    <label class="control-label col-sm-2" for="name">name:</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" name="name" id="name" placeholder="Enter name">
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="control-label col-sm-2" for="name">level:</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" name="level" id="level" placeholder="Enter level">
					    </div>
					  </div>
					  <div class="form-group" style="text-align: center;">
     					<input type="button" id="newBtn" class="btn btn-default" value="确定"/>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					  </div>
					</form>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- 删除模态框 Modal -->
		<div id="mydelModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">删除提醒!</h4>
		      </div>
		      <div class="modal-body">
		        <p>你确定要删除分类吗？</p>
		      </div>
		      <div class="modal-footer">
		      	<button type="button" id="delBtn" class="btn btn-default" data-dismiss="modal">确定</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
	</div>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">
		$(function() {
			getTag();
		});

		$('#newBtn').click(function() {
			$.ajax({
				type: "POST",
				url: "${APP_PATH}/newTag",
				// 取出正则的结果，发送数据
				data: $(".form-horizontal").serialize(),
				success: function (data) {
					if (data.code == 100) {
						swal({
							text: data.msg
						})
						setTimeout(function () {
						}, 3000);
						window.location.href = "${APP_PATH}/tagadmin";
					}
				}
			})
		});


		// 获得标签 
		function getTag() {
			$.ajax({
				type: "GET",
				url: "${APP_PATH}/getTags",
				dataType: "json",
				success: function(result) {
					var tags = result.extend.tags;
					$("#taglist").empty();
					$.each(tags, function(index, item) {
						var li = $("<li></li>").addClass("list-group-item").append(
						item.id).append("&nbsp;&nbsp;&nbsp;")
						.append(item.name);
						li.css("word-wrap","break-word").css("word-break","break-all")
						.css("overflow","hidden");
						var div = $("<div></div>").addClass("btn-group").css("float","right");
				
						var delBtn = $("<button></button>").addClass("btn btn-danger")
						.append("删除").attr("data-toggle", "modal")
								.attr("data-target", "#mydelModal").appendTo(div);
						delBtn.bind("click", function() {
							del(item.id);
						});
						div.appendTo(li);
						li.appendTo("#taglist");
					}); 
				}
			});
		}
	
		// 删除分类函数
		function del(id) {
			alert(id);
			$("#delBtn").bind("click", function() {
				$.ajax({
					type: "GET",
					url: "${APP_PATH}/deletetag",
					data: "id=" + id,
					success: function(result) {
						alert(result.msg);
						window.location = "${APP_PATH}/tagadmin";
					} 
				});
			});
		}
	</script>
</body>
</html>