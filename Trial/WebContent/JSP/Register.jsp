<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register for OOPS! BUG</title>
<link href="../Style.css" rel="stylesheet/css">
</head>
<body onload="checkpasswords();changeHeader();checkforregister();">
<script type="text/javascript">
function checkforregister() {
	<%
	HttpSession log1=request.getSession(false);  
	String username1 = (String)log1.getAttribute("Username");
	%>
	var un="<%=username1%>";
	if(un != "null")
		{
			alert('Already Signed In. Cannot Register.');
			location="../index.jsp";
	   	}
}

function checkpasswords()
{
	var pass=document.getElementById("pass").value;
	var cpass=document.getElementById("cpass").value;
	if(pass==cpass && pass!="")
		{
		document.getElementById("para").style.color="Green";
			document.getElementById("para").innerHTML="Paswords Match";
			document.getElementById("submitbutton").disabled=false;
		}
		else if(pass!="")
		{
			document.getElementById("para").style.display="Block";
			document.getElementById("para").style.color="Red";		
			document.getElementById("para").innerHTML="Paswords Don't Match";
			document.getElementById("submitbutton").disabled=true;
		}
		else
			{
			document.getElementById("submitbutton").disabled=true;
			}
}
</script>
<div>
	<jsp:include page="header.jsp"></jsp:include>
</div>

<div class="block">
			<h3 style="padding-bottom: 25px;">Register</h3>
			<form action="RegisterData.jsp" method="post">
				<div class="clear">
					<label class="label">
						Username
					</label>
					<input class="input" type="text" name="username" required="required" autocomplete="username"/>
					<br/>
				</div>
				<div>
					<label class="label">
						Email
					</label>
					<input class="input" type="email" name="email" required="required" autocomplete="email"/>
					<br/>
				</div>
				<div>
					<label class="label">
						Password
					</label>
					<input class="input" type="password" name="password" required="required" onkeyup="checkpasswords();" id="pass"/>
					<br/>
				</div>
				<div>
					<label class="label">
						Confirm Password
					</label>
					<input class="input" type="password" name="cpassword" required="required" onkeyup="checkpasswords();" id="cpass"/>
					<br/>
				</div>
					<p id="para" style="display: none;max-width: 200px;margin: auto;">Pass Match</p>
				<div class="clear" style="text-align: center;">
					<br/>
					<button class="button" type="submit" id="submitbutton">Register</button>
				</div>
			</form>
		</div>


<!-- <form action="RegisterData.jsp">
	<label>Username</label>
	<input type="text" required="required" name="username">
	<label>Email</label>
	<input type="email" required="required" name="email">
	<label>Password</label>
	<input type="password" required="required" name="password" onkeyup="checkpasswords();" id="pass">
	<label>Confirm Password</label>
	<input type="password" required="required" name="cpassword" onkeyup="checkpasswords();" id="cpass">
	<br/>
	<p id="para" style="display: none;">Pass Match</p>
	<br/>
<button id="submitbutton" >Submit</button>
</form>
-->
<div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>