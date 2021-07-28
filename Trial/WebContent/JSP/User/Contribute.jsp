<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Contribute</title>
<link rel = "icon" href = "../../Images/IconSite.png">
<link rel="stylesheet" href="../../Styles1.css" >
<style type="text/css">
	textarea , input{
			font-family: Verdana ;
			background: #f9f9f9;
			line-height: 25px;
	}

</style>
</head>
<body onload="changeHeader();">


	<div>
         	<jsp:include page="../header.jsp"></jsp:include>
    	</div>
	    	
    	<div style="width: 80% ; border:#ddd inset 1px;;margin: 1% auto;padding: 2%;padding-top:0.8%;overflow: hidden;">
    		<div style="width: 71%;float: left;margin: 3% auto;border:#ddd inset 1px;;padding: 15px">
    		<form action="ContributeData.jsp" method="post">
		<div>
			<label>
				Question Name
			</label><br/>
			<input type="text" name="Name"/>
		</div>
		<br/>
		<div>
			<label>
				Question
			</label>
			<textarea rows="20" cols="103" name="Question"></textarea>
		</div>
		<br/>
		<div>
			<label>
				Input
			</label><br/>
				<textarea rows="3" cols="103" name="Input"></textarea>		</div>
		<br/>
		<div>
			<label>
				Output
			</label><br/>
				<textarea rows="3" cols="103" name="Output"></textarea>		</div>
		<br/>
		<div>
			<label>
				Sample Input
			</label><br/>
				<textarea rows="3" cols="103" name="SampleInput"></textarea>		</div>
		<br/>
		<div>
			<label>
				Sample Output
			</label><br/>
				<textarea rows="3" cols="103" name="SampleOutput"></textarea>		</div>
		<br/>
		<div>
			<label>
				Time Limit
			</label><br/>
			<select name="TimeLimit" style="font-size:15px;width: 120px;height: 22px;padding-left: 5px;background: white;margin-bottom: 10px;" >
				<option value="0.5 secs">0.5 secs</option>
				<option value="1 secs">1 secs</option>
				<option value="1.5 secs">1.5 secs</option>
				<option value="2 secs">2 secs</option>
				<option value="2.5 secs">2.5 secs</option>
				<option value="3 secs">3 secs</option>
				<option value="3.5 secs">3.5 secs</option>
				<option value="4 secs">4 secs</option>
				<option value="4.5 secs">4.5 secs</option>
				<option value="5 secs">5 secs</option>
			</select>
		</div>
		<div>
			<label>
				Source Limit
			</label><br/>
			<select name="SourceLimit" style="font-size:15px;width: 120px;height: 22px;padding-left: 5px;background: white;margin-bottom: 10px;" >
				<option value="25000 bytes">25000 bytes</option>
				<option value="50000 bytes">50000 bytes</option>
				<option value="75000 bytes">75000 bytes</option>
				<option value="100000 bytes">100000 bytes</option>
				<option value="125000 bytes">125000 bytes</option>
				<option value="150000 bytes">150000 bytes</option>
			</select>
		</div>
		
		<br/>
		<div style="text-align: center;"><button type="submit" class="button">Submit</button></div>    						
    		</form>
    		</div>
    	
    	</div>
    	
    	<div>
         	<jsp:include page="../footer.jsp"></jsp:include>
    	</div>
	</form>
</body>
</html>