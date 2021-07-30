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
	String Cid=request.getParameter("id");
	MongoClient mongo = new MongoClient( "localhost" , 27017 );
	DB db= mongo.getDB("OnlineCodingPlatform");
	DBCollection collection = db.getCollection("Competitions");

	DBObject doc = new BasicDBObject();
	BasicDBObject query=new BasicDBObject("_id", new ObjectId(Cid));
		
	DBCursor cursor = collection.find(query);
	doc=cursor.next();
	
	BasicDBObject curs1=(BasicDBObject) doc.get("ParticipatingUsers");
	int size=curs1.size();
	String[] user=new String[size];
	int[] score= new int[size];
	int i=0;
	while(i<size)
	{
		
		String id_score=curs1.toString();
		int indexx= id_score.indexOf(':');
		
		String user_id=id_score.substring(2, indexx-1);
		String sco=id_score.substring(indexx+2,id_score.length()-1);
		
		user[i]=user_id;
		score[i]=Integer.parseInt(sco);
		i++;
	}
	
	for ( i = 0; i < size-1; i++)
        for (int j = 0; j < size-i-1; j++)
            if (score[j] > score[j+1])
            {
                // swap arr[j+1] and arr[j]
                int temp = score[j];
                score[j] = score[j+1];
                score[j+1] = temp;
                
                String tempS=user[j];
                user[j]=user[j+1];
                user[j+1]=tempS;
            }
	
	
	%>
			<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding: 2%;overflow: hidden;">	
					<h3>Rankings for <%=doc.get("Name") %></h3>
					<br/>
    				<table style="border:#ddd inset 1px;;margin: auto;">
    				<tr style="background: #ddd ;">
    					<th style="text-align: center;">Rank</th>
    					<th style="text-align: center;">Username</th>
    					<th style="text-align: center;">Score</th>
    				</tr>
	
	<%
	for ( i = 0; i < size; i++)
	{
		%>
								<tr>
									<td><%=i+1 %></td>
									<td style="text-align: center;"><%=user[i]%></td>
									<td style="text-align: center;"><%=score[i]%></td>
								</tr>
		
		
		<%
	}
%>

</table>
</div>
<div>
         	<jsp:include page="../footer.jsp"></jsp:include>
    	</div>

</body>
</html>