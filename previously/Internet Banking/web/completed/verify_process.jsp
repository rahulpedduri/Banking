<%-- 
    Document   : verify_process
    Created on : Nov 26, 2011, 3:36:44 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
                 <%
    String redirectURL ="application_process.jsp";
    response.sendRedirect(redirectURL);
        %>

    </body>
</html>
