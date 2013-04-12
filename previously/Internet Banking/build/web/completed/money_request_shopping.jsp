<%-- 
    Document   : money_request_shopping
    Created on : Nov 26, 2011, 11:49:13 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>money request for shopping</title>
    </head>
    <body>
        <form method="post" action="down_payment_process.jsp">
          
            <p>reason:
                
                <i>bill details</i></p><br/> 
            
            
            <label for="amount">total amount</label>
            <input type="text" name="amount" ><br/>

             <label for="no_of_emis">number of EMI's</label>
            <input type="text" name="no_of_emis" ><br/>

             <label for="per_emi">per EMI</label>
            <input type="text" name="per_emi" ><br/>

             <label for="down_payment">down payment</label>
            <input type="text" name="down_payment" ><br/>

            <label for="date_time">date&time</label>
            <input type="text" name="date_time"><br/>

            <input type="submit" value="allow" name="allow">
            <input type ="submit" value="deny" name="deny">
            </form>
    </body>
</html>
