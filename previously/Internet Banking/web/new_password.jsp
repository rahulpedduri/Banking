<%-- 
    Document   : new_password
    Created on : Feb 15, 2012, 7:16:53 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New password</title>
    </head>
    <body>
        <h1>New Password</h1>
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

         <form method="post" action="./Controller">

             <input type="hidden" name="username" value="<%= request.getParameter("username") %>" />

            <label for="password">new password</label>
            <input type="password" name="password" >
            <br/>
             <label for="new_password">retype password</label>
            <input type="password" name="new_password" >
            <br/>

            <input type="submit" name="reset_password" value="change">
        </form>
         </div>

    </body>
</html>
