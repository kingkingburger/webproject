<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="market.MarketDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>  <!-- userdao의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="Market" class="market.Market" scope="page" />
<jsp:setProperty name="Market" property="market_name" /> 
<jsp:setProperty name="Market" property="market_address1" />
<jsp:setProperty name="Market" property="market_address2" />
<jsp:setProperty name="Market" property="market_address3" />
<jsp:setProperty name="Market" property="market_detailed_address" />
<jsp:setProperty name="Market" property="market_categoly" />


<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
	<%
			//라긴된 회원들은 페이지에 접속 할 수 없도록
		 String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    	 String userType = null;
    	 if (session.getAttribute("userID") != null)
    	{
        userID = (String)session.getAttribute("userID");
       	UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userID);
        userType = user.getUserType();
    	}
			
			
			if(userID == null || !userType.equals("판매자")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('접근 권한이 없습니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");	
			}


		if ( Market.getMarket_name() == null || Market.getMarket_address1() == null || Market.getMarket_address2() == null || Market.getMarket_address3() == null 
				|| Market.getMarket_detailed_address() ==null || Market.getMarket_categoly() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				MarketDAO marketDAO = new MarketDAO(); //인스턴스생성
				int result = marketDAO.join(Market, userID);				

				if(result == -1){ // 아이디가 기본키기. 중복되면 오류.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디 입니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				//가입성공
				else {
				
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'Market_bbs.jsp'");
					script.println("</script>");
				}
			}
			%>

</body>
</body>

</html>

