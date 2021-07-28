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
<title>Insert title here</title>
</head>
<body>
<%
HttpSession log=request.getSession(false);  
String username = (String)log.getAttribute("Username");
if(username== null )
{
	out.println("Login to view Your Submissions Here");
}
else
{
MongoClient mongo = new MongoClient( "localhost" , 27017 );
DB db= mongo.getDB("OnlineCodingPlatform");
DBCollection collection = db.getCollection("Users");
BasicDBObject query = new BasicDBObject("Username", username);
DBObject doc = collection.findOne(query);
%>
<div style="max-height:800px;overflow:scroll; border: #ddd inset 1px; padding: 3px;padding-top: 0px;margin-top: 10px;">
    				<h4>Your Submissions</h4>
    				<table style="font-size:10px;margin: auto;">
    				<tr style="background: #ddd ;">
    					<th style="padding: 3px;text-align: center;">Problem Id</th>
    					<th style="padding: 3px;text-align: center;">Score</th>
    					<th style="padding: 3px;text-align: center;">Lang</th>
    					<th style="padding: 3px;text-align: center;">Solution</th>
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
									<td style="padding: 3px;"><a style="display: inline-block;" href="../Practice&Learn/Problem.jsp?id=<%=doc1.get("QuestionId") %>"><%=doc1.get("QuestionId") %></a></td>
									<td style="padding: 3px;text-align: center;"><%=doc1.get("Score") %></td>
									<td style="padding: 3px;text-align: center;"><%=doc1.get("Language")%></td>
									<td style="padding: 3px;text-align: center;"><a style="display: inline-block;" href="SubmissionView.jsp?id=<%=sid%>">View</a></td>
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
    			<%} %>
</body>
</html>