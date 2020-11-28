<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.min.css">

<title>jsp 게시판 웹사이트</title>

</head>

<body>
	<!-- 네비게이션  -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expaned="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판</a>
		</div>
		<div class="collapse navbar-collapse"
			id="#bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="ShopMallMain.jsp">쇼핑</a>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">물품추가</a></li>



					</ul></li>

			</ul>

		</div>

	</nav>

	<!-- 로긴폼 -->

	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<!-- 점보트론 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- 로그인 정보를 숨기면서 전송post -->
				<form method="post" action="uploadAction.jsp" enctype="multipart/form-data" >
					<h3 style="text-align: center;"><a href="ShopMallMain.jsp">물품추가</a></h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="물품이름"
							name="product_name" maxlength="20">
					</div>

					<div class="form-group">
						<input type="text" class="form-control" placeholder="가격"
							name="product_value" maxlength="20">
					</div>
	
					<div class="form-group">
						<input type="text" class="form-control" placeholder="재고량"
							name="product_amount" >
					</div>


					<div class="form-group">
						<input type="file" class="form-control" placeholder="이미지"
							name="product_image" >
					</div>



					<div class="form-group">
						<input type="text" class="form-control" placeholder="카테고리"
							name="product_categoly" maxlength="50">
					</div>
					

					<input type="submit" class="btn btn-primary form-control"
						value="물품등록">
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