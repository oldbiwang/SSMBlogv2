<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	request.setAttribute("APP_PATH", request.getContextPath());
%>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>王锐鹏博客</title>
	<link rel="stylesheet" href="css/w3blog.css">
	 <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
     <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="js/editormd/css/editormd.preview.css" />
	<link rel="stylesheet" href="css/nav.css">
	<title>王锐鹏博客</title>
	  <style>
            .editormd-html-preview {
                width: 90%;
                margin: 0 auto;
            }
        </style>
    </head>
</head>
<body>
	 <div id="layout">
           <header>
               	<ul class="navul">
					<li class="navli"><a href="${APP_PATH }/">Home</a></li>
					<li class="navli"><a href="https://github.com/oldbiwang">github</a></li>
					<li class="navli"><a target="_blank" href="${APP_PATH }/contact">Contact me</a></li>
					<li class="navli"><a target="_blank" href="${APP_PATH }/about">About me</a></li>
				</ul>   
            </header>
        
            <div id="test-editormd-view2">
                <textarea id="append-test" style="display:none;">
					${mdString }
				</textarea>    
		     </div>
		       
	       	<br>
	       	<hr>
	       	
	       	<div class="contanier">
				<div  id="commentslist">
					
				</div>
			
				<hr>
				<div>
					<h3 style="text-align: center;">发表评论</h3>
					<div class="col-lg-12">
						<div class="row">
							<div class="col-md-12 form-group">
								<input class="form-control" id="name" name="name"
									placeholder="Name" type="text" required>
							</div>
						</div>
						<textarea class="form-control" id="comments" name="comment"
							placeholder="留下你的足迹..." rows="8"></textarea>
						<br>
						<div class="row">
							<div class="col-lg-12 form-group">
								<button class="btn btn-success" type="submit" onclick="sendcomment(${id})">Send</button>
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
        </div>
  	
        <!-- <script src="js/zepto.min.js"></script>
		<script>		
			var jQuery = Zepto;  // 为了避免修改flowChart.js和sequence-diagram.js的源码，所以使用Zepto.js时想支持flowChart/sequenceDiagram就得加上这一句
		</script> -->
       <script src="js/jquery.min.js"></script>
        <script src="js/editormd/lib/marked.min.js"></script>
        <script src="js/editormd/lib/prettify.min.js"></script>
        
        <script src="js/editormd/lib/raphael.min.js"></script>
        <script src="js/editormd/lib/underscore.min.js"></script>
        <script src="js/editormd/lib/sequence-diagram.min.js"></script>
        <script src="js/editormd/lib/flowchart.min.js"></script>
        <script src="js/editormd/lib/jquery.flowchart.min.js"></script>

        <script src="js/editormd/editormd.js"></script>
        <script type="text/javascript">
        	var testEditormdView2;
            $(function() {                
                testEditormdView2 = editormd.markdownToHTML("test-editormd-view2", {
                    htmlDecode      : "style,script,iframe",  // you can filter tags decode
                    tocm            : true,
                    emoji           : true,
                    taskList        : true,
                    tex             : true,  // 默认不解析
                    flowChart       : true,  // 默认不解析
                    sequenceDiagram : true,  // 默认不解析
                });
                getComment(${id});
            });
            function showarticlecustomcontanier(id) {
            	window.location="${APP_PATH}/showarticlecustomcontanier?id=" + id;
            }
            function sendcomment(sid) {
            	$.ajax({
            		type: "post",
            		url: "${APP_PATH}/sendcomment",
            		data: {
            			id : sid,
            			name : $("#name").val(),
            			comment: $("#comments").val()
            		},
            		dataType: "json",
            		success : function(result) {
            			alert(result.msg);
            			getComment(${id});
            		} 
            	});
            }
            
            function getComment(id) {
            	$.ajax({
            		type: "GET",
            		url: "${APP_PATH}/getComments",
            		data: "id="+id,
            		dataType: "json",
            		success: function(result) {
            			$("#commentslist").empty();
            			$("<h3></h3>").css("text-align","center").append("评论").appendTo("#commentslist");
            			var commentlist = result.extend.commentsList;
            			$.each(commentlist, function(index , item) {
            				var div = $("<div></div>").addClass("panel panel-success");
            			/* 	 <div class="panel panel-success">
						      <div class="panel-heading">Panel with panel-success class</div>
						      <div class="panel-body">Panel Content</div>
						    </div> */
            				$("<div></div>").addClass("panel-heading").append(item.username).append("&nbsp;&nbsp;")
            				.append(parseDateNormal(item.createdtime)).appendTo(div);
            				$("<div></div>").addClass("panel-body").append(item.content).css("word-wrap","break-word").
    						css("word-break","break-all").appendTo(div);
    						div.appendTo("#commentslist");
    						$("#commentslist").append($("<br>"));
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