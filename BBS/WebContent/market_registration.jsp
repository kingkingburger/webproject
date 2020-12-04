<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>웹사이트</title>
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
           
            	
				out.println("<script>");
				out.println("alert('판매자가 아닙니다.')");
				out.println("location.href = 'main.jsp'");
				out.println("</script>");	
            
            }
             %>
	</div> 
</nav>
	<!-- 로긴폼 -->
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<!-- 점보트론 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- 로그인 정보를 숨기면서 전송post -->
				<form method="post" action="marketAction.jsp">
					<h3 style="text-align: center;">마켓 등록</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="가게이름"
							name="market_name" maxlength="20">
					</div>
					
					
					
					<div class="form-group">
						<input type="text" class="form-control" placeholder="주소(도,특별시)"
							name="market_address1" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="주소(시,군,구)"
							name="market_address2" maxlength="20">
					</div>

					<div class="form-group">
						<input type="text" class="form-control" placeholder="주소(동,읍,면)"
							name="market_address3" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="상세 주소"
							name="market_detailed_address" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="카테고리"
							name="market_categoly" maxlength="50">
					</div>

					<input type="submit" class="btn btn-primary form-control"
						value="마켓 등록">

				</form>
			</div>
		</div>
	</div>


	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>



</body>

</html>
