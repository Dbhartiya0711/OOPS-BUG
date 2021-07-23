<%@page import="java.net.URLConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
import= "java.io.BufferedReader"
import=" java.io.IOException"
import=" java.io.InputStreamReader"
import=" java.io.OutputStream"
import=" java.net.HttpURLConnection"
import=" java.net.MalformedURLException"
import=" java.net.URL"
%>

<%
		//public class Devesh{ public static void main(String args[])throws IOException{ int a=10;System.out.println(a);}}
        String clientId = "ea0c27d9b114895afa355460fa1ec46b"; //Replace with your client ID
        String clientSecret = "2119377e5487b31a62bb82b8b29d2bb45ba05bb2a967e4768249212c3586b194"; //Replace with your client Secret
        String script = "";
        String language = "php";
        String versionIndex = "0";

        try {
            URL url = new URL("https://api.jdoodle.com/v1/execute");
            HttpURLConnection connection = (HttpURLConnection)url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/json");

            String input = "{\"clientId\": \"" + clientId + "\",\"clientSecret\":\"" + clientSecret + "\",\"script\":\"" + script +
            "\",\"language\":\"" + language + "\",\"versionIndex\":\"" + versionIndex + "\"} ";

            System.out.println(input);

            connection.connect();
            
            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(input.getBytes());
            outputStream.flush();

            if (connection.getResponseCode() != HttpURLConnection.HTTP_OK) {
                throw new RuntimeException("Please check your inputs : HTTP error code : "+ connection.getResponseCode());
            }

            BufferedReader bufferedReader;
            bufferedReader = new BufferedReader(new InputStreamReader(
            (connection.getInputStream())));

            String output;
            System.out.println("Output from JDoodle .... \n");
            while ((output = bufferedReader.readLine()) != null) {
                System.out.println(output);
            }

            connection.disconnect();

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
 %>