<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		HttpSession log=request.getSession(false);  
		String n = (String)log.getAttribute("Username");
		if(n == null){
			response.sendRedirect("Login.jsp");
		}
		else{
			session.invalidate();
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Signed Out Successfully!!!');");
		   	out.println("location='index.jsp';");
		   	out.println("</script>");
		}
	%>
</body>
</html>