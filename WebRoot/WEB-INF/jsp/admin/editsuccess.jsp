<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setAttribute("APP_PATH", request.getContextPath());
     %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>王锐鹏博客</title>
</head>
<body>
	${map.message }<a href="${APP_PATH }/validatellogin">继续修改文章</a>
</body>
</html>