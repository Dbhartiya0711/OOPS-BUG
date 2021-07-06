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
<title>Problem</title>
<link rel="stylesheet" href="../Styles.css">
<style type="text/css">
	.button:hover {
	background: #ddd;
}
</style>
<%
		String id=request.getParameter("id");
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Problems");
		DBObject doc = new BasicDBObject();
		BasicDBObject query = new BasicDBObject();
		query.put("_id", new ObjectId(id));
		
		DBCursor cursor = collection.find(query);
		%>	
</head>
<body>
		
		<div>
         	<jsp:include page="header.jsp"></jsp:include>
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
						<p><span style="text-align: left;font-size:xx-large;"><%= doc.get("Name")%>     </span><span>Code: <%= doc.get("_id")%></span></p>
						<hr>
						<p style="line-height: 25px;"><% out.println(doc.get("Question"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Input</b> <br> <% out.println(doc.get("Input"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Output</b> <br> <% out.println(doc.get("Output"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Sample Input</b> <br> <% out.println(doc.get("SampleInput"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Sample Output</b> <br> <% out.println(doc.get("SampleOutput"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Specifications</b> <br> <% out.println(doc.get("Specifications"));%></p>
						
						<div style="text-align: center;">
							<button class="button" onclick="" >Submit</button>
						</div>
					<%}%>
    			</div>   	
    		</div>
    	
    		<div style="width: 21%;float: right;margin: 3% auto;margin-top:0.75%;margin-left:1%;padding: 15px;border: #ddd inset 1px;">
    			My Submissions
    		</div>
    	</div>
    	
    	<div>
         	<jsp:include page="footer.jsp"></jsp:include>
    	</div>

</body>
</html>