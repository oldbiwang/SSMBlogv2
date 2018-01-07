<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("APP_PATH", request.getContextPath());
 %>
<!DOCTYPE html>
<html>
	<title>oldbiwang blog</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/nav.css">
	<link rel="stylesheet" href="css/w3blog.css">
 	<link rel="stylesheet"
		href="https://fonts.googleapis.com/css?family=Raleway"> 
	<script src="js/jquery.min.js"></script>
	<style>
	body,h1,h2,h3,h4,h5 {
		font-family: "Raleway", sans-serif
	}
	</style>
<body class="w3-light-grey">

	<!-- w3-content defines a container for fixed size centered content,
	and is wrapped around the whole page content, except for the footer in this example -->
	<div class="w3-content" style="max-width:1400px">

		<!-- Header -->
		<header class="w3-container w3-center w3-padding-32">
			<ul class="navul">
				<li class="navli"><a href="${APP_PATH }/">Home</a></li>
				<li class="navli"><a href="https://github.com/oldbiwang">github</a></li>
				<li class="navli"><a target="_blank" href="${APP_PATH }/contact">Contact me</a></li>
				<li class="navli"><a target="_blank" href="${APP_PATH }/about">About me</a></li>
			</ul>
			<h1>
				<b>MY BLOG</b>
			</h1>
			<p>
				Welcome to the blog of <span class="w3-tag">oldbiwang</span>
			</p>
		</header>

		<!-- Grid -->
		<div class="w3-row">

			<!-- Blog entries -->
			<div class="w3-col l8 s12" id="blog">
				
			</div>
				<!-- END BLOG ENTRIES -->
			

			<!-- Introduction menu -->
			<div class="w3-col l4">
				<!-- About Card -->
				<div class="w3-card w3-margin w3-margin-top">
					<img src="images/avatar_g.jpg" style="width:100%">
					<div class="w3-container w3-white">
						<h4>
							<b>My Name</b> -- 王锐鹏
						</h4>
						<p> Just me, 小名 cjc (C JAVA C++).&nbsp;
							like others call me oldbiwang
							(obiwan kenobi Jedi Master)</p>
					</div>
				</div>
				<hr>

				<!-- Posts -->
				<div class="w3-card w3-margin">
					<div class="w3-container w3-padding">
						<h4>Popular Posts</h4>
					</div>
					<ul class="w3-ul w3-hoverable w3-white">
						<li class="w3-padding-16" id="li1" style="word-wrap:break-word;
						word-break:break-all;text-overflow:ellipsis;overflow:hidden;"><img src="images/workshop.jpg"
							alt="Image" class="w3-left w3-margin-right" style="width:50px">
							</li>
						<li class="w3-padding-16" id="li2" style="word-wrap:break-word;
						word-break:break-all;text-overflow:ellipsis;overflow:hidden;"><img src="images/gondol.jpg"
							alt="Image" class="w3-left w3-margin-right" style="width:50px">
							</li>
						<li class="w3-padding-16" id="li3" style="word-wrap:break-word;
						word-break:break-all;text-overflow:ellipsis;overflow:hidden;"><img src="images/skies.jpg"
							alt="Image" class="w3-left w3-margin-right" style="width:50px">
							</li>
						<li class="w3-padding-16 w3-hide-medium w3-hide-small" id="li4" style="word-wrap:break-word;
						word-break:break-all;text-overflow:ellipsis;overflow:hidden;"><img
							src="images/rock.jpg" alt="Image" class="w3-left w3-margin-right"
							style="width:50px"></li>
					</ul>
				</div>
				<hr>

				<!-- Labels / tags -->
				<div class="w3-card w3-margin">
					<div class="w3-container w3-padding">
						<h4>Tags</h4>
					</div>
					<div class="w3-container w3-white">
						<p id="tags">
							
						</p>
					</div>
				</div>

				<!-- END Introduction Menu -->
			</div>

			<!-- END GRID -->
		</div>
		<br>
		<!-- END w3-content -->
	</div>

	<!-- Footer -->
	<footer  id="foot" class="w3-container w3-dark-grey w3-padding-32 w3-margin-top">
	
		
	</footer>
	<script type="text/javascript">
		$(function() {
			pages(1);
			gettags();
			build_post();
		});
		
		// 文章分页功能
		function pages(id) {
			$.ajax({
				type: "GET",
				url: "${APP_PATH}/articles",
				data: "pn="+id,
				dataType: "json",
				success: function(result) {
					build_blog(result);
					// 分页按钮和信息
					prenext(result.extend.pageInfo);
				
				}
			});
		}
		
		// 博客函数
		function build_blog(result) {
				// 清空分页
					$("#blog").empty();
					var articles = result.extend.pageInfo.list;
					$.each(articles, function(index, item) {
						var div1 = $("<div></div>").addClass("w3-card-4 w3-margin w3-white");
						div1.appendTo("#blog");
						var img = $("<img></img>").attr("src", "images/woods.jpg").attr("alt", "Nature").css("width","100%");;
						if(index % 5 == 0) {
							img = $("<img></img>").attr("src", "images/woods.jpg").attr("alt", "Nature").css("width","100%");
						} else if(index % 5 == 1) {
							img = $("<img></img>").attr("src", "images/bridge.jpg").attr("alt", "Norway").css("width","100%");
						} else if(index % 5 == 2) {
							img = $("<img></img>").attr("src", "images/star8.jpg").attr("alt", "star8").css("width","100%");
						} else if(index % 5 == 3) {
							img = $("<img></img>").attr("src", "images/starwars.jpg").attr("alt", "starwars").css("width","100%");
						} else if(index % 5 == 4) {
							img = $("<img></img>").attr("src", "images/starwarsweek.jpg").attr("alt", "starwarsweek").css("width","100%");
						}
						img.appendTo(div1);
						
						// 第一个 div
						var div11 = $("<div></div>").addClass("w3-container");
						var h311 = $("<h3></h3>");
						var b11 = $("<b></b>").append(item.title);
						b11.appendTo(h311);
						var h511 = $("<h5></h5>");
						h511.append(item.titleintro).append(",&nbsp;");
						var span11 = $("<span></span>").addClass("w3-opacity");
						span11.append(parseDateNormal(item.createdtime));
						span11.appendTo(h511);
						h311.appendTo(div11);
						h511.appendTo(div11);
						div11.appendTo(div1);
						
						// 第二个div
						var div12 = $("<div></div>").addClass("w3-container");
						div12.appendTo(div1);
						/* var p12 = $("<p></p>").append(item.content);
						p12.appendTo(div12); */
						var div121 = $("<div></div>").addClass("w3-row");
						var div1211 = $("<div></div>").addClass("w3-col m8 s12");
						var p212 = $("<p></p>");
				
						var btn12 = $("<button></button>").addClass(
						"w3-button w3-padding-large w3-white w3-border");
						var b12 = $("<b></b>");
						var a12 = $("<a></a>").attr("href","${APP_PATH}/showarticle?id=" + item.id).append("READ MORE »");
						a12.appendTo(b12);
						b12.appendTo(btn12);
						btn12.appendTo(p212);
						p212.appendTo(div1211);
						div1211.appendTo(div121);
						div121.appendTo(div12);
						
						var div122 = $("<div></div>").addClass("w3-col m4 w3-hide-small");
						var p22 = $("<p></p>");
						var span22 = $("<span></span>").addClass("w3-padding-large w3-right");
						var b22 = $("<b></b>").append("Comments &nbsp;");
						var span222 = $("<span></span>").addClass("w3-tag").append(0);
						b22.appendTo(span22);
						span222.appendTo(span22);
						span22.appendTo(p22);
						
				/* 		var p23 = $("<p></p>");
						var span23 = $("<span></span>").addClass("w3-padding-large w3-right");
						var b23 = $("<b></b>").append("Comments &nbsp;");
						var span223 = $("<span></span>").addClass("w3-tag").append(0);
						b23.appendTo(span23);
						span223.appendTo(span23);
						span23.appendTo(p23);
						p23.appendTo(div122);
						 */
						p22.appendTo(div122);
						div122.appendTo(div121);
						div12.appendTo(div1);
						
						div1.appendTo("#blog");
					}); 
			}
		
		
		// 分页按钮和信息
		function prenext(pageinfo) {
		/* 		<button id="previous"
			class="w3-button w3-black w3-padding-large w3-margin-bottom">Previous</button>
		<button id="next" class="w3-button w3-black w3-padding-large w3-margin-bottom">Next
			»</button>
		<label id="pagesinfo"></label> */
			$("#foot").empty();
			var previous = $("<button></button>")
			.addClass("w3-button w3-black w3-padding-large w3-margin-bottom").append("Previous");
			var next = $("<button></button>")
			.addClass("w3-button w3-black w3-padding-large w3-margin-bottom").append("Next »");
			// 是否为第一页
			if(pageinfo.isFirstPage) {
				previous.addClass("w3-disabled");
			}
			// 是否为最后一页
			if(pageinfo.isLastPage) {
				next.addClass("w3-disabled");
			}
			
			if(pageinfo.hasPreviousPage == true) {
				previous.click(function() {
					pages(pageinfo.pageNum - 1);
				});
			}
			if(pageinfo.hasNextPage == true) {
				next.click(function() {
					pages(pageinfo.pageNum + 1);
				});
			}
			previous.appendTo("#foot");
			next.appendTo("#foot");
			
			var label = $("<p></p>").append("&nbsp;&nbsp;当前第&nbsp;" + pageinfo.pageNum 
			+ "&nbsp;页，" + "共 &nbsp;" + pageinfo.total + "&nbsp;条记录");
			label.appendTo("#foot");
			
			var p = $("<p></p>").css("text-align","center").append("Powered by Springmvc&Mybatis&w3.css");
			p.appendTo("#foot");
			var p1 = $("<p></p>").css("text-align","center").append("@2018 王锐鹏 粤ICP备17002874号");
			p1.appendTo("#foot");
		}
		
		// 获取标签
		function gettags() {
			$.ajax({
				type: "GET",
				url: "${APP_PATH}/getTags",
				dataType: "json",
				success: function(result) {
					$("#tags").empty();
					var tags = result.extend.tags;
					/* <span class="w3-tag w3-black w3-margin-bottom">Travel</span>  */
					$.each(tags, function(index, item) {
						var span;
						span = $("<span></span>").addClass("w3-tag w3-light-grey w3-small w3-margin-bottom");
						if(index == 0)
						 	span = $("<span></span>").addClass("w3-tag w3-black w3-margin-bottom");
				
						var a = $("<a></a>").attr("href", "${APP_PATH}/tag?id="+item.id);
						a.append(item.name).appendTo(span);
						span.appendTo("#tags");
					});
				}
			});
		}
		
		// 构建 popular 文章
		function build_post() {
			$.ajax({
				type: "GET",
				url: "${APP_PATH}/postarticle",
				dataType: "json",
				success: function(result) {
					var list = result.extend.postList;
					$.each(list, function(index, item){
						var span1 = $("<span></span>").addClass("w3-large");
					 	var span2 = $("<span></span>").addClass("w3-large");
					 	if(index == 0) {
					 		var a = $("<a></a>").attr("href","${APP_PATH}/showarticle?id="+item.id);
					 		a.append(item.title).appendTo(span1);
					 		span1.appendTo("#li1");			
					 	}
					 	
					 	if(index == 1) {
					 		var a1 = $("<a></a>").attr("href","${APP_PATH}/showarticle?id="+item.id);
					 		a1.append(item.title).appendTo(span1);
					 		span1.appendTo("#li2");
					 	}
					 	 
					 	 if(index == 2) {
					 		var a2 = $("<a></a>").attr("href","${APP_PATH}/showarticle?id="+item.id);
					 		a2.append(item.title).appendTo(span1);
					 		span1.appendTo("#li3");
					 	}
					 	
					 		 
					 	 if(index == 3) {
					 		var a3 = $("<a></a>").attr("href","${APP_PATH}/showarticle?id="+item.id);
					 		a3.append(item.title).appendTo(span1);
					 		span1.appendTo("#li4");
					 	}
					});
				} 
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
