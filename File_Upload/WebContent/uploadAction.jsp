<%@ page import="file.FileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
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
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024* 1024 * 100; //최대 파일 100MB
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy()); //요청한 파일에 대하여 디렉터에 저장 경로, 저장공간, 인코딩 세팅
	
		String fileName = multipartRequest.getOriginalFileName("file"); //form action에서 보낸 파일을 받아 변수에 저장
		String fileRealName =multipartRequest.getFilesystemName("file"); //실제로 서버에 업로드된 파일 시스템 이름을 가지고온다.
		
		new FileDAO().upload(fileName, fileRealName);
		out.write("파일명: " + fileName + "<br>");
		out.write("실제 파일명: " + fileRealName + "<br>");
	%>
</body>
</html>