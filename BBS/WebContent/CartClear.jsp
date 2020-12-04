<%@page import="java.net.URLEncoder" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ page contentType="text/html; charset=UTF-8" %>

<%


session.getAttribute("cart");
session.removeAttribute("cart");

%> 
<script>location.href="main.jsp" </script>

