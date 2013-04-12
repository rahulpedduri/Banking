
<%-- 
    Document   : create_account
    Created on : Nov 27, 2011, 1:54:45 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>create account</title>
    </head>
    <body>
        <form method="post" action="create.jsp">
            <label for="app_num">application number</label>
            <input type="text" name="app_num" >

           <a href="application.jsp" id="apply">APPLY NOW</a>
            <input type="submit" value="submit" >
        </form>
    </body>
</html>
