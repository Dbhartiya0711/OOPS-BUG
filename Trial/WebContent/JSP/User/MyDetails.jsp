<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.mongodb.MongoClient"
    import="com.mongodb.DB"
    import="com.mongodb.DBCollection"
    import="com.mongodb.DBCursor"
    import="com.mongodb.ServerAddress"
    import="com.mongodb.DBObject"
    import="com.mongodb.BasicDBObject"
    import="com.mongodb.WriteConcern"
    import="com.mongodb.Mongo"
    import="com.mongodb.MongoException"
    import="java.util.Arrays"
    import="java.util.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title> My Details</title>
		<link rel="stylesheet" href="../../Styles1.css">
	</head>
	<body >
		<%
		HttpSession log=request.getSession(false);  
		String Username = (String)log.getAttribute("Username");
	   		if(Username== null )
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Login first to access your Details');");
			   	out.println("location='../Login.jsp';");
			   	out.println("</script>");
			}
		%>
		<div>
         	<jsp:include page="header.jsp"></jsp:include>
    	</div>
    	<%
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Users");
		BasicDBObject query = new BasicDBObject("Username", Username);
		DBCursor cursor = collection.find(query);

		DBObject doc = new BasicDBObject();
		%>	
    	<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding: 2%;overflow: hidden;">
    		<div style="width: 71%;float: left;margin: 3% auto;border:#ddd inset 1px;;padding: 15px">
    			<%
						if(cursor.hasNext())
						{
							doc=cursor.next();
				%>
						<p style="font-size: x-large;"><%=doc.get("Name") %></p>
						<hr>
						<table>
						<tr>
							<td>Username:</td>
							<td style="width: 100%"><%=doc.get("Username") %></td>
						</tr>
						<tr>
							<td>Country:</td>
							<td><%=doc.get("Country") %></td>
						</tr>
						<tr>
							<td>State:</td>
							<td><%=doc.get("State") %></td>
						</tr>
						<tr>
							<td>Institution:</td>
							<td><%=doc.get("Institution") %></td>
						</tr>
						
						<tr>
							<td>Questions Solved</td>
							<td><%
							try{
								String solved=doc.get("QuestionsSolved").toString();
							
							StringTokenizer str=new StringTokenizer(solved,",");
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
									You have not solved any Problems yet.
								
								<%
							}
							%></td>
						</tr>
						<tr>
							<td>My Contributions</td>
							<td><%
							try{
								String solved=doc.get("Contributions").toString();
							
							StringTokenizer str=new StringTokenizer(solved,",");
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
									You have not contributed any Problems yet.
								
								<%
							}
							%></td>
						</tr>
						<tr>
							<td>My Competitions</td>
							<td><%
							try{
								String competitions=doc.get("CompetitionsHosted").toString();
							
							StringTokenizer str=new StringTokenizer(competitions,",");
							while(str.hasMoreTokens())
							{
								String cid=str.nextElement().toString();
								%>
									<a style="display: inline-block;" href=""><%=cid%></a>
								<%
								
							}
							}
							catch(Exception e)
							{
								%>
									You have not hosted any yet.
								
								<%
							}
							%></td> 
						</tr>
						
						</table>
						
				
					
					<%}
						
    					else if(Username!= null)
    					{
    						out.println("<script type=\"text/javascript\">");
    					   	out.println("alert('Some Error has Occured');");
    					   	out.println("location='../Login.jsp';");
    					   	out.println("</script>");
    					}
					%>
    		</div>
    	
    		<div style="width: 21%;float: right;margin: 3% auto;margin-left:1%;padding: 15px;border: #ddd inset 1px;">
    			Rating
    		</div>
    	</div>
    	
    	
    	<div>
         	<jsp:include page="footer.jsp"></jsp:include>
    	</div>
	</body>
</html>