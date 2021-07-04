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
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
MongoClient mongo = new MongoClient( "localhost" , 27017 );
DB db= mongo.getDB("OnlineCodingPlatform");
DBCollection collection = db.getCollection("Users");
BasicDBObject doc = new BasicDBObject();
doc = new BasicDBObject();
BasicDBObject query = new BasicDBObject("Email", "devesh.bhartiya0799@gmail.com");
DBCursor cursor = collection.find(query);

out.println(cursor.hasNext());

%>
</body>
</html>
