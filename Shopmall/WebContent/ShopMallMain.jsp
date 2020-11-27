<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.productDAO" %>
<%@ page import="product.Product" %>
<%@ page import="java.util.ArrayList" %>
<%





String []img= new String[0]; 
String []name= new String[0]; 
String []price=new String[0]; 
//String[] img ={"apple1.jpg", "apple2.jpg", "apple3.jpg", "banana1.jpg", "banana2.jpg", "banana3.jpg", "pear1.jpg", "pear2.jpg", "pear3.jpg"};
//String[] name = {"화장지", "물티슈", "물티슈", "바나나1", "바나나2", "바나나3", "배1", "배2", "배3"};
//String[] price = {"1,500", "1,600", "1,700", "3,000", "3,500", "4,000", "5,000", "6,000", "7,000"};
%>

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

function fnView() {
	if(confirm("장바구니를 보시겠습니까?")){
		location.href = "CartView.jsp";
	}
}

function fnproduct() {
	
	if(confirm("물품을 추가하시겠습니까?")){
		location.href = "upload.jsp";
	}		
}
</script>
</head>

<body>
		
	<%

	
		String userID = null;
		String userType = null;
		if (session.getAttribute("userID") != null) {
			
			userID = (String) session.getAttribute("userID");
			userType = (String) session.getAttribute("userType");
		
		}
	
	%>
 <!-- 네비게이션  -->

 <nav class="navbar navbar-default">

  <div class="navbar-header">

   <button type="button" class="navbar-toggle collapsed" 

    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"

    aria-expaned="false">

     <span class="icon-bar"></span>

     <span class="icon-bar"></span>

     <span class="icon-bar"></span>

    </button>

    <a class="navbar-brand" href="main.jsp">JSP 게시판</a>

  </div>

  <div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">

   <ul class="nav navbar-nav">

    <li class="active"><a href="main.jsp">메인</a></li>

    <li><a href="bbs.jsp">게시판</a></li>
    <li><a href="ShopMallMain.jsp">쇼핑</a>

   </ul>

    <%
    	if(userID == null) {	
    %>
    		
   <ul class="nav navbar-nav navbar-right">

    <li class="dropdown">

     <a href="#" class="dropdown-toggle"

      data-toggle="dropdown" role="button" aria-haspopup="true"

      aria-expanded="false">접속하기<span class="caret"></span></a>

     <ul class="dropdown-menu">

      <li ><a href="login.jsp">로그인</a></li>

      <li><a href="join.jsp">회원가입</a></li>
      
         </ul>

    </li>

   </ul>
    
 		   
    
    <%
    }	else {
    %> 
    		   <ul class="nav navbar-nav navbar-right">

    <li class="dropdown">

     <a href="#" class="dropdown-toggle"

      data-toggle="dropdown" role="button" aria-haspopup="true"

      aria-expanded="false">회원관리<span class="caret"></span></a>

     <ul class="dropdown-menu">

      <li ><a href="logoutAction.jsp">로그아웃</a></li>
         </ul>

    </li>

   </ul>
    
 	<%
 		} 
	 %>  

  </div> 

 </nav>
		
<div align=center>

	<h3>[과일 가게]</h3>
	
	<table border="1">
		<tr align="right">
			<td colspan="3">
				<input type="button" value="장바구니 보기" onclick="fnView()" />
				<input type="button" value="물품 추가" onclick="fnproduct()" />
			</td>
		
		</tr>

		
<%		
		out.println("<tr align='center'> [위치 : 경기도 수원시 장안구 파장동 파장천로 46] <br></tr>");
		out.println("<tr align='center'> [영업시간 : 오전 9시 ~ 오후 23시] <br></tr>");
		out.println("<tr align='center'> [휴게시간, 휴무일: 오전 9시 ~ 오후 23시] <br></tr>");
		for(int i = 0; i < img.length; i++) {
			if(i % 3 == 0) { 
				out.println("<tr align='center'>");
			}
			out.println("<td>");
			
				out.println("<table>");

					//물품 나타는 곳
					out.println("<tr align='center'>");
						out.println("<td>");
							out.println("<img src = 'upload/" + img[i] + "' width='150' height='150' />");
						out.println("</td>");
					out.println("</tr>");
					
					out.println("<tr align='center'>");
						out.println("<td>");
							out.println("<b>" + name[i] + "</b>");
						out.println("</td>");
					out.println("</tr>");
					
					out.println("<tr align='center'>");
						out.println("<td>");
							out.println("<b>￦" + price[i] + "원</b>");
						out.println("</td>");
					out.println("</tr>");
					
					out.println("<tr align='center'>");
						out.println("<td>");
							//한 줄로 쓰기
							out.println("<input type='button' value='장바구니 담기' onclick='fnCart(\"" + name[i] + "\", \"" + price[i] + "\")' />");
						out.println("</td>");
					out.println("</tr>");
				out.println("</table>");
			out.println("</td>");
			if(i % 3 == 2) {
				out.println("</tr>");
			}
		}
		%>	
		
	</table>
</div>
</body>

</html>