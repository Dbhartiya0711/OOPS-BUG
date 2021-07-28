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
<title>Insert title here</title>
<link href="../../Styles1.css" rel="stylesheet">
</head>
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
	
	<div class="navbar" style="">
				<span><a style="padding:0px" href="../../index.jsp"><img style="width:200px;" alt="OOPS! BUG" src="../../Images/Icon1.png"></a></span>			
				<div class="dropdown">
				    <button class="dropbtn">Practice & Learn
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				      <a href="../Practice&Learn/Code,Compile&Run.jsp">Code, Compile & Run</a><!-- Current challenge -->
				      <a href="../Practice&Learn/AllProblems.jsp">Practice Problems</a><!-- Past Challenges -->
				    </div>
				</div>
				<a href="../Compete/AllCompetitions.jsp">Compete</a>
				<a href="../../AboutUs.jsp">About Us</a>
				<div id="foruser1" style="float: right;" id="" class="dropdown">
				    <button class="dropbtn"><%=username %>
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				      <a href="../User/MyDetails.jsp">My Details</a><!-- Current challenge -->
				      <a href="../User/HostCompetition.jsp">Host Competitions</a><!-- Future Challenges -->
				      <a id="verifier" href="../User/AllVerify.jsp">Contribute</a><!-- Past Challenges -->
				      <a id="contributor" href="../User/Contribute.jsp">Contribute</a><!-- Future Challenges -->
				      <a href="../../LogoutData.jsp">Sign Out</a><!-- Future Challenges -->
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
								<a style="display: inline-block;" href="../Practice&Learn/Problem.jsp?id=<%=qid%>"><%=qid%></a>
							<%
							
						}
						}
						catch(Exception e)
						{
							%>
								<a>No To Do's</a>
							
							<%
						}
						%>
				    </div>
				</div>
				<a id="foreveryone" style="float: right;" href="../../Login.jsp">Login</a>
				
		</div>
</body>
</html>