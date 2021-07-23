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
		String Name = request.getParameter("Name");
		String Question = request.getParameter("Question");		
		String Input= request.getParameter("Input");
		String Output= request.getParameter("Output");
		String SampleInput= request.getParameter("SampleInput");
		String SampleOutput= request.getParameter("SampleOutput");
		String TimeLimit= request.getParameter("TimeLimit");
		String SourceLimit= request.getParameter("SourceLimit");
		String Verification="Pending";
		
		
		
		String Specifications="Date Added:"+ (new Date()).toString()+"\nTime Limit:"+TimeLimit+"\nSource Limit:"+SourceLimit+"\nLanguages:"+"C, JAVA, PYTHON";
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Problems");

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
		

	collection.insert(doc);
	Object id = doc.get("_id");
	String idd = id.toString();
%>



</body>
</html>