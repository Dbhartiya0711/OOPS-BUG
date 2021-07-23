<%@page import="org.apache.catalina.User"%>
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
</head>
<body>
<%
	HttpSession log=request.getSession(false);
	String Username = (String)log.getAttribute("Username");		
		if(!Username.equals("Verifier_1999"))
			response.sendRedirect("../Practice&Learn/AllProblems.jsp");
	
	
	
		String oid= request.getParameter("id");
		ObjectId obj= new ObjectId(oid);
		String id=obj.toString();
		
		String Name = request.getParameter("Name");
		String Question = request.getParameter("Question");		
		String Input= request.getParameter("Input");
		String Output= request.getParameter("Output");
		String SampleInput= request.getParameter("SampleInput");
		String SampleOutput= request.getParameter("SampleOutput");
		String TimeLimit= request.getParameter("TimeLimit");
		String SourceLimit= request.getParameter("SourceLimit");
		String Verification="Verified";
		
		
		
		String Specifications="Date Added:"+ (new Date()).toString()+"<br/>Time Limit:"+TimeLimit+"<br/>Source Limit:"+SourceLimit+"<br/>Languages:"+"C, JAVA, PYTHON";
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Problems");

		BasicDBObject query = new BasicDBObject("_id",obj);
		
		BasicDBObject doc = new BasicDBObject("Contributor",Username);
		doc.append("Name", Name);
		doc.append("Question", Question);
		doc.append("Input", Input);
		doc.append("Output", Output);
		doc.append("Input", Input);
		doc.append("SampleInput", SampleInput);
		doc.append("SampleOutput", SampleOutput);
		doc.append("Specifications", Specifications);
		doc.append("Difficulty", "Easy");
		doc.append("TotalSubmissions", 0);
		doc.append("SuccessfulSubmissions", 0);
		doc.append("Verification", Verification);
		
		BasicDBObject setdocument = new BasicDBObject("$set",doc);
		
		collection.update(query,setdocument);
		
		MongoClient mongo2 = new MongoClient( "localhost" , 27017 );
		DB db2= mongo2.getDB("OnlineCodingPlatform");
		DBCollection collection2 = db2.getCollection("Users");
		
		
		BasicDBObject query2 = new BasicDBObject();
		query2.put("Username", Username);
		DBObject obj2 = collection2.findOne(query2);
		BasicDBObject newDocument2 = new BasicDBObject();
		
		if(obj2 != null &&   obj2.containsField("Contributions"))
		{
			newDocument2.append("$set", new BasicDBObject().append("Contributions", (String)obj2.get("Contributions")+","+id));
			collection2.update(query2,newDocument2);
			
		}
		else if(obj2!=null)
		{
			newDocument2.append("$set", new BasicDBObject().append("Contributions", id));
			collection2.update(query2,newDocument2);
			
			
		}
%>



</body>
</html>