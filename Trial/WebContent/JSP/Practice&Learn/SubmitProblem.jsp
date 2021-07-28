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
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Submit Problem</title>
<link rel = "icon" href = "../../Images/IconSite.png">
<link href="../Styles1.css" rel="stylesheet/css">
<style type="text/css">
	.button:hover {
	background: #ddd;
}
</style>
<%
		HttpSession log2=request.getSession(false);  
		String username2 = (String)log2.getAttribute("Username");
		String id=request.getParameter("id");
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Problems");
		BasicDBObject query = new BasicDBObject();
		query.put("_id", new ObjectId(id));
		
		DBObject doc = collection.findOne(query);
		
		
%>	
<script type="text/javascript">

function take_values(){
	 var n=document.getElementById("IDE").value;
	 
	 if (n==null || n=="") {
	 alert("Write Some Code Before You Compile.");
	 return false;
	 }else{
		 document.getElementById("idsub").innerHTML="Please Wait While Your Code is Run.";
		 var input=document.getElementById("Input").value;
		 var language=encodeURIComponent(document.getElementById("Language").value);
		 var source=encodeURIComponent(n);
	 var http = new XMLHttpRequest();
	 http.open("POST", "http://localhost:8080/Trial/JSP/Compete/CallCompiler.jsp", true);
	 http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	 var params = "source=" + source +"&input="+input+"&language="+language; // probably use document.getElementById(...).value
	 http.send(params);
	 http.onload = function() {
	 document.getElementById("idsub").innerHTML= http.responseText;
	 }
	 } 
	 } 
	 
function submit_values(){
	 var n=document.getElementById("IDE").value;
	 
	 if (n==null || n=="") {
	 alert("Write Some Code Before You Compile.");
	 return false;
	 }else{
		 document.getElementById("SubmissionResult").innerHTML="Please Wait While Your Code is Run.";
	 var language=encodeURIComponent(document.getElementById("Language").value);
	 var questionid=document.getElementById("QuestionId").value;
	 var username=document.getElementById("Username").value;
	 var source=encodeURIComponent(n);
	 var http = new XMLHttpRequest();
	 http.open("POST", "http://localhost:8080/Trial/JSP/Practice&Learn/SubmitProblemData.jsp", true);
	 http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	 var params = "source=" + source +"&QuestionId="+questionid+"&language="+language+"&username="+username; // probably use document.getElementById(...).value
	 http.send(params);
	 http.onload = function() {
	 document.getElementById("SubmissionResult").innerHTML= "SubmissionResult: \n\n"+http.responseText;
	 }
	 } 
	 } 

var placeholder="#include <iostream>\nusing namespace std;\nint main()\n{\nchar sample[] = \"OOPS-BUG\";\ncout << sample << \" - A computer science portal for geeks\";\nreturn 0;\n}";
function setPlaceholder() {
	var lang= document.getElementById("Language").value;
	if(lang == "Java")
		placeholder="import java.util.*;\nclass MyClass\n{\npublic static void main(String[] args) \n{\nSystem.out.println(\"OOPS-BUG\");\n}\n} ";	
	if(lang == "C++")
		placeholder="#include <iostream>\nusing namespace std;\nint main()\n{\nchar sample[] = \"OOPS-BUG\";\ncout << sample << \" - A coding platform.\";\nreturn 0;\n}";	
	if(lang == "Python")
		placeholder="print(\"OOPS-BUG\");\n";	
		
	document.getElementById("IDE").value=placeholder;
}

function checkforlogin() {
	var un="<%=username2%>";
	if(un == "null")
		{
			alert('Please Login to Submit Problem.');
			location="../../Login.jsp";
	   	}
}
</script>
</head>
<body onload="setPlaceholder();changeHeader();checkforlogin();">
		
		<div>
         	<jsp:include page="../header.jsp"></jsp:include>
    	</div>
	    	
    	<div style="width: 80% ; border:#ddd inset 1px;margin: 1% auto;padding: 2%;padding-top:0.8%;overflow: hidden;">
    			<p><span style="text-align: left;font-size:xx-large;margin-top: 15px;margin-bottom: 15px; "><%= doc.get("Name")%>     </span><span>Code: <a href="Problem.jsp?id=<%=doc.get("_id")%>"><%= doc.get("_id")%></a></span></p>
    			<!-- <form action="SubmitProblemData.jsp" method="post"> -->
    				<select id="Language" name="Language" style="font-size:15px;width: 120px;height: 22px;padding-left: 5px;background: white;margin-bottom: 10px;"  onchange="setPlaceholder()">
    					<option value="C++">C++</option>
    					<option value="Java">Java</option>
    					<option value="Python">Python</option>
    				</select>
    				<textarea id="IDE" rows="30" cols="163" name="Solution" ></textarea>
    				Input:
    				<textarea id="Input" rows="5" cols="163"></textarea>
    				<input type="text" style="display: none;" name="QuestionId" id="QuestionId" value = "<%=doc.get("_id")%>" />
    				<input type="text" style="display: none;" name="Username" id="Username"  value = "<%=username2%>" /> 				
    				<div>
    				<button name="compileandrun" class="button" style="width: 150px;float: left;" onclick="take_values()">Compile & Run</button>
    				<button name="Submit" class="button" style="float: right;" onclick="submit_values()" >Submit</button>
    				</div>
    				<br/><br/>
    				<textarea id="idsub" rows="5" cols="163" disabled="disabled" >Output will Be Shown Here</textarea>
    				
    				<textarea id="SubmissionResult" rows="5" cols="163" disabled="disabled" >Submission Result will Be Shown Here</textarea>
    					
    			<!-- </form> -->
    	</div>
    	<div>
         	<jsp:include page="../footer.jsp"></jsp:include>
    	</div>

</body>
</html>