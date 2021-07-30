<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.io.BufferedReader"
import="java.io.InputStreamReader"
import="java.net.HttpURLConnection"
import="java.util.LinkedHashMap"
import="java.util.Map"
import="java.io.FileNotFoundException"
import="java.net.*"
import="java.net.URLEncoder"
import="java.nio.charset.StandardCharsets"%><%
String recieve;
String buffer="";
URL url = new URL("https://c7db22e6.compilers.sphere-engine.com/api/v4/submissions?access_token=459e246d3a78018df2eba923a8d36c24");


String sourceCode= URLEncoder.encode(request.getParameter("source"), StandardCharsets.UTF_8.toString());
String inputhere= request.getParameter("input");
String language= request.getParameter("language");
int compilerId=41;

if(language.equals("C++"))
	compilerId=41;

if(language.equals("Java"))
	compilerId=10;

if(language.equals("Python"))
	compilerId=116;

	
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

int index=0;
do{
Thread.sleep(2000); 
URL url1 = new URL("https://c7db22e6.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"?access_token=459e246d3a78018df2eba923a8d36c24");
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

index=output.indexOf("true");

}while(index>0);



String AccessToken="459e246d3a78018df2eba923a8d36c24";

try{
String urioutput= "https://c7db22e6.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"/output?access_token=459e246d3a78018df2eba923a8d36c24";

URL url2 = new URL(urioutput.toString());
HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
InputStreamReader in1 = new InputStreamReader(conn2.getInputStream());
BufferedReader br1 = new BufferedReader(in1);
String output1 = br1.readLine();
buffer="";
while ((buffer = br1.readLine()) != null)
		output1=output1+"\n"+buffer;
out.print(output1);
}

catch(FileNotFoundException e){
	try{
	String urioutput= "https://c7db22e6.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"/cmpinfo?access_token=459e246d3a78018df2eba923a8d36c24";    
    URL url3= new URL(urioutput.toString());
    HttpURLConnection conn3 = (HttpURLConnection) url3.openConnection();
    InputStreamReader in1 = new InputStreamReader(conn3.getInputStream());
    BufferedReader br1 = new BufferedReader(in1);
    String output1=br1.readLine();
    buffer="";
    while ((buffer = br1.readLine()) != null)
    	output1=output1+"\n"+buffer;
    out.print(output1);
	}
	catch(FileNotFoundException e1)
	{
		Thread.sleep(2000);
		String urioutput= "https://c7db22e6.compilers.sphere-engine.com/api/v4/submissions/"+submissionId+"/error?access_token=459e246d3a78018df2eba923a8d36c24";    
	    URL url3= new URL(urioutput.toString());
	    HttpURLConnection conn3 = (HttpURLConnection) url3.openConnection();
	    InputStreamReader in1 = new InputStreamReader(conn3.getInputStream());
	    BufferedReader br1 = new BufferedReader(in1);
	    String output1=br1.readLine();
	    buffer="";
	    while ((buffer = br1.readLine()) != null)
	    	output1=output1+"\n"+buffer;
	    out.print(output1);
	}
}
%>