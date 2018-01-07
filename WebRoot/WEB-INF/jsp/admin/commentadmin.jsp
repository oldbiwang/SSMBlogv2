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
	 <link href="css/bootstrap.min.css" rel="stylesheet">
	 <link href="css/nav.css" rel="stylesheet">
     <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
	<script src="https://cdn.bootcss.com/jquery/3.2.0/jquery.min.js"></script>
	<link href="js/editormd/css/editormd.min.css" rel="stylesheet"
		type="text/css" />
	<script src="js/editormd/editormd.js"></script>
	<script src="js/editormd/editormd.amd.js"></script>
</head>
<body>
	<header>
		<ul class="navul">
				<li class="navli"><a href="${APP_PATH }/validatellogin">文章管理</a></li>
				<li class="navli"><a href="${APP_PATH }/commentback">评论管理</a></li>
				<li class="navli"><a href="${APP_PATH }/tagadmin">分类管理</a></li>
				<li class="navli"><a href="${APP_PATH }/logout">log out</a></li>
			</ul>
	</header>
	<div class="container">
		<div class="row">
			<h2>评论后台管理</h2>
			<ul class="list-group" id="commentlist" style="word-wrap:break-word;
			 word-break:break-all;overflow:hidden;">
			</ul>
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
		        <p>你确定要删除此条评论？</p>
		      </div>
		      <div class="modal-footer">
		      	<button type="button" id="delBtn" class="btn btn-default" data-dismiss="modal">确定</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		      </div>
		    </div>
		  </div>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			getComment();
		});
		// 获得标签 
		function getComment() {
			$.ajax({
				type: "GET",
				url: "${APP_PATH}/getallcomments",
				dataType: "json",
				success: function(result) {
					var commentslist = result.extend.commentList;
					$("#commentlist").empty();
					$.each(commentslist, function(index, item) {
						var li = $("<li></li>").addClass("list-group-item").append(
						item.id).append("&nbsp;&nbsp;&nbsp;")
						.append(item.blogId).append("&nbsp;&nbsp;&nbsp;")
						.append(item.username).append("&nbsp;&nbsp;&nbsp;")
						.append(item.content).append("&nbsp;&nbsp;&nbsp;")
						.append(parseDateNormal(item.createdtime));
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
						li.appendTo("#commentlist");
					}); 
				}
			});
		}
	
		// 删除评论函数
		function del(id) {
			alert(id);
			$("#delBtn").bind("click", function() {
				$.ajax({
					type: "GET",
					url: "${APP_PATH}/deleteacomment",
					data: "id=" + id,
					dataType: "json",
					success: function(result) {
						//alert(result.msg); 不然每删一篇文章就得弹出多少次
						window.location = "${APP_PATH}/commentback";
					} 
				});
			});
		}
		
		// 解析时间戳函数 解析后格式为 xxxx-x(小于10，这个为0)x-xx
		function parseDateNormal(dateStr) {
			// 比如需要这样的格式 yyyy-MM-dd hh:mm:ss
			var date = new Date(dateStr);
			Y = date.getFullYear() + '-';
			M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
			D = date.getDate() + ' ';
			h = date.getHours() + ':';
			m = date.getMinutes() + ':';
			s = date.getSeconds(); 
			return (Y+M+D+h+m+s); 
		}
	</script>
</body>
</html>