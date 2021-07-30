<%@page import="org.bson.types.ObjectId"%>
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
		<link rel = "icon" href = "../../Images/IconSite.png">
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
			   	out.println("location='../../Login.jsp';");
			   	out.println("</script>");
			}
		%>
		<div>
         	<jsp:include page="../header.jsp"></jsp:include>
    	</div>
    	<%
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Users");
		BasicDBObject query = new BasicDBObject("Username", Username);
		DBCursor cursor = collection.find(query);

		DBObject doc = new BasicDBObject();
		%>	
    	<div style="width: 85% ; border:#ddd inset 1px;;margin: 1% auto;padding: 2%;overflow: hidden;">
    		<div style="width: 67%;float: left;margin: 3% auto;border:#ddd inset 1px;;padding: 15px">
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
									<a style="display: inline-block;" href="../Practice&Learn/Problem.jsp?id=<%=qid%>"><%=qid%></a> , 
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
									<a style="display: inline-block;" href="../Practice&Learn/Problem.jsp?id=<%=qid%>"><%=qid%></a> , 
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
							<td>Competitions Hosted</td>
							<td><%
							try{
								String competitions=doc.get("CompetitionsHosted").toString();
							
							StringTokenizer str=new StringTokenizer(competitions,",");
							while(str.hasMoreTokens())
							{
								String cid=str.nextElement().toString();
								%>
									<a style="display: inline-block;" href=""><%=cid%></a> , 
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
						
				
					
					
    		</div>
    	
    		<div style="width: 25%;float: right;margin: 3% auto;margin-left:1%;padding: 15px;border: #ddd inset 1px;">
    			<div style="border: #ddd inset 1px; padding: 5px;padding-top: 0px;">
    				<h3 style="margin-bottom:20px;"><%=(Integer.parseInt(doc.get("Rating").toString()))%></h3>
    				<h3 style="font-size: 0px;">
    				<%
    				int star=0;
    				int ratingscore=(int) (Integer.parseInt(doc.get("Rating").toString()))/25;
    				if(ratingscore >0 && ratingscore<=20)
    					star=1;
    				else if (ratingscore >20 && ratingscore<=40)
						star=2;
    				else if (ratingscore >40 && ratingscore<=60)
						star=3;
    				else if (ratingscore >60 && ratingscore<=80)
						star=4;
    				else if (ratingscore >80 && ratingscore<=100)
						star=5;
    				
    				for(int i=1;i<=star;i++)
    				{
    				%>
    					<img alt="star" src="../../Images/star.png" width="30px" height="30px" style="margin: 0px;padding: 0px;">	
    				<%} %>
    				</h3>
    				<%}
						
    					else if(Username!= null)
    					{
    						out.println("<script type=\"text/javascript\">");
    					   	out.println("alert('Some Error has Occured');");
    					   	out.println("location='../../Login.jsp';");
    					   	out.println("</script>");
    					}
					%>
    				
    				
    				
    				<h4>Rating</h4>
    				<div style="max-height:300px;overflow:scroll; border: #ddd inset 1px; padding: 3px;padding-top: 0px;margin-top: 10px;">
    				<h4>Your Competitions</h4>
    				<table style="font-size:10px;margin: auto;">
    				<tr style="background: #ddd ;">
    					<th style="padding: 3px;padding-right: 8px;text-align: center;">Competition Id</th>
    					<th style="padding: 3px;padding-right: 8px;text-align: center;">Score</th>
    				</tr>
    				
    					<%
    					try{
							BasicDBObject curs1=(BasicDBObject) doc.get("CompetitionsParticipated");
							int size=curs1.size();
							int i=1;
							while(i<=size)
							{
								i++;
								String id_score=curs1.toString();
								
								int indexx= id_score.indexOf(':');
								String comp_id=id_score.substring(2, indexx-1);
								String sco=id_score.substring(indexx+2,id_score.length()-1);
								
								%>
								<tr>
									<%-- <td style="padding: 3px;" colspan="2"> <%=id_score %> </td>
									 --%>
									 <td style="padding: 3px;padding-right: 8px;text-align: center;" > <%=comp_id %> </td>
									<td style="padding: 3px;padding-right: 8px;text-align: center;" > <%=sco %> </td>
								</tr>
								<%
								
							}
							}
							catch(Exception e)
							{
								%>
									<tr><td colspan="4">You have not solved any Problems yet.</td></tr>
								
								<%
							}
							%>
    				</table>
    			
    			</div>
    				
    				</div>
    			<%-- <div style="max-height:800px;overflow:scroll; border: #ddd inset 1px; padding: 5px;padding-top: 0px;margin-top: 10px;">
    				<h4>Your Submissions</h4>
    				<table style="font-size:10px;margin: auto;">
    				<tr style="background: #ddd ;">
    					<th style="padding: 5px;text-align: center;">Problem Id</th>
    					<th style="padding: 5px;text-align: center;">Score</th>
    					<th style="padding: 5px;text-align: center;">Lang</th>
    					<th style="padding: 5px;text-align: center;">Solution</th>
    				</tr>
    				
    					<%
							try{
							String submissions=doc.get("Submissions").toString();
							StringTokenizer str=new StringTokenizer(submissions,",");
							MongoClient mongo1 = new MongoClient( "localhost" , 27017 );
							DB db1= mongo1.getDB("OnlineCodingPlatform");
							DBCollection collection1 = db1.getCollection("Submissions");
							DBObject doc1;
							while(str.hasMoreTokens())
							{
								String sid=(str.nextElement()).toString();
								
								BasicDBObject query1 = new BasicDBObject("_id", new ObjectId(sid));
								doc1= collection1.findOne(query1);
								
								%>
								<tr>
									<td style="padding: 5px;"><a style="display: inline-block;" href="../Practice&Learn/Problem.jsp?id=<%=doc1.get("QuestionId") %>"><%=doc1.get("QuestionId") %></a></td>
									<td style="padding: 5px;text-align: center;"><%=doc1.get("Score") %></td>
									<td style="padding: 5px;text-align: center;"><%=doc1.get("Language")%></td>
									<td style="padding: 5px;text-align: center;"><a style="display: inline-block;" href="SubmissionView.jsp?id=<%=sid%>">View</a></td>
								</tr>
								<%
								
							}
							}
							catch(Exception e)
							{
								%>
									<tr><td colspan="4">You have not solved any Problems yet.</td></tr>
								
								<%
							}
							%>
    				</table>
    			
    			</div> --%>
    			<div>
    				<jsp:include page="MySubmissionTable.jsp"></jsp:include>
    			</div>
    			
    			
    		</div>
    	</div>
    	
    	
    	<div>
         	<jsp:include page="../footer.jsp"></jsp:include>
    	</div>
	</body>
</html>