<%-- 
    Document   : forgot
    Created on : Nov 26, 2011, 12:24:53 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>forgot password</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>Forgot Password</h1>
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
         <form method="post" action="./Controller" >
                <label for="username" >username</label>
                <input type="text" name="username" />
                <label for="security_question" >security question</label>
                <select name="security_question">
                    <option>what is ur birth place?
                    <option>what is ur nick name?
                    <option>what is ur first phone number?
                </select>
                <label for="security_answer">answer</label>
              <input type="text" name="security_answer" />
              <input type ="submit" value="submit"name="forgot_password">

            </form>
            <a href="index.jsp" id="forgot">back to login page</a>
            <br/>
        </div>
    </body>
</html>
