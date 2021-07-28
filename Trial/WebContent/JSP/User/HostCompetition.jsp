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
<title>Host Competition</title>
<link rel = "icon" href = "../../Images/IconSite.png">
<link rel="stylesheet" href="../../Styles1.css">
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

<style>input{
	font-family: Verdana ;
	background: #f9f9f9;
	line-height: 25px;
}
</style>


<script type="text/javascript">

function  totalSelected()
{  

	var count=0;
	var markedCheckbox = document.getElementsByName('checkboxes');  

	for (var checkbox of markedCheckbox) 
	{  
		if (checkbox.checked)  
			count++;
	}
	document.getElementById("Count").innerHTML=count;  
	
	if(count==0)
		document.getElementById('submit').disabled=true;
	else
		document.getElementById('submit').disabled=false;
	
	var time=document.getElementById("timeforcompetition").value;
	
	if(count != 0 && time != null)
		document.getElementById("Time").innerHTML=(time/count) + "minutes";
	
}  


function checkStartEnd() {
	var dateStart=new Date(document.getElementById("start").value)
	var dateEnd=new Date(document.getElementById("end").value)
	var today=new Date();
	
	
	if(dateEnd.getTime() < dateStart.getTime()){
		alert("End Date-time Must be Smaller than Start Date Time");    
	}
	if((dateStart.getTime() - today.getTime()) < 604800000){
		alert("Schedule Competition Atleast 1 week afterwards");    
	}	
}
</script>
<body onload="checkforlogin();changeHeader();">



<%

		
		MongoClient mongo = new MongoClient( "localhost" , 27017 );
		DB db= mongo.getDB("OnlineCodingPlatform");
		DBCollection collection = db.getCollection("Problems");

		DBObject doc = new BasicDBObject();
		BasicDBObject query=new BasicDBObject("Verification","Verified");
		
		DBCursor cursor = collection.find(query);
		%>

<div>
         	<jsp:include page="../header.jsp"></jsp:include>
    	</div>
	    	
    	<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding: 2%;padding-top:0.8%;overflow: hidden;">
    		<div style="width: 71%;float: left;margin: 3% auto;border:#ddd inset 1px;;padding: 15px">

	<form action="HostCompetitionData.jsp" method="post">
			<div>
				<label>
					Name Of Competition
				</label>
				<br/>
				<input type="text" name="CompetitionName" required="required" />
			</div>
			
			<div>
				<label>
					Date and Time of Start
				</label>
				<br/>
				<input type="datetime-local" id="start" required="required" onchange="checkStartEnd();" name="dateTimeStart">
			</div>
			<div>
				<label>
					Date and Time of End
				</label>
				<br/>
				<input onchange="checkStartEnd();" id="end" required="required" type="datetime-local" name="dateTimeEnd">
			</div>
			<div>
				<label>
					Time For The Competition in Minutes:
				</label>
				<br/>
				<input id="timeforcompetition" onkeyup="totalSelected();" required="required" type="number" name="TimeForCompetition">
			</div>
			<div>
				<p>	Number Of Questions Selected: <span id="Count">0</span></p>
			</div>
			<div>
				<p>	Time Per Question: <span id="Time">Select Questions and Time for Competition</span></p>
			</div>
			Select Questions
		<div style="overflow: auto;height: 280px;">
			<table style="border:#ddd inset 1px;margin-top: auto;">
			<tr>
						<th>Select</th>
    					<th>Name</th>
    					<th>Code</th>
    					<th>Successful Submissions</th>
    					<th>Accuracy</th>
    				</tr>
			<%
						while(cursor.hasNext())
						{
							doc=cursor.next();
							double totalsubmissions=Double.parseDouble(doc.get("TotalSubmissions").toString());
							double successfulsubmissions=Double.parseDouble(doc.get("SuccessfulSubmissions").toString());
							int accuracy=0;
							if(totalsubmissions !=0)
								accuracy=(int)((successfulsubmissions/totalsubmissions)*100);
					%>
					<tr style="border-bottom: thin;">
						<td><input type="checkbox" name="checkboxes" onclick="totalSelected();" value="<%=doc.get("_id")%>" id="<%=doc.get("_id")%>"></td>
						<td><a target="_blank" href="../Practice&Learn/Problem.jsp?id=<%=doc.get("_id")%>"><%=doc.get("Name")%></a></td>
						<td><a target="_blank" href="../Practice&Learn/Problem.jsp?id=<%=doc.get("_id")%>"><%=doc.get("_id")%></a></td>
						<td><%=(int)successfulsubmissions%></td>
						<td><%=accuracy%>%</td>
					</tr>
					
					<%}%>
			</table>
		</div>
			<div style="text-align: center;"><button id="submit" disabled="disabled" type="submit" class="button">Submit</button></div>    	
		</form>
		</div>
		</div>

</body>
</html>