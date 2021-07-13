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
		String solution = request.getParameter("Solution");
		String questionId = request.getParameter("QuestionId");		
		String username = request.getParameter("Username");		
		String language= request.getParameter("Language");
		int score=0;//get from compiler
		
		
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Submissions");

		BasicDBObject doc = new BasicDBObject("QuestionId",questionId);
		doc.append("Username", username);
		doc.append("Language", language);
		doc.append("Solution", solution);
		doc.append("Result", "Compiler still to be made");
		doc.append("Score", "Compiler still to be made");
		
		collection.insert(doc);
		Object id = doc.get( "_id" );
		String idd=id.toString();
		
		
		MongoClient mongo1 = new MongoClient( "localhost" , 27017 );
		DB db1= mongo1.getDB("OnlineCodingPlatform");
		DBCollection collection1 = db1.getCollection("Problems");
		BasicDBObject query = new BasicDBObject("_id", new ObjectId(questionId));
	
		DBObject doc1= collection1.findOne(query);
		BasicDBObject newDocument = new BasicDBObject();
		BasicDBObject newDocument1 = new BasicDBObject();
		
		
		 if(score== 100)
		{
			double succesfulsubmissions=Double.parseDouble(doc1.get("SuccessfulSubmissions").toString())+ 1.0;
			newDocument.append("$set", new BasicDBObject().append("SuccessfulSubmissions",succesfulsubmissions));
			collection1.update(query,newDocument);
		}
		
		double totalsubmissions=Double.parseDouble(doc1.get("TotalSubmissions").toString()) +1.0;
		newDocument1.append("$set", new BasicDBObject().append("TotalSubmissions",totalsubmissions));
		collection1.update(query,newDocument1);
		
		
		//Now inserting submission in Users
		MongoClient mongo2 = new MongoClient( "localhost" , 27017 );
		DB db2= mongo2.getDB("OnlineCodingPlatform");
		DBCollection collection2 = db2.getCollection("Users");
		
		
		BasicDBObject query2 = new BasicDBObject();
		query2.put("Username", username);
		DBObject obj2 = collection2.findOne(query2);
		BasicDBObject newDocument2 = new BasicDBObject();
		BasicDBObject newDocument3 = new BasicDBObject();
		
		if(obj2 != null &&   obj2.containsField("Submissions"))
		{
			newDocument2.append("$set", new BasicDBObject().append("Submissions", (String)obj2.get("Submissions")+","+idd));
			collection2.update(query2,newDocument2);
			
		}
		else if(obj2!=null)
		{
			newDocument2.append("$set", new BasicDBObject().append("Submissions", idd));
			collection2.update(query2,newDocument2);
			
			
		}
		try{
		String solved=obj2.get("QuestionsSolved").toString();
		StringTokenizer str=new StringTokenizer(solved,",");
		int flag=0;
		while(str.hasMoreTokens())
		{
			String qid=str.nextElement().toString();
			if(qid.equals(questionId))
			{
				flag=1;
				break;
			}
		}
		if(flag==0 && obj2.containsField("QuestionsSolved"))
		{
			newDocument3.append("$set", new BasicDBObject().append("QuestionsSolved", (String)obj2.get("QuestionsSolved")+","+questionId));
			collection2.update(query2,newDocument3);
		}
		}
		catch(Exception e)
		{
			newDocument3.append("$set", new BasicDBObject().append("QuestionsSolved", questionId));
			collection2.update(query2,newDocument3);
		}
		%>
</body>
</html>