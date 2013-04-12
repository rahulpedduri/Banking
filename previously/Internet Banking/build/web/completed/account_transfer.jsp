<%-- 
    Document   : account_transfer
    Created on : Nov 27, 2011, 1:44:12 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>account transfer</title>
        <style type="text/css">
            .one{
                background:purple;

}

        </style>
    </head>
    <body class="one">
         <form method="post" action="transfer_account.jsp">

            from:<label for="account_number">account number</label>
            <input type="text" name="account_number" >

               <label for="username">user name</label>
            <input type="text" name="username" ><br/>


            to:<label for="account_number">account number</label>
            <input type="text" name="account_number" >

               <label for="username">user name</label>
            <input type="text" name="username" ><br/>
            
              <input type="submit" name="send" value="send">
            <input type="submit" name="cancel" value="cancel">

         </form>
    </body>
</html>
