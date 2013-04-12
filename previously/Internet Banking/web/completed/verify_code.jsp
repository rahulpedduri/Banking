<%-- 
    Document   : verify_code
    Created on : Nov 26, 2011, 3:31:19 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>verify code</title>
    </head>
    <body>
       <form method="post" action="verify_process.jsp" >
                <label for="verify" >application no </label>
                <input type="text" name="verify" /><br/>
                <p>note down this number</p>
       </form>
    </body>
</html>
