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
		
		
		
		<script type="text/javascript">
		var myFuncCalls = 0;
			function AddToDo() 
			{
				myFuncCalls++;
				if("<%=(String)session.getAttribute("Username")%>" == "null")
				{
					alert("To add to ToDo, first Login");
				}
				else
					{
						if(myFuncCalls==1)
							{
								location.replace(document.URL+"&ToDo=\"True\"");
							}
							<%
						 String Todo=(String)request.getParameter("ToDo");
						if(Todo != null)
						{
							DBCollection coll1 = db.getCollection("Users");
							BasicDBObject query1 = new BasicDBObject();
							query1.put("Username", (String)session.getAttribute("Username"));
							DBObject obj1 = coll1.findOne(query1);
							BasicDBObject newDocument = new BasicDBObject();

							try{
								String solved=obj1.get("ToDo").toString();
								StringTokenizer str=new StringTokenizer(solved,",");
								int flag=0;
								while(str.hasMoreTokens())
								{
									String qid=str.nextElement().toString();
									if(qid.equals(id))
									{
										flag=1;
										break;
									}
								}
								if(flag==0 && obj1.containsField("ToDo"))
								{
									newDocument.append("$set", new BasicDBObject().append("ToDo", (String)obj1.get("ToDo")+","+id));
									coll1.update(query1,newDocument);
								}
								}
								catch(Exception e)
								{
									newDocument.append("$set", new BasicDBObject().append("ToDo", id));
									coll1.update(query1,newDocument);
								}
						}
						%>
					}
				
			}
		
		</script>
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
						<p><span style="text-align: left;font-size:xx-large;"><%= doc.get("Name")%>     </span><span>Code: <%= doc.get("_id")%></span>  <button class="button" style="border-radius:3px;border:none;background:white;color:black;display: inline-block;font-size:15px;text-align: center;height:25px;width:80px;box-shadow: 4px 4px 8px 0px rgba(0,0,0,0.2);float: right;" onclick="AddToDo()">ToDo</button></p>
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
							<button class="button" onclick="location='SubmitProblem.jsp?id=<%=doc.get("_id") %>'" >Submit</button>
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