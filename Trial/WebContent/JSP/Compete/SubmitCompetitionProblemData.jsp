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
import="java.nio.charset.StandardCharsets"%><%
	
		String sourceCode= URLEncoder.encode(request.getParameter("source"), StandardCharsets.UTF_8.toString());
		String language= request.getParameter("language");	
		String questionId = request.getParameter("QuestionId");		
		String username = request.getParameter("username");
		String sol=request.getParameter("source");
		String competitionId=request.getParameter("competitionId");
		
		int compilerId=41;

		if(language.equals("C++"))
			compilerId=41;

		if(language.equals("Java"))
			compilerId=10;

		if(language.equals("Python"))
			compilerId=116;				
		
		MongoClient mongo1 = new MongoClient( "localhost" , 27017 );
		DB db1= mongo1.getDB("OnlineCodingPlatform");
		DBCollection collection1 = db1.getCollection("Problems");
		BasicDBObject query = new BasicDBObject("_id", new ObjectId(questionId));
		DBObject doc1 = new BasicDBObject();
		doc1= collection1.findOne(query);
		DBObject testCases = new BasicDBObject();
		testCases= (DBObject)doc1.get("testCases");
		
		DBObject testCaseN = new BasicDBObject();
		
		int count=0;
		
		
		for(int i=1;i<=15;i++)
		{
			String inputhere="";
			String outputhere="";
			try{
			testCaseN = (DBObject) testCases.get("testCase"+i);
			inputhere= testCaseN.get("input").toString();
			outputhere= testCaseN.get("output").toString();
			}
			catch(NullPointerException e) {
				break;
			}
			String buffer="";
			String recieve="";
			URL url = new URL("https://78cd5828.compilers.sphere-engine.com/api/v4/submissions?access_token=a522dbaf2025d7555f205a53314fba6a");	
			String urlParameters  = "compilerId="+compilerId+"&source="+sourceCode+"&input="+inputhere;
			byte[] postData       = urlParameters.toString().getBytes("UTF-8");


			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("Content-Length", String.valueOf(postData.length));
			conn.setDoOutput(true);
			conn.getOutputStream().write(postData);
			BufferedReader buffread = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			while ((recieve = buffread.readLine()) != null)
			 	buffer += recieve;
			buffread.close();

			String submission=buffer.substring(6,buffer.length()-1);
			int submissionId=Integer.parseInt(submission);

			Thread.sleep(5000); 
			URL url1 = new URL("https://78cd5828.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"?access_token=a522dbaf2025d7555f205a53314fba6a");
			HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();
			conn1.setRequestMethod("GET");
			/* conn1.setRequestProperty("Accept", "application/json");
			if (conn1.getResponseCode() != 200) {
			    out.println("Failed : HTTP Error code : "+ conn1.getResponseCode());
			} */
			InputStreamReader in = new InputStreamReader(conn1.getInputStream());
			BufferedReader br = new BufferedReader(in);
			String output=br.readLine();
			buffer="";
			while ((buffer = br.readLine()) != null)
					output=output+"\n"+buffer;
			//out.println(output);
			 
			String AccessToken="a522dbaf2025d7555f205a53314fba6a";
			String output1="";
			try{
			String urioutput= "https://78cd5828.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"/output?access_token=a522dbaf2025d7555f205a53314fba6a";

			URL url2 = new URL(urioutput.toString());
			HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
			InputStreamReader in1 = new InputStreamReader(conn2.getInputStream());
			BufferedReader br1 = new BufferedReader(in1);
			output1 = br1.readLine();
			buffer="";
			while ((buffer = br1.readLine()) != null)
					output1=output1+"\n"+buffer;
			//out.print(output1);
			}

			catch(FileNotFoundException e){
				try{
				String urioutput= "https://78cd5828.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"/cmpinfo?access_token=a522dbaf2025d7555f205a53314fba6a";    
			    URL url3= new URL(urioutput.toString());
			    HttpURLConnection conn3 = (HttpURLConnection) url3.openConnection();
			    InputStreamReader in1 = new InputStreamReader(conn3.getInputStream());
			    BufferedReader br1 = new BufferedReader(in1);
			    output1=br1.readLine();
			    buffer="";
			    while ((buffer = br1.readLine()) != null)
			    	output1=output1+"\n"+buffer;
			    //out.print(output1);
				}
				catch(FileNotFoundException e1)
				{
					Thread.sleep(2000);
					String urioutput= "https://78cd5828.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"/error?access_token=a522dbaf2025d7555f205a53314fba6a";    
				    URL url3= new URL(urioutput.toString());
				    HttpURLConnection conn3 = (HttpURLConnection) url3.openConnection();
				    InputStreamReader in1 = new InputStreamReader(conn3.getInputStream());
				    BufferedReader br1 = new BufferedReader(in1);
				    output1=br1.readLine();
				    buffer="";
				    while ((buffer = br1.readLine()) != null)
				    	output1=output1+"\n"+buffer;
				    //out.print(output1);
				}
			}
			
			if(output1.equals(outputhere))
				count++;
		}
		
		
		int scorefromcompiler=(int)((count*100)/5);
		String result="";
		if(scorefromcompiler==0)
		{
			result="Wrong Answer";
			out.print("Wrong Answer\n");
			out.print("Score: "+scorefromcompiler);
		}
		else if(scorefromcompiler<100)
		{
			result="Partially Accepted";
			out.print("Partially Accepted\n");
			out.print("Score: "+scorefromcompiler);
		}
		else
		{
			result="Answer Accepted";
			out.print("Answer Accepted\n");
			out.print("Score: "+scorefromcompiler);
		}
%>
	<%	
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Submissions");

		BasicDBObject doc = new BasicDBObject("QuestionId",questionId);
		doc.append("Username", username);
		doc.append("Language", language);
		doc.append("Solution", sol);
		doc.append("Result", result);
		doc.append("Score", scorefromcompiler);
		doc.append("CompetitionId", competitionId);
		
		collection.insert(doc);
		Object id = doc.get( "_id" );
		String idd=id.toString();
		
		
		
		doc1= collection1.findOne(query);
		BasicDBObject newDocument = new BasicDBObject();
		BasicDBObject newDocument1 = new BasicDBObject();
		
		
		 if(scorefromcompiler>=60)
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
		BasicDBObject newDocument4 = new BasicDBObject();
		
		int submissionNumber=0;
		
		
		if(obj2 != null &&   obj2.containsField("Submissions"))
		{
			String solved=obj2.get("Submissions").toString();
			StringTokenizer str=new StringTokenizer(solved,",");
			submissionNumber= str.countTokens();
			
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
		try{
			int rating = Integer.parseInt(obj2.get("Rating").toString());
			int newrating= (int)(((((rating/25)*submissionNumber)+ scorefromcompiler)/(submissionNumber+1))*25);
			
			newDocument3.append("$set", new BasicDBObject().append("Rating", newrating));
			collection2.update(query2,newDocument3);
			}
			catch(Exception e)
			{
				newDocument3.append("$set", new BasicDBObject().append("Rating", (scorefromcompiler*25)));
				collection2.update(query2,newDocument3);
				
			}
		%>