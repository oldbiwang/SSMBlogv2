<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>王锐鹏博客！</title>
</head>
<body>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
	// 弹出请登录
	swal({
		text: "请登录!"
	})
	// 延时1S
	setTimeout(function () {
	}, 1000);
	// 重定向
	window.location.href = "${pageContext.request.contextPath}/login";
</script>
</html>