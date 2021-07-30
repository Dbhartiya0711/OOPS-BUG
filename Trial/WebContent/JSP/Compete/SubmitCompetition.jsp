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
    import= "org.bson.types.ObjectId"
    import="java.io.BufferedReader"
	import="java.io.InputStreamReader"
	import="java.net.HttpURLConnection"
	import="java.util.LinkedHashMap"
	import="java.util.Map"
	import="java.io.FileNotFoundException"
	import="java.net.*"
	import="java.net.URLEncoder"
import="java.nio.charset.StandardCharsets"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Submit Competition</title>
<link rel = "icon" href = "../../Images/IconSite.png">
<link rel="stylesheet" href="../../Styles1.css">
</head>
<body>

<div>
         	<jsp:include page="../header.jsp"></jsp:include>
    	</div>
<%
	HttpSession log=request.getSession(false);
	String username = (String)log.getAttribute("Username");
	String id=request.getParameter("id").toString();
	
	MongoClient mongo = new MongoClient( "localhost" , 27017 );
	DB db= mongo.getDB("OnlineCodingPlatform");
	DBCollection collection = db.getCollection("Competitions");
	DBObject doc = new BasicDBObject();
	BasicDBObject query=new BasicDBObject("_id", new ObjectId(id));	
	DBCursor cursor = collection.find(query);
	doc=cursor.next();//doc has competition document
	
	String qids= doc.get("Questions").toString();
	String[] qid=qids.split(",");
	int length=qid.length;
	
	for(int i=0;i<qid.length;i++)
	{
		String QuestionId=qid[i];
		String lang=request.getParameter("Language"+QuestionId);
		String source=request.getParameter("Solution"+QuestionId);
		
		
		URL url = new URL("http://localhost:8080/Trial/JSP/Compete/SubmitCompetitionProblemData.jsp");	
		String urlParameters  = "source=" + source +"&QuestionId="+QuestionId+"&language="+lang+"&username="+username+"&cid="+id;
		byte[] postData       = urlParameters.toString().getBytes("UTF-8");


		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		conn.setRequestProperty("Content-Length", String.valueOf(postData.length));
		conn.setDoOutput(true);
		conn.getOutputStream().write(postData);
		BufferedReader buffread = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		
		String recieve="",buffer="";
		while ((recieve = buffread.readLine()) != null)
		 	buffer += recieve;
		buffread.close();
		
		if(! buffer.contains("Score:"))
		{
			out.print("<script>alert('Some Error has occured.')</script>");
		}	
	}
	
	MongoClient mongo1 = new MongoClient( "localhost" , 27017 );
	DB db1= mongo1.getDB("OnlineCodingPlatform");
	DBCollection collection1 = db1.getCollection("Submissions");
	
	
	int score=0;
	for(int i=0;i<qid.length;i++)
	{
		String QuestionId=qid[i];
		DBObject doc1 = new BasicDBObject();
		BasicDBObject query1=new BasicDBObject("Username", username );
		query1.append("CompetitionId", id);	
		query1.append("QuestionId", QuestionId);
		DBCursor cursor1 = collection1.find(query1);
		int max=0;
		while(cursor1.hasNext())
		{
			doc1=cursor1.next();
			int s=Integer.parseInt(doc1.get("Score").toString());
			if(s>max)
				max=s;
		}
		score=score+max;
	}
		
	
	
	cursor = collection.find(query);
	doc=cursor.next();
	
	
	BasicDBObject newDocument2=new BasicDBObject();

	if(doc != null &&   doc.containsField("ParticipatingUsers"))
	{
		BasicDBObject newDocument3=new BasicDBObject();
		newDocument3 = (BasicDBObject)doc.get("ParticipatingUsers");
		newDocument3.append(username,score);	
		newDocument2.append("$set", new BasicDBObject().append("ParticipatingUsers", newDocument3));
		collection.update(query,newDocument2);
		
	}
	else if(doc!=null)
	{
		BasicDBObject newDocument3=new BasicDBObject();
		newDocument3.append(username,score);	
		newDocument2.append("$set", new BasicDBObject().append("ParticipatingUsers", newDocument3));
		collection.update(query,newDocument2);
		
	}
	
	
	MongoClient mongo2 = new MongoClient( "localhost" , 27017 );
	DB db2= mongo2.getDB("OnlineCodingPlatform");
	DBCollection collection2 = db2.getCollection("Users");
	DBObject doc2 = new BasicDBObject();
	BasicDBObject query2=new BasicDBObject("Username", username);	
	DBCursor cursor2 = collection2.find(query2);
	doc2=cursor2.next();//doc2 has users document
	
	newDocument2=new BasicDBObject();

	if(doc2 != null &&   doc2.containsField("CompetitionsParticipated"))
	{
		BasicDBObject newDocument3=new BasicDBObject();
		newDocument3 = (BasicDBObject)doc2.get("CompetitionsParticipated");
		newDocument3.append(id,score);	
		newDocument2.append("$set", new BasicDBObject().append("CompetitionsParticipated", newDocument3));
		collection2.update(query2,newDocument2);
		
	}
	else if(doc2!=null)
	{
		BasicDBObject newDocument3=new BasicDBObject();
		newDocument3.append(id,score);	
		newDocument2.append("$set", new BasicDBObject().append("CompetitionsParticipated", newDocument3));
		collection2.update(query2,newDocument2);
		
	}
	

	log.removeAttribute("sec");
	
	
%>
<div>
	<br/><br/><br/><br/><br/><br/><br/><br/>
	<p style="text-align: center;font-size: 25px;">
    		Your Username: <%=username %><br/>
    		Your Score: <%=score %><br/>
    		<a style="text-decoration: underline;color: black;" href="Rankings">Rankings</a>
    	</p>
</div>


<div>
         	<jsp:include page="../footer.jsp"></jsp:include>
    	</div>

</body>
</html>