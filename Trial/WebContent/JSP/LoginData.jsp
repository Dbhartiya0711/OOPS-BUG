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
		String user = request.getParameter("Username");
		String pass = request.getParameter("Password");		
		
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Users");

		BasicDBObject doc = new BasicDBObject();
		doc = new BasicDBObject();
		BasicDBObject query = new BasicDBObject("Username", user);
		DBCursor cursor = collection.find(query);
		
		BasicDBObject query1 = new BasicDBObject("Username", user);
		query1.append("Password", pass);
		DBCursor cursor1 = collection.find(query1);
		
		if(cursor.hasNext())
		{
			if(cursor1.hasNext())
			{
				session.setAttribute("Username", user);
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Signed In Successfully!!!');");
			   	out.println("location='../index.jsp';");
			   	out.println("</script>");
			}
			else
			{
				out.println("<script type=\"text/javascript\">");
			   	out.println("alert('Wrong Credentials, Plz Try Again!!!');");
			   	out.println("location='Login.jsp';");
			   	out.println("</script>");
			}
			
		}
		else
		{
			out.println("<script type=\"text/javascript\">");
		   	out.println("alert('Sorry, some error has occurred, Plz Try Again!!!');");
		   	out.println("location='Login.jsp';");
		   	out.println("</script>");
		}
		%>
</body>
</html>