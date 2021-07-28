<%@page import="javax.jws.soap.SOAPBinding.Use"%>
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
    
   <%-- <% 
   		/*For Setting Test Cases*/
   
   
   
   MongoClient mongo1 = new MongoClient( "localhost" , 27017 );
		DB db1= mongo1.getDB("OnlineCodingPlatform");
		DBCollection collection1 = db1.getCollection("Problems");
		BasicDBObject query = new BasicDBObject("_id", new ObjectId("60e2948bc51d84128afb1179"));
	
	
		BasicDBObject testCase1 = new BasicDBObject();
		testCase1.append("input", "8");
		testCase1.append("output", "YES");
		
		BasicDBObject testCase2 = new BasicDBObject();
		testCase2.append("input", "5");
		testCase2.append("output", "NO");
		
		BasicDBObject testCase3 = new BasicDBObject();
		testCase3.append("input", "4");
		testCase3.append("output", "YES");
		
		BasicDBObject testCase4 = new BasicDBObject();
		testCase4.append("input", "3");
		testCase4.append("output", "NO");
		
		BasicDBObject testCase5 = new BasicDBObject();
		testCase5.append("input", "2");
		testCase5.append("output", "NO");
		
		
		BasicDBObject testCases = new BasicDBObject();
		testCases.append("testCase1", testCase1);
		testCases.append("testCase2", testCase2);
		testCases.append("testCase3", testCase3);
		testCases.append("testCase4", testCase4);
		testCases.append("testCase5", testCase5);
		
		BasicDBObject testCasesUpdate = new BasicDBObject();
		testCasesUpdate.append("$set", new BasicDBObject().append("testCases", testCases));
		collection1.update(query,testCasesUpdate);
   
   %> --%> 
    
    
    
    
    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert title here</title>
	<%

	HttpSession log=request.getSession(false);  
	String Username = (String)log.getAttribute("Username");
	%>
	
	<script type="text/javascript">
	function checkforlogin() {
		var un="<%=Username%>";
		if(un == "null")
			{
				alert('Please Login to Host Competition.');
				location="../../Login.jsp";
		   	}
	}
	
	</script>
	
	</head>
	<body onload="checkforlogin();">
		<%
		String Name = request.getParameter("CompetitionName");
		String dateTimeStart = request.getParameter("dateTimeStart");		
		String dateTimeEnd= request.getParameter("dateTimeEnd");
		String TimeForCompetition=request.getParameter("TimeForCompetition");
		String [] questions= request.getParameterValues("checkboxes");
		String questionString="";
		if (questions != null) 
		   {
		      for (int i = 0; i < questions.length; i++) 
		      {
		    	  questionString=questionString+questions[i]+",";
		      }
		   }
		String[] Start=dateTimeStart.split("T");
		String[] End=dateTimeEnd.split("T");
		
		String DateStart= Start[0];
		String DateEnd = End[0];
		String TimeStart = Start[1];
		String TimeEnd = End[1];
		
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Competitions");

		BasicDBObject doc = new BasicDBObject("Name",Name);
		doc.append("Host", Username);
		doc.append("DateStart", DateStart);
		doc.append("TimeStart", TimeStart);
		doc.append("DateEnd", DateEnd);
		doc.append("TimeEnd", TimeEnd);
		doc.append("TimeForCompetition",TimeForCompetition);
		doc.append("Questions", questionString);
		doc.append("RegisteredUsers","");
		
		collection.insert(doc);
		Object id = doc.get( "_id" );
		String idd=id.toString();
		
		MongoClient mongo1 = new MongoClient( "localhost" , 27017 );
		DB db1= mongo1.getDB("OnlineCodingPlatform");
		DBCollection collection1 = db1.getCollection("Users");
		BasicDBObject query = new BasicDBObject("Username", Username);
		DBObject obj2 = collection1.findOne(query);
		BasicDBObject newDocument2 = new BasicDBObject();
		
		
		if(obj2 != null &&   obj2.containsField("CompetitionsHosted"))
		{
			newDocument2.append("$set", new BasicDBObject().append("CompetitionsHosted", (String)obj2.get("CompetitionsHosted")+","+idd));
			collection1.update(query,newDocument2);
			
		}
		else if(obj2!=null)
		{
			newDocument2.append("$set", new BasicDBObject().append("CompetitionsHosted", idd));
			collection1.update(query,newDocument2);
		}

		%>
	</body>
</html>