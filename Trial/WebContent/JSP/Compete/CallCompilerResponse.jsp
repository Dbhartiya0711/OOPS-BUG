<%@page import="java.io.FileNotFoundException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.io.BufferedReader"
import="java.io.InputStreamReader"
import="java.net.HttpURLConnection"
import="java.util.LinkedHashMap"
import="java.util.Map"
import="java.net.*;"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	Thread.sleep(5000); 
	String submissionId= request.getParameter("id");
    URL url1 = new URL("https://78cd5828.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"?access_token=a522dbaf2025d7555f205a53314fba6a");
    HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();
    conn1.setRequestMethod("GET");
    /* conn1.setRequestProperty("Accept", "application/json");
    if (conn1.getResponseCode() != 200) {
        out.println("Failed : HTTP Error code : "+ conn1.getResponseCode());
    } */
    InputStreamReader in = new InputStreamReader(conn1.getInputStream());
    BufferedReader br = new BufferedReader(in);
    String output;
    output = br.readLine();
    //out.println(output);
     
    String AccessToken="a522dbaf2025d7555f205a53314fba6a";
    
    try{
    String urioutput= "https://78cd5828.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"/output?access_token=a522dbaf2025d7555f205a53314fba6a";
  
    URL url = new URL(urioutput.toString());
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    InputStreamReader in1 = new InputStreamReader(conn.getInputStream());
    BufferedReader br1 = new BufferedReader(in1);
    String output1;
    output1 = br1.readLine();
    out.println(output1+"\n\n");
    }
    
    catch(FileNotFoundException e){
    	try{
    	String urioutput= "https://78cd5828.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"/cmpinfo?access_token=a522dbaf2025d7555f205a53314fba6a";    
        URL url = new URL(urioutput.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        InputStreamReader in1 = new InputStreamReader(conn.getInputStream());
        BufferedReader br1 = new BufferedReader(in1);
        String output1;
        output1 = br1.readLine();
        out.println(output1+"\n\n");}
    	catch(FileNotFoundException e1)
    	{
    		Thread.sleep(1000);
    	}
    }
%>
</body>
</html>