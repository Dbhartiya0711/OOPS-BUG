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
<link rel="stylesheet" href="../../Styles1.css">
<style type="text/css">
	.button:hover {
	background: #ddd;
}
</style>
<style type="text/css">
	textarea , input{
			font-family: Verdana ;
			background: #f9f9f9;
			line-height: 25px;
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
				   <form action="VerifyProblemData.jsp" method="post">
				    				<%
										if(cursor.hasNext())
										{
											doc=cursor.next();
									%>
						<div>
								<p>Question id: <%= doc.get("_id")%></p>
						</div>
						<div style="display: none;">
							<label>
								Question Id
							</label><br/>
							<input type="text" name="id" value="<%= doc.get("_id")%>"/>
						</div>
						<div>
							<label>
								Question Name
							</label><br/>
							<input type="text" name="Name" value="<%= doc.get("Name")%>"/>
						</div>
						<br/>
						<div>
							<label>
								Question
							</label><br/>
							<textarea rows="20" cols="103" name="Question"><%=doc.get("Question")%></textarea>
						</div>
						<br/>
						<div>
							<label>
								Input
							</label><br/>
								<textarea rows="3" cols="103" name="Input"><%=doc.get("Input")%></textarea>		</div>
						<br/>
						<div>
							<label>
								Output
							</label><br/>
								<textarea rows="3" cols="103" name="Output"><%=doc.get("Output")%></textarea>		</div>
						<br/>
						<div>
							<label>
								Sample Input
							</label><br/>
								<textarea rows="3" cols="103" name="SampleInput"><%=doc.get("SampleInput")%></textarea>		</div>
						<br/>
						<div>
							<label>
								Sample Output
							</label><br/>
								<textarea rows="3" cols="103" name="SampleOutput"><%=doc.get("SampleOutput")%></textarea>		</div>
						<br/>
						<div>
							<label>
								Time Limit
							</label><br/>
							<select name="TimeLimit" style="font-size:15px;width: 120px;height: 22px;padding-left: 5px;background: white;margin-bottom: 10px;" >
								<option value="0.5 secs">0.5 secs</option>
								<option value="1 secs">1 secs</option>
								<option value="1.5 secs">1.5 secs</option>
								<option value="2 secs">2 secs</option>
								<option value="2.5 secs">2.5 secs</option>
								<option value="3 secs">3 secs</option>
								<option value="3.5 secs">3.5 secs</option>
								<option value="4 secs">4 secs</option>
								<option value="4.5 secs">4.5 secs</option>
								<option value="5 secs">5 secs</option>
							</select>
						</div>
						<div>
							<label>
								Source Limit
							</label><br/>
							<select name="SourceLimit" style="font-size:15px;width: 120px;height: 22px;padding-left: 5px;background: white;margin-bottom: 10px;" >
								<option value="25000 bytes">25000 bytes</option>
								<option value="50000 bytes">50000 bytes</option>
								<option value="75000 bytes">75000 bytes</option>
								<option value="100000 bytes">100000 bytes</option>
								<option value="125000 bytes">125000 bytes</option>
								<option value="150000 bytes">150000 bytes</option>
							</select>
						</div>
						<%} %>
						<br/>
						<div style="text-align: center;"><button type="submit" class="button">Verify</button></div>    						
    		</form>
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