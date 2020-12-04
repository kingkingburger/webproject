<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="product.ProductDAO" %>
<%@ page import="product.Product" %>
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
    ProductDAO product= new ProductDAO();

    int last_num = product.getNext();
    int pre_num;

    int Division = 1;
    if (request.getParameter("pageNumber") != null)
    {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        last_num = Integer.parseInt(request.getParameter("last_num"));    
        Division = Integer.parseInt(request.getParameter("Division"));
       
    }
    int market_num = Integer.parseInt(request.getParameter("market_num"));
    String market_name = request.getParameter("market_name");
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
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                
                    </ul>
                </li>
            </ul>
                    
            <%
            // 로그인이 되어있는 사람만 볼수 있는 화면
                } else {
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
             	<%  if(userType.equals("판매자")) 
             	{%>
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
            	<%} 
            	   %>
            <%
                }
            %>
	 </div>
    </nav>
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th style="background-color:#eeeeee; text-align:center;">물품번호</th>
                        <th style="background-color:#eeeeee; text-align:center;">가게번호</th>
                        <th style="background-color:#eeeeee; text-align:center;">가게이름</th>
                        <th style="background-color:#eeeeee; text-align:center;">카테고리</th>
             
                    </tr>
                </thead>
                <tbody>
                <%
                   
                	ProductDAO productDAO = new ProductDAO();
                	ArrayList<Product> list = null;
                if(Division==1) {
                	list = productDAO.getList_categoly(last_num, market_num ,Division);
                    for(int i = 0; i < list.size(); i++)
                    {
                %>
                
                    <tr>
                        <td><%=list.get(i).getProduct_num() %> </td>
                        <td><%=market_num %></td>
                        <td><%=market_name  %></td>                       
                        <td><a href="ShopMallMain.jsp?market_num=<%=market_num%>&market_categoly=<%=list.get(i).getProduct_categoly() %>"> <%=list.get(i).getProduct_categoly() %> </a></td>
                    </tr>
                <%
                    }
                    if(list.size() == 0) {
                    	PrintWriter script = response.getWriter();
        				script.println("<script>");
        				script.println("alert('등록한 카테고리가 없습니다.')");
        				script.println("location.href = 'main.jsp'");
        				script.println("</script>");
                   
                    }
                    last_num=list.get(list.size()-1).getMarket_num();
                }
                else {
                	last_num = last_num -1;
                	list = productDAO.getList_categoly(last_num, market_num, Division);
                	for(int i = 0; i < list.size(); i++)
                    {
                %>
                
                    <tr>
                        <td><%=list.get(list.size() -i -1).getProduct_num() %> </td>
                        <td><%=market_num %></td>
                        <td><%=market_name %></td>
                        <td><a href="ShopMallMain.jsp?market_num=<%=market_num%>&market_categoly=<%=list.get(i).getProduct_categoly() %>"><%=list.get(list.size() -i -1).getProduct_categoly() %></a></td>
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
                } if (productDAO.nextPage(last_num, market_num)) {
                
                  
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