<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="../Style1.css" rel="stylesheet">
</head>
<body onload="changeHeader();">
<%
		HttpSession log=request.getSession(false);  
		String username = (String)log.getAttribute("Username");
		%>
		<script type="text/javascript">
		function changeHeader() {
			var un="<%=username%>";
			if(un == "null")
				{
					document.getElementById('foruser1').style.display = 'none';
					document.getElementById('foruser2').style.display = 'none';
					document.getElementById('foreveryone').style.display = 'block';
				}
			else
				{
				document.getElementById('foreveryone').style.display = 'none';
				}
		}
	</script>
	
	<div class="navbar" style="">
				<span><a style="padding:0px" href="index.jsp"><img style="width:200px;" alt="OOPS! BUG" src="../Icon1.png"></a></span>			
				<a href="">Code, Compile & Run</a>
				<!-- <a href="">Products</a>Add product,for each product delete product
				 --><div class="dropdown">
				    <button class="dropbtn">Challenges
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				      <a href="">Latest Challenges</a><!-- Current challenge -->
				      <a href="">Past Challenges</a><!-- Past Challenges -->
				      <a href="">Upcoming Challenges</a><!-- Future Challenges -->
				    </div>
				</div>
				<a href="">Discussion Forum</a>
				<a href="">About Us</a>
				<div id="foruser1" style="float: right;" id="" class="dropdown">
				    <button class="dropbtn"><%=username %>
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				      <a href="">My Details</a><!-- Current challenge -->
				      <a href="">My Stats</a><!-- Past Challenges -->
				      <a href="">Contribute</a><!-- Future Challenges -->
				      <a href="">Sign Out</a><!-- Future Challenges -->
				    </div>
				</div>
				<a id="foruser2" style="float: right;" id="" href="">To Do</a>
				<a id="foreveryone" style="float: right;" id="Login.jsp" href="">Login</a>
				
		</div>
</body>
</html>