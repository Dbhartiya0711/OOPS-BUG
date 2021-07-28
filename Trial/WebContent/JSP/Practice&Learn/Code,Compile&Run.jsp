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
    import= "org.bson.types.ObjectId"
    import="java.io.BufferedReader"
	import="java.io.InputStreamReader"
	import="java.net.HttpURLConnection"
	import="java.util.LinkedHashMap"
	import="java.util.Map"
	import="java.io.FileNotFoundException"
	import="java.net.*;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Code,Compile & Run</title>
<link rel = "icon" href = "../../Images/IconSite.png">
<link href="../../Styles1.css" rel="stylesheet/css">
<style type="text/css">
	.button:hover {
	background: #ddd;
}
</style>
<%
		HttpSession log2=request.getSession(false);  
		String username2 = (String)log2.getAttribute("Username");
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


</script>
</head>
<body onload="setPlaceholder();changeHeader();">
		
		<div>
         	<jsp:include page="../header.jsp"></jsp:include>
    	</div>
	    	
    	<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding-top: 0.8%;padding-bottom:0.8%; padding-left:2%;padding-right:1%; overflow: hidden;">
    			<p style="text-align: left;font-size:xx-large;margin-top: 15px;margin-bottom: 15px; ">Code, Compile & Run</p>
    			
    				Select Language: <select style="font-size:15px;width: 120px;height: 22px;padding-left: 5px;background: white;margin-bottom: 10px;" id="Language" name="Language" onchange="setPlaceholder()">
    					<option value="C++">C++</option>
    					<option value="Java">Java</option>
    					<option value="Python">Python</option>
    				</select>
    				<textarea id="IDE" rows="30" cols="163" name="Solution" ></textarea>
    				Input:
    				<textarea id="Input" rows="5" cols="163"></textarea>   				
    				<div style="text-align: center;"><button name="compileandrun" style="width: 150px; " class="button" onclick="return take_values()">Compile & Run</button></div>
    				<br/>
    				<div>
    		<textarea id="idsub" rows="5" cols="163" disabled="disabled">Output will Be Shown Here</textarea>
    	</div>
    	</div>
    	
    	<br/><br/>
    	<div>
         	<jsp:include page="../footer.jsp"></jsp:include>
    	</div>

</body>
</html>