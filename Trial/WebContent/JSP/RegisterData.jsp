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
<title></title>
</head>
<body>

<%
//this is the code to get the form contents from  createBlog.jsp
String username=request.getParameter("username");
String email=request.getParameter("email");
String password=request.getParameter("password");
String cpassword=request.getParameter("cpassword");


//This is the code to insert the blog details into mongo collection

MongoClient mongo = new MongoClient( "localhost" , 27017 );
DB db= mongo.getDB("OnlineCodingPlatform");
DBCollection collection = db.getCollection("Users");

BasicDBObject doc = new BasicDBObject();
doc = new BasicDBObject();
BasicDBObject query = new BasicDBObject("Email", email);
DBCursor cursor = collection.find(query);

BasicDBObject query1 = new BasicDBObject("Username", username);
DBCursor cursor1 = collection.find(query1);
if(!cursor.hasNext() && !cursor1.hasNext())
{
	doc.append("Email",email);
	doc.append("Username",username);
	doc.append("Password",password);
	doc.append("Name", username);
	doc.append("Country", "India");
	doc.append("Institution","Dayananda Sagar College Of Engineering");
	doc.append("State", "Karnataka");
	collection.insert(doc);
	out.println("<script type=\"text/javascript\">");
   	out.println("alert('Registered Successfully');");
   	out.println("location='Login.jsp';");
   	out.println("</script>");
}
else if(!cursor1.hasNext())
{
	out.println("<script type=\"text/javascript\">");
   	out.println("alert('Another account with same mail id is registered.');");
   	out.println("location='Register.jsp';");
   	out.println("</script>");
}
else
{
	out.println("<script type=\"text/javascript\">");
   	out.println("alert('Please use another Username');");
   	out.println("location='Register.jsp';");
   	out.println("</script>");
}

mongo.close();
%>



</body>
</html>