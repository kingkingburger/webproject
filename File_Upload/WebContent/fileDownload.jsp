<%@ page import = "java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 파일 업로드</title>
</head>
<body>

<%
	String directory = application.getRealPath("/upload/"); // 업로드 폴더 경로 가져오기
	String files[] = new File(directory).list(); // 모든 파일을 배열의 형태로 담는다.
		for(String file : files) {
		
		out.write("<a href=\"" + request.getContextPath() + "/downloadAction?file=" +
			java.net.URLEncoder.encode(file, "UTF-8") + "\">" + file  + "</a><br>");
	}
%>
</body>
</html>