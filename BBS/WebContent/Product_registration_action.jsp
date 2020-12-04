<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="product.ProductDAO" %>
<%@ page import="java.io.File" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<% request.setCharacterEncoding("UTF-8"); %>




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
	
		String product_image =multipartRequest.getFilesystemName("product_image"); //실제로 서버에 업로드된 파일 시스템 이름을 가지고온다.
		
		String product_categoly = multipartRequest.getParameter("product_categoly");	
		String product_name = multipartRequest.getParameter( "product_name");
		String check_value = multipartRequest.getParameter( "product_value");
		String check_amount = multipartRequest.getParameter( "product_amount");
		String check_market_num = multipartRequest.getParameter("market_num");

		if ( product_name.length() <1  || product_image == null||check_value.length() <1
				|| check_amount.length() <1 ||  product_categoly.length() <1 || check_market_num.length() <1){


			out.println("<script>");

			out.println("alert('입력이 안 된 사항이 있습니다.')");

			out.println("history.back()");
			out.println("</script>");
		}
		else{
	
			int product_value =Integer.parseInt(check_value);
			int product_amount =Integer.parseInt(check_amount);
			int market_num =Integer.parseInt(check_market_num);
			String userID = (String)session.getAttribute("userID");
			ProductDAO productDAO =  new ProductDAO();
			int chect_num=productDAO.Check_market_num(market_num, userID);
			if(chect_num != 1) {
				out.println("<script>");
				out.println("alert('마켓번호를 확인하세요.')");
				out.println("history.back()");
				out.println("</script>");
				
			}
				
		
		else if ( chect_num == 1 ){ // 아이디가 기본키기. 중복되면 오류.

			int result = productDAO.upload(product_name, product_value, product_image, product_amount, product_categoly, market_num);
			out.println("<script>");

			out.println("alert('등록 성공')");

			out.println("location.href = 'main.jsp'");

			out.println("</script>");

		}
	

		//가입성공

		else {
			


			out.println("<script>");

			out.println("location.href = 'ShopMallMain.jsp'");

			out.println("</script>");

		}

	}


	%>

</body>
</html>