<%-- 
    Document   : welcome
    Created on : Apr 10, 2013, 10:24:37 PM
    Author     : Phani Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome.. </title>
    </head>
    <body>
        <h1>Bill : ${sessionScope['transaction_request'].bill}</h1>

        <form name ="form" action="Transaction" method="POST">
            <div>
                <label for="account_holder_name">Account Holder Name</label>
                <input type="text" name="account_holder_name" class ="required"/>
            </div>

            <div> 
                <label for="routing_number">Routing Number</label>
                <input type="text" name="routing_number" class ="required"/>
            </div>

            <div>
                <label for="account_number">Account Number</label>
                <input type="text"  name="account_number" class ="required"/>
            </div>            

            <button type="submit" value="confirm" name="transaction_submit">confirm</button>
        </form>
        <script>
            window.
        </script>
    </body>
</html>
