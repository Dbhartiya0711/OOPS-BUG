<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.mongodb.MongoClient"
    import="com.mongodb.DB"
    import="com.mongodb.*"
    import="com.mongodb.DBCollection"
    import="com.mongodb.DBCursor"
    import="com.mongodb.ServerAddress"
    import="com.mongodb.DBObject"
    import="com.mongodb.BasicDBObject"
    import="com.mongodb.WriteConcern"
    import="com.mongodb.Mongo"
    import="com.mongodb.MongoException"
    import="java.util.Arrays"
    import="java.util.*"
    import= "org.bson.types.ObjectId;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>OOPS! BUG</title>
<link rel = "icon" href = "Images/IconSite.png">
<link href="Style.css" rel="stylesheet">
</head>

<style type="text/css">
			h1
			{
			text-align:center;margin: 20px;font-size: 50px;font-weight: 400;
			}
			
			p{
			width: 75%;
			margin: auto;
			text-align: center;
			font-size: 25px;
			}
		</style>
<body onload="changeHeader();">
<%
		HttpSession log=request.getSession(false);  
		String username = (String)log.getAttribute("Username");
		
		MongoClient mongo2 = new MongoClient( "localhost" , 27017 );
		DB db2= mongo2.getDB("OnlineCodingPlatform");
		DBCollection collection2 = db2.getCollection("Users");
		
		
		BasicDBObject query2 = new BasicDBObject();
		query2.put("Username", username);
		DBObject obj2 = collection2.findOne(query2);
		
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
			
			if(un== "Verifier_1999")
			{
			document.getElementById('verifier').style.display = 'block';
			document.getElementById('contributor').style.display = 'none';
			}
		else
			{
			document.getElementById('verifier').style.display = 'none';
			document.getElementById('contributor').style.display = 'block';
			}
		}
	</script>
	
		
<div>
	<jsp:include page="header.jsp"></jsp:include>
</div>
<div>
<br><br><br>
    	<br><br>
    	<br><br>
    	<h1 >WELCOME</h1> 
    	<h4 style="text-align:center;margin: 10px;">TO</h4>
    	<p><a style="padding:0px" href="index.jsp"><img style="width:300px;" alt="OOPS! BUG" src="Images/Icon1.png"></a></p>
    	<br>
    	<p style="text-align: center;">
    		New Here? <a style="text-decoration: underline;color: black;" href="Register.jsp">Register</a> to start Coding.
    	</p>
	</div>
<div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>    	



</body>
</html>