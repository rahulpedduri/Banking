<%-- 
    Document   : password_mailed
    Created on : Nov 27, 2011, 2:11:17 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>password mailed</title>
    </head>
    <body>
         <form method="post" action="mailed.jsp">

             <label for="account_number">bank account number</label>
            <input type="text" name="account_number" ><br/>

             <label for="username">user name</label>
            <input type="text" name="username" ><br/>

            <p>password has been mailed to ur email address</p>
         </form>

    </body>
</html>
