<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>王锐鹏博客</title>
	 <!-- Bootstrap -->
    <link href="${APP_PATH}/css/bootstrap.min.css" rel="stylesheet">
     <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${APP_PATH}/js/bootstrap.min.js"></script>
	<link href="${APP_PATH}/js/editormd/css/editormd.min.css" rel="stylesheet"
		type="text/css" />
	<script src="https://cdn.bootcss.com/jquery/3.2.0/jquery.min.js"></script>
	<script src="${APP_PATH}/js/editormd/editormd.js"></script>
	<script src="${APP_PATH}/js/editormd/editormd.amd.js"></script>

	<style>
		h1{
			text-align: center;
		}
	</style>

</head>
<body>
	<h1>编辑保存文章</h1>
	<br>
	<form class="form-horizontal" style="text-align:center">
		<input type="hidden" name="id" value="${blogid }"/>
		<div class="form-group">
			<label for="title" class="col-sm-2 control-label">title</label>
			<div class="col-sm-8">
				<input type="text" class="form-control" id="title" name="title" placeholder="文章标题"
					   value="${blog.title }">
			</div>
		</div>
		<div class="form-group">
			<label for="titleIntro" class="col-sm-2 control-label">文章简介</label>
			<div class="col-sm-8">
				<input type="text" class="form-control" id="titleIntro" name="titleIntro" placeholder="文章简介">
			</div>
		</div>
		<div class="form-group">
			<label for="createdTime" class="col-sm-2 control-label">创建时间</label>
			<div class="col-sm-8">
				<input type="date" class="form-control" id="createdTime" name="createdTime">
			</div>
		</div>

		<div class="form-group">
			<label for="categoryName" class="col-sm-2 control-label">分类名字</label>
			<div class="col-sm-8">
				<select class="form-control" id="categoryName" name="categoryName">
				</select>
			</div>
			<button type="button" class="btn btn-default" id="updateArticle">保存修改</button>
		</div>
		<!-- editormd start -->
		<div id="test-editormd" class="editormd form-control form-group" style="margin: 2px;">
			<textarea id="editorMarkdown" name="editorMarkdown"
					  class="editormd-markdown-textarea"></textarea>
			<!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
			<!-- html textarea 需要开启配置项 saveHTMLToTextarea == true -->
			<textarea id="editorHtml" name="editorHtml" class="editormd-html-textarea"></textarea>
		</div>
		<!-- editormd end -->
	</form>

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">
    	var testEditor;
		testEditor=$(function() {
		    editormd("test-editormd", {
		     width   : "100%",
          	 height  : 640,
          	 syncScrolling : "single",
         	 path  : "js/editormd/lib/",
         	  /**上传图片相关配置如下*/
	         imageUpload : true,
	         imageFormats : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
	         imageUploadURL : "<%=request.getContextPath()%>/uploadImg",
          	 saveHTMLToTextarea : true,	//注意3：这个配置，方便post提交表单
			 emoji : true,
			 taskList : true,
		 	 tex : true, // 默认不解析
			 flowChart : true, // 默认不解析
			 sequenceDiagram : true, // 默认不解析
			 codeFold : true
			});
		});

		$('#updateArticle').click(function () {

			// 取出表单里面的数据
			var formData = $('.form-horizontal').serialize();
			// 使用正则删除 &test-editormd-html-code 后面的内容
			var result = formData.match(/.*(?=&test-editormd-html-code)/)

			$.ajax({
				type: "POST",
				url: "${APP_PATH}/updateArticle",
				// 取出正则的结果，发送数据
				data: result[0],
				success: function (data) {
					if (data.code == 100) {
						swal({
							text: data.msg
						});
						setTimeout(function () {
						}, 3000);
						window.location.href = "${APP_PATH}/admin/";
					}
				}
			})
		});
	</script>
	<script type="text/javascript">
		$(function() {
			// 得到分类名
			getCategoryName();
			// 获取要编辑文章的内容
			var id = ${blogid };
			getBlogContent(id);
		});
		
		function getBlogContent(id) {
			$.ajax({
				type: "GET",
				url: "${APP_PATH}/getarticlebyid",
				data: "id="+id,
				dataType: "json",
				success: function(result) {
					 $("#title").val(result.title);
					 $("#titleIntro").val(result.titleintro);
		      		 $("#createdTime").val(showdate(result.createdtime));
		      		 $("#editorMarkdown").val(result.md);
				}
			});
		}
		
		function getCategoryName() {
			$.ajax({
				type: "post",
				url: "${APP_PATH }/getCategoryName",
				dataType: "json",
				success: function(data) {
					var categories = data.extend.category;
					$.each(categories, function(index, item) {
						 $("<option></option>").append(item.name).appendTo("#categoryName");
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
			//h = date.getHours() + ':';
			//m = date.getMinutes() + ':';
			//s = date.getSeconds(); 
			return (Y+M+D); 
		}
		
		function showdate(dateStr) {
			// 比如需要这样的格式 yyyy-MM-dd hh:mm:ss
			var date = new Date(dateStr);
			//格式化日，如果小于9，前面补0
			var day = ("0" + date.getDate()).slice(-2);
			//格式化月，如果小于9，前面补0
			var month = ("0" + (date.getMonth() + 1)).slice(-2);
			//拼装完整日期格式
			var show = date.getFullYear()+"-"+(month)+"-"+(day) ;
			return show;
		}
	</script>
</body>
</html>
