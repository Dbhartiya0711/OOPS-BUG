<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body onload="checkpasswords();">
<script type="text/javascript">
function checkpasswords()
{
	var pass=document.getElementById("pass").value;
	var cpass=document.getElementById("cpass").value;
	if(pass==cpass && pass!="")
		{
			document.getElementById("para").style.display="None";
			document.getElementById("para").innerHTML="Paswords Match";
			document.getElementById("submitbutton").disabled=false;
		}
		else if(pass!="")
		{
			document.getElementById("para").style.display="Block";
			document.getElementById("para").innerHTML="Paswords Dont Match";
			document.getElementById("submitbutton").disabled=true;
		}
		else
			{
			document.getElementById("submitbutton").disabled=true;
			}
}
</script>
<form action="RegisterData.jsp">
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
</body>
</html>