<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="product.ProductDAO" %>
<%@ page import="product.Product" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 애니매이션 담당 JQUERY -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 부트스트랩 JS  -->
<script src="js/bootstrap.js"></script>
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">

<title>ShopMallMain JSP</title>
<script type="text/javascript">
function fnCart(name, price) {
	//alert("Name : " + name + "\nPrice : " + price);
	if(confirm("장바구니에 담으시겠습니까?")) {
		location.href = "CartProcess.jsp?name=" + name + "&price=" + price;
	}
}

function fnView(market_num, market_categoly) {
	if(confirm("장바구니를 보시겠습니까?")){
		location.href = "CartView.jsp?market_num=" + market_num + "&market_categoly=" + market_categoly ;
	}
}

function fnproduct() {
	
	if(confirm("물품을 추가하시겠습니까?")){
		location.href = "upload.jsp"
	}
		
}
</script>
</head>

<body>

	<%
    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    String userType = "test";
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");
       	UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userID);
        userType = user.getUserType();
        
    }

%>
	<!-- 네비게이션  -->
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
                <li class="active"><a href="main.jsp">메인</a></li>
            	<li><a href="bbs.jsp">게시판</a></li>  
            	  
            	
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
           <% 	}  
            
           if(userType.equals("판매자")) 
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
          
                
            
            int market_num = Integer.parseInt(request.getParameter("market_num"));
            String market_categoly = request.getParameter("market_categoly");          

            if(market_num < 1 || market_categoly == null) {
            	

				out.println("<script>");

				out.println("alert('리스트 호츨 오류.')");

				out.println("history.back()");

				out.println("</script>");

            }
            
            
            ProductDAO productDAO = new ProductDAO();
            ArrayList<Product> List= productDAO.getList_product_categoly(market_num, market_categoly);
           
            int size=List.size();
            String []img= new String[size]; 
            String []name= new String[size]; 
            int []price= new int[size];

        for (int i =0 ; i< size ; i++) {
        	
        	img[i] = List.get(i).getProduct_image();
        	name[i] = List.get(i).getProduct_name();
        	price[i] = List.get(i).getProduct_value();
        }

            
            
            %>
        </div>
    </nav>
	<div align=center>
		<h3>[과일 가게]</h3>
		<table border="1">
			<tr align="right">
				<td colspan="4"><a onclick="return confirm('장바구니를 보시겠습니까?')")" href="CartView.jsp?market_num=<%=market_num  %>&market_categoly=<%=market_categoly %>" class="btn btn-primary" style="display: block;">장바구니 보기</a>
				</td>
				</tr>
			<tr align="right">	
				 <td colspan="4" align="left"><a onclick="return confirm('물품을 추가하시겠습니까?')")" href="Product_registration.jsp" class="btn btn-primary" style="display: block;" >물품추가</a>
				</td>
			</tr>
	<%		
		out.println("<tr align='center'> [위치 : 경기도 수원시 장안구 파장동 파장천로 46] <br></tr>");
		out.println("<tr align='center'> [영업시간 : 오전 9시 ~ 오후 23시] <br></tr>");
		out.println("<tr align='center'> [휴게시간, 휴무일: 오전 9시 ~ 오후 23시] <br></tr>");
		for(int i = 0; i < img.length; i++) {
			if(i % 4 == 0) { 
				out.println("<tr align='center'>");
			}
			%>
			<td>
				
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				
					
					<tr align='center'>
						<td>
						<%
							out.println("<img src = 'upload/" + img[i] + "' width='150' height='150' />");
						%>
						</td>
					</tr>
					
					<tr align='center'>
						<td>
						<% 
							out.println("<b>" + name[i] + "</b>");
							%>
						</td>
					</tr>
					
					<tr align='center'>
						<td>
						<% 
							out.println("<b>￦" + price[i] + "원</b>");
						%>
						</td>
					</tr>
					
					<tr align='center'>
						<td>
							<%
							out.println("<input type='button' value='장바구니 담기' onclick='fnCart(\"" + name[i] + "\", \"" + price[i] + "\")' />");
							%>
						</td>
					</tr>
				</table>
			</td>
			<%
			if(i % 4 == 3) {
				out.println("</tr>");
			}
		}
		%>
		
		</table>
	</div>
</body>

</html>