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
<title>Let's Compete</title>
<link rel = "icon" href = "../../Images/IconSite.png">
<link rel="stylesheet" href="../../Styles1.css">
<%
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Competitions");

		DBObject doc = new BasicDBObject();
		BasicDBObject query=new BasicDBObject();
		
		DBCursor cursor = collection.find();
		%>	
</head>
<body>
		
		<div>
         	<jsp:include page="../header.jsp"></jsp:include>
    	</div>
	    	
    	<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding: 2%;overflow: hidden;">
    		<div style="width: 71%;float: left;margin: 2% auto;border:#ddd inset 1px;;padding: 15px">
    			<h3>Let's Compete</h3>
    			
    			<br>
    			
    			<table style="border:#ddd inset 1px;;margin: auto;">
    				<tr>
    					<th>Name</th>
    					<th>Code</th>
    					<th>Start</th>
    					<th>End</th>
    				</tr>
    				<%
						while(cursor.hasNext())
						{
							doc=cursor.next();
							
							String Start = doc.get("DateStart").toString()+" "+doc.get("TimeStart").toString();
							String End = doc.get("DateEnd").toString()+" "+doc.get("TimeEnd").toString();;
					%>
					<tr style="border-bottom: thin;">
						<td><a href="Competition.jsp?id=<%=doc.get("_id")%>"><%=doc.get("Name")%></a></td>
						<td><a href="Competition.jsp?id=<%=doc.get("_id")%>"><%=doc.get("_id")%></a></td>
						<td><%=Start %></td>
						<td><%=End %></td>
					</tr>
					<%}%>
    			</table>   	
    		</div>
    	
    		<div style="width: 25%;float: right;margin-top: 1%">
    			<jsp:include page="../User/MySubmissionTable.jsp"></jsp:include>
    		</div>
    	</div>
    	
    	<div>
         	<jsp:include page="../footer.jsp"></jsp:include>
    	</div>

</body>
</html>