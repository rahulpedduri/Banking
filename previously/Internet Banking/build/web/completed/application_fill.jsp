<%-- 
    Document   : application_fill
    Created on : Nov 27, 2011, 2:03:58 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>application fill</title>
    </head>
    <body>
        <form name="apply" action="application_create.jsp" method="POST">
            <label for="first_name">first name</label>
            <input type="text" name="first_name " /><br/>

             <label for="last_name">last name</label>
            <input type="text" name="last_name "  /><br/>


            <label for="date_of_birth">date of birth</label>
            <input type="text" name="date_of_birth"><br/>

             <label for="PAN_NO">pan no</label>
             <input type="text" name="PAN_NO" /><br/>

             <label for="address">address</label>
             <input type="text" name="address" ><br/>

             <label for="username">username</label>
             <input type="text" name="username" /><br/>

             <label for="email_id">email id</label>
             <input type="text" name="email_id" /><br/>


             <label for="phone_number">phone number</label>
             <input type="text" name="phone_number" /><br/>

             <label for="photo">photo</label>
             <input type="text" name="photo" /><br/>
             <p>note:create the account only if the proofs are valid and authenticated.</p>

             <input type="submit" value="create" name="create">
             <input type="submit" value="cancel" name="cancel">
        </form>
    </body>
</html>
