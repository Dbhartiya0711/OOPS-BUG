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
<link rel="stylesheet" href="../../Styles1.css">
<!-- <style type="text/css">
	a{
		text-decoration: none; 
	}
</style> -->
<%
HttpSession log=request.getSession(false);
String Username = (String)log.getAttribute("Username");		
	if(!Username.equals("Verifier_1999"))
		response.sendRedirect("../Practice&Learn/AllProblems.jsp");
		





		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Problems");

		DBObject doc = new BasicDBObject();
		BasicDBObject query=new BasicDBObject("Verification","Pending");
		
		DBCursor cursor = collection.find(query);
		%>	
</head>
<body>
		
		<div>
         	<jsp:include page="header.jsp"></jsp:include>
    	</div>
	    	
    	<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding: 2%;overflow: hidden;">
    		<div style="width: 71%;float: left;margin: 3% auto;border:#ddd inset 1px;;padding: 15px">
    			<h3>Verify Problems</h3>
    			
    			<br>
    			
    			<table style="border:#ddd inset 1px;;margin: auto;">
    				<tr>
    					<th>Name</th>
    					<th>Code</th>
    					<th>Difficulty</th>
    					<th>Contributor</th>
    				</tr>
    				<%
						while(cursor.hasNext())
						{
							doc=cursor.next();
							
							int totalsubmissions=Integer.parseInt(doc.get("TotalSubmissions").toString());
							int successfulsubmissions=Integer.parseInt(doc.get("SuccessfulSubmissions").toString());
							int accuracy=0;
							if(totalsubmissions !=0)
								accuracy=(int)((successfulsubmissions/totalsubmissions)*100);
					%>
					<tr style="border-bottom: thin;">
						<td><a href="VerifyProblem.jsp?id=<%=doc.get("_id")%>"><%=doc.get("Name")%></a></td>
						<td><a href="VerifyProblem.jsp?id=<%=doc.get("_id")%>"><%=doc.get("_id")%></a></td>
						<td><%=doc.get("Difficulty") %></td>
						<td><%=accuracy%>%</td>
					</tr>
					<%}%>
    			</table>   	
    		</div>
    	</div>
    	
    	<div>
         	<jsp:include page="footer.jsp"></jsp:include>
    	</div>

</body>
</html>