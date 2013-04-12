<%-- 
    Document   : applied
    Created on : Jan 14, 2012, 11:22:50 PM
    Author     : Rahul
--%>

<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%! ResultSet rs=null; String appno=""; %>

<%
    
     String email = request.getParameter("email");
     String query="select application_no from application_form where "
            +"email='"+email+"'";
            
     try
        {
         Database db= new Database();
         rs=db.runCode(query);
         if(rs.next())
         appno=rs.getString("application_no");

        }
     catch(Exception e)
     {e.printStackTrace(System.out);}

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>form submitted</title>
                <link rel="stylesheet" href="css/style.css" type="text/css" />

    </head>
    <body>
        <h1>you're awesome!</h1><br/>
        <div class="holder">

             <div id="info">
                  <%
            String error=request.getParameter("err");
            if(error!=null){
            if(error.equalsIgnoreCase("user"))
                {
                %>
                <div class="error user_err">Incorrect Details!</div>
                <%
                }
            else if(error.equalsIgnoreCase("prog"))
                {
                %>
                <div class="error prog_err">Oops something went wrong! Try Again</div>
                <%
                }
            else if(error.equalsIgnoreCase("any"))
                {
                %>
                <div class="error any_err">either the details provided are wrong or something went wrong!
                    Try again if the details you provided are correct</div>
                <%
                }
            }
            String success=request.getParameter("success");
            if(success!=null){
                if(success.equalsIgnoreCase("true")){
                %>
               <div class="result success">successful</div>
                <%
                   }
                else {
                %>
                <div class="result failed">failed</div>
                <%
                }
            }

        %>

             </div>

        <h2>the application form has been successfully submitted.<br/>
            the application number is<h1><%= appno %></h1><br/>
            <p>please visit the nearest branch and submit the relevant documents along with this application no. to activate the account.</p>
        </h2>
            <a href="index.jsp" >go back to main page</a>
        </div>
    </body>
</html>
