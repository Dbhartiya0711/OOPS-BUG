<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>OOPS! BUG</title>
<link href="Style.css" rel="stylesheet">
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
				<span><a style="padding:0px" href="index.jsp"><img style="width:200px;" alt="OOPS! BUG" src="Images/Icon1.png"></a></span>			
				<div class="dropdown">
				    <button class="dropbtn">Practice & Learn
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				      <a href="JSP/Code,Compile&Run.jsp">Code, Compile & Run</a><!-- Current challenge -->
				      <a href="JSP/Practice&Learn/AllProblems.jsp">Practice Problems</a><!-- Past Challenges -->
				    </div>
				</div>
				<!-- <a href="">Products</a>Add product,for each product delete product
				 --><div class="dropdown">
				    <button class="dropbtn">Compete
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
				      <a href="JSP/User/MyDetails.jsp">My Details</a><!-- Current challenge -->
				      <a href="">My Stats</a><!-- Past Challenges -->
				      <a href="">Contribute</a><!-- Future Challenges -->
				      <a href="JSP/LogoutData.jsp">Sign Out</a><!-- Future Challenges -->
				    </div>
				</div>
				<a id="foruser2" style="float: right;" href="">To Do</a>
				<a id="foreveryone" style="float: right;" href="JSP/Login.jsp">Login</a>
				
		</div>
		

<div>
	
</div>


<div style="position:fixed;bottom:0px;overflow: hidden;background:white;border-radius:0px;margin-left:-8px;margin-top:-8px;width: 101.05%;color: black;height: 40px;box-shadow: 0px 0px 16px 0px rgba(0,0,0,0.2);">
    		<span style="float: right;padding-right: 25px;font-size: 20px; padding-top: 8px;">&copy;<a href="index.jsp" style="color: inherit; text-decoration: none;"> OOPS! BUG</a></span>
</div>



</body>
</html>