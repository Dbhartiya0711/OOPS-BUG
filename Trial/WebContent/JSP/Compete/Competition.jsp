<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
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
    import="java.util.Arrays"
    import="java.util.*"
    import= "org.bson.types.ObjectId"
    import= "java.text.SimpleDateFormat"	
	import= "java.util.Date;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Competition</title>
<link rel = "icon" href = "../../Images/IconSite.png">
<link rel="stylesheet" href="../../Styles1.css">
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
	
	String Start= doc.get("DateStart")+ "T" +doc.get("TimeStart");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");//give format in which you are receiving the `String dateStart`
    java.util.Date DateStart = sdf.parse(Start);
    
    
    String End= doc.get("DateEnd")+ "T" +doc.get("TimeEnd");
    java.util.Date DateEnd = sdf.parse(End);
    

    Date today = new Date();
    
     
    long sec=0;
    if (today.compareTo(DateStart)>0 && today.compareTo(DateEnd)<0)
    {
		try{
			sec = Long.parseLong(log.getAttribute("sec").toString());
			out.print("<script>alert('"+"Competition will Resume from Where You Left."+"');</script>");
	    	
		}
		catch(Exception e)
		{
			sec= today.getTime() + (Long.parseLong(doc.get("TimeForCompetition").toString()) * 60000)+ 2000;
			log.setAttribute("sec", sec);
			out.print("<script>alert('"+"Competition will Now Start"+"');</script>");
	    	
		}
    
    }
    else
    {
    	out.print("<script>alert('"+"Time for Competition Window has Ended "+"'); location='AllCompetitions.jsp';</script>");
    }
    
	String qids= doc.get("Questions").toString();
	MongoClient mongo1 = new MongoClient( "localhost" , 27017 );
	DB db1= mongo1.getDB("OnlineCodingPlatform");
	DBCollection collection1 = db1.getCollection("Problems");
	DBObject doc1 = new BasicDBObject();


	
	
		String[] qid=qids.split(",");
		int length=qid.length;
		BasicDBObject query1;

%>	
<script>
let qids='<%=qids%>';
const qid=qids.split(","); 

function show(id) {
	for(var i=0;i<qid.length;i++)
	{
		if(qid[i] != "")
			document.getElementById(qid[i]).style.display='none';
	}
	
	document.getElementById(id).style.display='block';
	return false;
	
}

function take_values(a)	
{
	 var n=document.getElementById("IDE"+a).value;
	 
	 if (n==null || n=="") 	
	 {
	 	alert("Write Some Code Before You Compile.");
	 	return false;
	 }
	 else
	 {
		 document.getElementById("idsub"+a).innerHTML="Please Wait While Your Code is Run.";
		 var input=document.getElementById("Input"+a).value;
		 var language=document.getElementById("Language"+a).value;
		 var source=encodeURIComponent(n);
	 	var http = new XMLHttpRequest();
	 	http.open("POST", "http://localhost:8080/Trial/JSP/Compete/CallCompiler.jsp", true);
	 	http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	 	var params = "source=" + source +"&input="+input+"&language="+language; // probably use document.getElementById(...).value
	 	http.send(params);
	 	http.onload = function() 
	 	{
	 	document.getElementById("idsub"+a).innerHTML= http.responseText;
	 	}
	 	return false;
	 } 
}
function submit_values(a){
	 var n=document.getElementById("IDE"+a).value;
	 
	 if (n==null || n=="") {
	 alert("Write Some Code Before You Compile.");
	 return false;
	 }else{
		 document.getElementById("SubmissionResult"+a).innerHTML="Please Wait While Your Code is Run.";
	 var language=encodeURIComponent(document.getElementById("Language"+a).value);
	 var questionid=a;
	 var username=<%=username%>;
	 var source=encodeURIComponent(n);
	 var competitionId="<%=Cid %>";
	 var http = new XMLHttpRequest();
	 http.open("POST", "http://localhost:8080/Trial/JSP/Compete/SubmitCompetitionProblemData.jsp", true);
	 http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	 var params = "source=" + source +"&QuestionId="+questionid+"&language="+language+"&username="+username+"&cid="+competitionId; // probably use document.getElementById(...).value
	 http.send(params);
	 http.onload = function() {
	 document.getElementById("SubmissionResult"+a).innerHTML= "SubmissionResult: \n\n"+http.responseText;
	 }
	 return false;
	 } 
	 } 



var placeholder="#include <iostream>\nusing namespace std;\nint main()\n{\nchar sample[] = \"OOPS-BUG\";\ncout << sample << \" - A computer science portal for geeks\";\nreturn 0;\n}";
function setPlaceholder(a) {
	var id="Language"+a;
	var lang= document.getElementById(id).value;
	if(lang == "Java")
		placeholder="import java.util.*;\nclass MyClass\n{\npublic static void main(String[] args) \n{\nSystem.out.println(\"OOPS-BUG\");\n}\n} ";	
	if(lang == "C++")
		placeholder="#include <iostream>\nusing namespace std;\nint main()\n{\nchar sample[] = \"OOPS-BUG\";\ncout << sample << \" - A coding platform.\";\nreturn 0;\n}";	
	if(lang == "Python")
		placeholder="print(\"OOPS-BUG\");\n";	
		
	document.getElementById("IDE"+a).value=placeholder;
}
</script>
</head>
<body onload="setStartTime();changeHeader();">
	<%-- <div>
       	<jsp:include page="header.jsp"></jsp:include>
   	</div> --%>
   	<div style="position: fixed;top: -1%;background: #ddd;width: 100%;padding-top: 10px;">
   	<h4><span id="demo" style="font-size: 30px; font-weight: 400;"></span></h4>	
				<script>
				// Set the date we're counting down to
				var countDownDate;
				function setStartTime()
				{
						countDownDate = <%= sec %> ;	
				}
				
				// Update the count down every 1 second
				var x = setInterval(function() {
				
				  // Get today's date and time
				  var now = new Date().getTime();
				
				  // Find the distance between now and the count down date
				  var distance = countDownDate - now;
				
				  // Time calculations for days, hours, minutes and seconds
				  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
				  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
				  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
				  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
				  
				  
				  
				  /*
				  if(days==0 && hours==0 && minutes==0 && seconds==0)
				  	
				  	
				  	
				  	
				  	SUBMITTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
				  	
				  	
				  	
				  	
				  	
				  	*/
				  
				  	
				  	
				  	// Display the result in the element with id="demo"
				  var times="";
				  if(days!=0)
					  times=days + "d " ;
				  else
				  times=times+hours + "h "
				  + minutes + "m " + seconds + "s ";
				  document.getElementById("demo").innerHTML = times;
				
				  // If the count down is finished, write some text
				  if (distance < 0) {
				    clearInterval(x);
				    document.getElementById("demo").innerHTML = "EXPIRED";
				  }
				}, 1000);
				</script>
   	</div>
   	<div style="width: 80% ; border:#ddd inset 1px;margin: 1% auto;padding: 2%;overflow: hidden;">
   	<br>
   	
   	<form action="" method="post">
   	<h3><%=doc.get("Name") %>  </h3>
   			
   			
				<div style="width: 21%;float: left;margin: 3% auto;margin-left:1%;padding: 15px;border: #ddd inset 1px;">
   				
   					<table>
   				<%
					
					for(int i=0;i<qid.length;i++)
					{
						query1=new BasicDBObject("_id", new ObjectId(qid[i].toString()));
						DBCursor cursor1 = collection1.find(query1);
						doc1=cursor1.next();	
						
				%>
				<tr style="border-bottom: thin;">
					<td>Q.<%=i+1 %>)</td>
					<td><button onclick="return show('<%=qid[i]%>');setPlaceholder();" style="background: none; border: none;font: inherit;"><%=doc1.get("Name")%></button></td>
				</tr>
				
   					</table>
   				</div>
   				
   		<div style="width: 71%;float: right;margin: 3% auto;border:#ddd inset 1px;padding: 15px">
   		
   				<div id="<%=qid[i]%>">
   						<p style="font-size: 20px;"><b><%= doc1.get("Name")%></b></p>
						<hr>
						<p style="line-height: 25px;"><% out.println(doc1.get("Question"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Input</b> <br> <% out.println(doc1.get("Input"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Output</b> <br> <% out.println(doc1.get("Output"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Sample Input</b> <br> <% out.println(doc1.get("SampleInput"));%></p>
						<hr>
						<p style="line-height: 25px;"><b>Sample Output</b> <br> <% out.println(doc1.get("SampleOutput"));%></p>
						<hr>
						
						<h4>Editor</h4>
						<select id="Language<%=qid[i] %>" name="Language<%=qid[i] %>" style="font-size:15px;width: 120px;height: 22px;padding-left: 5px;background: white;margin-bottom: 10px;"  onchange="setPlaceholder('<%=qid[i] %>')">
    					<option value="C++">C++</option>
    					<option value="Java">Java</option>
    					<option value="Python">Python</option>
    					</select>
    					<textarea id="IDE<%=qid[i] %>" rows="30" cols="115" name="Solution<%=qid[i]%>" ></textarea><br/>
    					Input:
    					<textarea id="Input<%=qid[i] %>" rows="5" cols="115"></textarea>				
    					<button name="compileandrun" class="button" style="width: 150px;float: left;" onclick="return take_values('<%=qid[i] %>')">Compile & Run</button>
    					<button name="Submit" class="button" style="width: 150px ;float: right;" onclick="return submit_values('<%=qid[i] %>')" >Submit Problem</button>
    					<br/><br/>
    					<textarea id="idsub<%=qid[i] %>" rows="5" cols="163" disabled="disabled" >Output will Be Shown Here</textarea>
    				
    					<textarea id="SubmissionResult<%=qid[i] %>" rows="5" cols="163" disabled="disabled" >Submission Result will Be Shown Here</textarea>
    				
    				<!-- <button name="Submit" class="button" style="float: right;" onclick="submit_values()" >Submit</button>
    				 -->
    				 
    				 </div>
    				<br/><br/>   			    			
   			   	<%}%>
   		</div>
   		 </form>
   	</div>
   	<div style="position:fixed;bottom:0px;overflow: hidden;background:white;border-radius:0px;margin-left:-8px;margin-top:-8px;width: 101.05%;color: black;height: 40px;box-shadow: 0px 0px 16px 0px rgba(0,0,0,0.2);">
    		<span style="float: right;padding-right: 25px;font-size: 20px; padding-top: 8px;">&copy;OOPS! BUG</span>

</body>
</html>