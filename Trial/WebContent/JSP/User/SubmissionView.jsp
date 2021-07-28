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
    import="java.util.*"
    import= "org.bson.types.ObjectId;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Submissions</title>
<link rel = "icon" href = "../../Images/IconSite.png">
<link rel="stylesheet" href="../../Styles1.css">
<style type="text/css">
	.button:hover {
	background: #ddd;
}
</style>
<%
		String id=request.getParameter("id");
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Submissions");
		DBObject doc = new BasicDBObject();
		BasicDBObject query = new BasicDBObject();
		query.put("_id", new ObjectId(id));
		
		DBCursor cursor = collection.find(query);
		%>	
		
		
		
		<script type="text/javascript">
				
		</script>
</head>
<body>
		
		<div>
         	<jsp:include page="../header.jsp"></jsp:include>
    	</div>
	    	
    	<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding: 2%;overflow: hidden;">
    		<div style="width: 71%;float: left;margin: 3% auto;margin-top:0.75%; border:#ddd inset 1px;;padding: 15px">
    			
    			<br>
    			
    			<div style="border:#ddd inset 1px;;margin: auto;padding: 15px;">
    				<%
						if(cursor.hasNext())
						{
							doc=cursor.next();
					%>
						<p><span>Question Id: <a href="../Practice&Learn/Problem.jsp?id=<%=doc.get("QuestionId")%>"><%= doc.get("QuestionId")%></a></span></p>
						<hr>
						<p style="line-height: 25px;">Language</p>
						<textarea rows="1" cols="25" disabled="disabled"><%=doc.get("Language")%></textarea>
						<hr>
						<p style="line-height: 25px;"><b>Solution</b>  </p>
						<textarea rows="30" cols="163" disabled="disabled"><%=doc.get("Solution")%></textarea>
						<hr>
						<p style="line-height: 25px;"><b>Result</b>  </p>
						<textarea rows="2" cols="35" disabled="disabled"><%out.print(doc.get("Result")+"\n");%><%=doc.get("Score")%></textarea>
						<hr>
					<%}%>
    			</div>   	
    		</div>
    	
    		<div style="width: 24%;float: right;">
    			<jsp:include page="MySubmissionTable.jsp"></jsp:include>
    		</div>
    	</div>
    	
    	<div>
         	<jsp:include page="../footer.jsp"></jsp:include>
    	</div>

</body>

</html>