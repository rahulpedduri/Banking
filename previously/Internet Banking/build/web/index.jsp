<%-- 
    Document   : index
    Created on : Nov 11, 2011, 11:35:30 PM
    Author     : Rahul
--%>

<%@page import="application.CookieHandle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>welcome page</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>welcome to our banking services</h1>
        <%
            String username=CookieHandle.checkForCookie(request);
            if(username!=null){
                if(!username.equals("")){
                        
                      }
                }

        %>
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
        <div id="login">
            <form method="post" action="/Controller" >
                <label for="username" >username</label>
                <input type="text" name="username" />
                <label for="password" >password</label>
                <input type="password" name="password" />
                <input type="submit" value="login" name="login" />
            </form>
            <a href="forgot.jsp" id="forgot">forgot password?</a>
            <br/>
            <a href="application_form.jsp" id="apply">APPLY NOW</a>

        </div>
       
        </div>
    </body>
</html>
