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
			<h2>文章后台管理
			<button type="button" onclick="newblog()" style="float: right;" class="btn btn-success">新建</button></h2>
			<ul class="list-group" id="articlelist" style="word-wrap:break-word;
			 word-break:break-all;overflow:hidden;">
			</ul>
		</div>
		<!-- 分页条信息 -->
		<div class="row" style="text-align: center;">
			<!-- <div class="col-md-12" id="page_nav_area"></div> -->
			<div class="col-md-18 row" id="page_nav_area"></div>
		</div>
		<!--分页文字信息  -->
		<div class="row" style="text-align: center;">
			<div class="col-md-18 row" id="page_info_area"></div>
		</div>
		
		<!-- 删除模态框 Modal -->
		<div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">删除提醒!</h4>
		      </div>
		      <div class="modal-body">
		        <p>你确定要删除文章？</p>
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
			to_page(1);
		});
		// 去哪一页函数
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/articles",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					// 创建文章列表
					build_article_table(result);
					// 创建分页信息
					build_page_info(result);
					// 创建导航栏
					build_page_nav(result);
				}
			});
		}

		function build_article_table(result) {
			// 清空内容
			$("#articlelist").empty();

			var articles = result.extend.pageInfo.list;
			// 遍历文章列表，动态添加列表内容
			$.each(articles, function(index, item) {
				/*    <li class="list-group-item">First item
				<div class="btn-group">
				  <button type="button" class="btn btn-success">编辑</button>
				  <button type="button" class="btn btn-danger">删除</button>
				</div></li> */
				var li = $("<li></li>").addClass("list-group-item").append(
						item.id).append("&nbsp;&nbsp;&nbsp;")
						.append(item.title);
				li.css("word-wrap","break-word").css("word-break","break-all")
				.css("overflow","hidden");
				var div = $("<div></div>").addClass("btn-group").css("float","right");
				
				/* <button type="button" class="btn btn-info btn-lg" 
				data-toggle="modal" data-target="#myModal">Open Large Modal</button> */
				
				
				var editBtn = $("<button></button>").addClass("btn btn-primary").append("编辑")
						.appendTo(div);
					 editBtn.bind("click", function() {
						edit(item.id);
					 }); 
				var delBtn = $("<button></button>").addClass("btn btn-danger").append("删除").attr("data-toggle", "modal")
						.attr("data-target", "#myModal").appendTo(div);
					delBtn.bind("click", function() {
						del(item.id, result.extend.pageInfo.pageNum);
					});
				div.appendTo(li);
				li.appendTo("#articlelist");
			});
		}

		//显示分页信息
		function build_page_info(result) {
			//清空数据
			$("#page_info_area").empty();
			//alert("hello");
			$("#page_info_area").append(
					"当前 " + result.extend.pageInfo.pageNum + " 页，总 "
							+ result.extend.pageInfo.pages + " 页，总 "
							+ result.extend.pageInfo.total + " 篇文章");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}

		//显示导航条
		function build_page_nav(result) {
			//清空数据
			$("#page_nav_area").empty();
			//page_nav_area
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//添加首页、前一页的点击
				firstPageLi.click(function() {
					to_page(1);
				});

				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				//添加末页、下一页的点击
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});

				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			ul.append(firstPageLi).append(prePageLi);

			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}

				numLi.click(function() {
					to_page(item);
				});

				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);

			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		// 新建博客的控制器映射
		function newblog() {
			window.location='${APP_PATH }/islogin';	
		}
		
		// 编辑博客发出的请求
		function edit(id) {
			window.location='${APP_PATH }/edit?id=' + id;
		};
		
		// 删除函数
		function del(id, pageNum) {
			alert(id);
			$("#delBtn").bind("click", function() {
				$.ajax({
					type: "GET",
					url: "${APP_PATH}/delete",
					data: "id=" + id,
					success: function() {
						alert("删除成功！");
						// 回到当前页
						to_page(pageNum);
					} 
				});
			});
		}
	</script>
</body>
</html>