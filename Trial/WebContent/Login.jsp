<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title> Login</title>
		<link rel = "icon" href = "Images/IconSite.png">
		<link href="Styles1.css" rel="stylesheet/css">
	</head>
	<body >
	
		<div>
         	<jsp:include page="header.jsp"></jsp:include>
    	</div>
    	
		<br/><br/>
		<div class="block" style="min-height: 100%;">
			<h3 style="padding-bottom: 25px;">Login</h3>
			<form action="LoginData.jsp" method="post">
				<div>
					<label class="label">
						Username
					</label>
					<input class="input" type="text" name="Username" required="required" autocomplete="username"/>
				</div>
				<div class="clear">
					<label class="label">
						Password
					</label>
					<input class="input" type="password" name="Password" required="required" autocomplete="current-password"/>
				</div>
				
				<div class="clear" style="text-align: center;">
					
					<button class="button" type="submit">Login</button>
					
				</div>
			</form>
			<br/>
				<p style="max-width: 350px;margin: auto;">Don't Have an Account yet? Register <a href="Register.jsp">Here.</a></p>
		</div>
		<div>
         	<jsp:include page="footer.jsp"></jsp:include>
    	</div>
	</body>
</html>