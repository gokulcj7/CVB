<html>
	<head>
	</head>
	
<body>

	<%@ page import="java.sql.*"%>
	<%@page import="javax.servlet.http.*"%>;
	<%
		String username = request.getRemoteUser();
		session.setAttribute("email",username);
		request.getRequestDispatcher("/Otp").include(request,response);
	%>
	



</body>