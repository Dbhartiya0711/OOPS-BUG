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
				<a href="">Compete</a>
				<a href="">About Us</a>
				<div id="foruser1" style="float: right;" id="" class="dropdown">
				    <button class="dropbtn"><%=username %>
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				      <a href="JSP/User/MyDetails.jsp">My Details</a><!-- Current challenge -->
				      <a href="JSP/User/Contribute.jsp">Contribute</a><!-- Past Challenges -->
				      <a href="JSP/User/HostCompetition.jsp">Host Competitions</a><!-- Future Challenges -->
				      <a href="JSP/LogoutData.jsp">Sign Out</a><!-- Future Challenges -->
				    </div>
				</div>
				<div class="dropdown" id="foruser2" style="float: right;">
				    <button class="dropbtn">ToDo
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				    <%
				    	try{
							String competitions=obj2.get("ToDo").toString();
						
						StringTokenizer str=new StringTokenizer(competitions,",");
						while(str.hasMoreTokens())
						{
							String qid=str.nextElement().toString();
							%>
								<a style="display: inline-block;" href="../Problem.jsp?id=<%=qid%>"><%=qid%></a>
							<%
							
						}
						}
						catch(Exception e)
						{
							%>
								<a href="">No To Do's</a>
							
							<%
						}
						%>
				    </div>
				</div>
				<a id="foreveryone" style="float: right;" href="JSP/Login.jsp">Login</a>
				
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
    		New Here? <a style="text-decoration: underline;color: black;" href="JSP/login.jsp">Register</a> to start Coding.
    	</p>
	</div>
    	


<div style="position:fixed;bottom:0px;overflow: hidden;background:white;border-radius:0px;margin-left:-8px;margin-top:-8px;width: 101.05%;color: black;height: 40px;box-shadow: 0px 0px 16px 0px rgba(0,0,0,0.2);">
    		<span style="float: right;padding-right: 25px;font-size: 20px; padding-top: 8px;">&copy;<a href="index.jsp" style="color: inherit; text-decoration: none;"> OOPS! BUG</a></span>
</div>



</body>
</html>