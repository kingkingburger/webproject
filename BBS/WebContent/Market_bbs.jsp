<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="market.MarketDAO" %>
<%@ page import="market.Market" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %> 
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>     
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<title>JSP 게시판 웹 사이트</title>

</head>
<body>
<%
    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    String userType = null;
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");
       	UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userID);
        userType = user.getUserType();
        
    }
    int pageNumber = 1; // 기본페이지 기본적으로 페이지 1부터 시작하므로
    MarketDAO market= new MarketDAO();

    int last_num = market.getNext();
    int pre_num;

    int Division = 1;
    if (request.getParameter("pageNumber") != null)
    {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        last_num = Integer.parseInt(request.getParameter("last_num"));    
        Division = Integer.parseInt(request.getParameter("Division"));
       
    }
    pre_num = last_num;
%>
    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">웹 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
 
            </ul>
            <%
            
                if(userID != null && userType.equals("판매자"))
                {
            %>
            		  <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
            
            
            		 <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">마켓관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                    	<li><a href="Market_bbs.jsp">마켓리스트</a></li>
                        <li><a href="market_registration.jsp">마켓등록</a></li>
                         <li><a href="Product_registration.jsp">물품등록</a></li>
                    </ul>
                </li>
            </ul>
            
            
            
            
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
            %>
            	PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('판매자가 아닙니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");	
            
            <%}
             %>
	 </div>
    </nav>
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th style="background-color:#eeeeee; text-align:center;">번호</th>
                        <th style="background-color:#eeeeee; text-align:center;">ID</th>
                        <th style="background-color:#eeeeee; text-align:center;">마켓 이름</th>
                        <th style="background-color:#eeeeee; text-align:center;">주소</th>
                        <th style="background-color:#eeeeee; text-align:center;">가게 카테고리</th>
                    </tr>
                </thead>
                <tbody>
                <%
                   
                	MarketDAO marketDAO = new MarketDAO();
                	ArrayList<Market> list = null;
                if(Division==1) {
                    list = marketDAO.getList(last_num, userID,Division);
                    for(int i = 0; i < list.size(); i++)
                    {
                %>
                
                    <tr>
                        <td><%=list.get(i).getMarket_num() %> </td>
                        <td><%=list.get(i).getMarket_userid() %></td>
                        <td><a href="Product_bbs.jsp?market_num=<%=list.get(i).getMarket_num()%>&market_name=<%=list.get(i).getMarket_name() %>"><%=list.get(i).getMarket_name() %></a></td>
                        <td><%=list.get(i).getMarket_address1() %> <%=list.get(i).getMarket_address2() %> <%=list.get(i).getMarket_address3() %> <%=list.get(i).getMarket_detailed_address() %></td>
                        <td><%=list.get(i).getMarket_categoly() %></td>
                    </tr>
                <%
                    }
                    if(list.size() == 0) {
                    	PrintWriter script = response.getWriter();
        				script.println("<script>");
        				script.println("alert('등록한 마켓이 없습니다.')");
        				script.println("location.href = 'main.jsp'");
        				script.println("</script>");
                   
                    }
                    last_num=list.get(list.size()-1).getMarket_num();
                }
                else {
                	last_num = last_num -1;
                	list = marketDAO.getList(last_num, userID,Division);
                	for(int i = 0; i < list.size(); i++)
                    {
                %>
                
                    <tr>
                        <td><%=list.get(list.size() -i -1).getMarket_num() %> </td>
                        <td><%=list.get(list.size() -i -1).getMarket_userid() %></td>
                        <td><a href="Product_bbs.jsp?market_num=<%=list.get(list.size() -i -1).getMarket_num()%>&market_name=<%=list.get(list.size() -i -1).getMarket_name() %>"><%=list.get(list.size() -i -1).getMarket_name() %></a></td>
                        <td><%=list.get(list.size() -i -1).getMarket_address1() %> <%=list.get(list.size() -i -1).getMarket_address2() %> <%=list.get(list.size() -i -1).getMarket_address3() %> <%=list.get(list.size() -i -1).getMarket_detailed_address() %></td>
                        
                        <td><%=list.get(list.size() -i -1).getMarket_categoly() %></td>
                    </tr>
                <%
                    }
                	last_num= last_num +1 ;
               		pre_num= list.get(list.size() -1).getMarket_num() + 1;
                }
                
                    
                    
                %>
                </tbody>
            </table>
            <%
          
                if(pageNumber != 1) {
            %>
                <a href="Market_bbs.jsp?pageNumber=<%=pageNumber - 1 %>&last_num=<%=pre_num %>&Division=<%=0 %>" class="btn btn-success btn-arrow-left">이전</a>
            <%
                } if (marketDAO.nextPage(last_num, userID)) {
                
                  
            %>
                
                <a href="Market_bbs.jsp?pageNumber=<%=pageNumber + 1 %>&last_num=<%=last_num %>&Division=<%=1 %>" class="btn btn-success btn-arrow-left">다음</a>
            
            <%
                }
            %>
            <a href="market_registration.jsp" class="btn btn-primary pull-right">마켓추가</a>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>