<%-- 
    Document   : admin_login
    Created on : Nov 27, 2011, 1:34:48 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>admin login</title>
    </head>
    <body
        <h1>welcome</h1>
         <div id="login">
            <form method="post" action="login_successful_process.jsp" >
                <label for="username" >username</label>
                <input type="text" name="username" />
                <label for="password" >password</label>
                <input type="password" name="password" />
                <input type="submit" value="login" name="submit" />
            </form>
            <a href="forgot.jsp" id="forgot">forgot password?</a>
            <br/>
            <a href="application.jsp" id="apply">APPLY NOW</a>

        </div>
        <div id="info"></div>

    </body>
</html>
