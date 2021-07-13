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
<title>Code,Compile & Run</title>
<link rel="stylesheet" href="../Style.css">
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
var placeholder="/******************************************************************************\nCode, Compile, Run and Debug java program online.\nWrite your code in this editor.\n*******************************************************************************\npublic class Main\n{\npublic static void main(String[] args) \n{\nSystem.out.println(\"Hello World\");\n}\n} ";
function setPlaceholder() {
	var lang= document.getElementById("Language").value;
	if(lang == "Java")
		placeholder="/******************************************************************************\nWrite your code in this editor.\n*******************************************************************************\npublic class Main\n{\npublic static void main(String[] args) \n{\nSystem.out.println(\"Hello World\");\n}\n} ";	
	if(lang == "C")
		placeholder="/******************************************************************************\nWrite your code in this editor.\n*******************************************************************************\nvoid Main\n{\nprintf(\"Hello World\");\n} ";	
	if(lang == "Python")
		placeholder="/******************************************************************************\nWrite your code in this editor.\n*******************************************************************************\nprintln(\"Hello World\");\n";	
		
	document.getElementById("IDE").value=placeholder;
}

</script>
</head>
<body onload="setPlaceholder();changeHeader();">
		
		<div>
         	<jsp:include page="header.jsp"></jsp:include>
    	</div>
	    	
    	<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding-top: 0.8%;padding-bottom:0.8%; padding-left:2%;padding-right:1%; overflow: hidden;">
    			<p style="text-align: left;font-size:xx-large;margin-top: 15px;margin-bottom: 15px; ">Code, Compile & Run</p>
    			<form action="SubmitProblemData.jsp" method="post">
    				Select Language: <select style="font-size:15px;width: 120px;height: 22px;padding-left: 5px;background: white;margin-bottom: 10px;" id="Language" name="Language" onchange="setPlaceholder()">
    					<option value="C">C</option>
    					<option value="Java">Java</option>
    					<option value="Python">Python</option>
    				</select>
    				<textarea id="IDE" rows="30" cols="163" name="Solution"></textarea>   				
    				<div style="text-align: center;"><button type="submit" class="button">Submit</button></div>
    			</form>
    	</div>
    	
    	<div>
         	<jsp:include page="footer.jsp"></jsp:include>
    	</div>

</body>
</html>