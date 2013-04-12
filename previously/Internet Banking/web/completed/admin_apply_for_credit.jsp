<%-- 
    Document   : admin_apply_for_credit
    Created on : Nov 27, 2011, 2:19:33 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>admin module apply for credit</title>
    </head>
    <body>
           <form action="admin_credit_apply.jsp" method="post">

               <label for="account_no">account number</label>
             <input type="text" name="account_no" />

            <label for="username">username</label>
             <input type="text" name="username" /><br/>



      <label for="income">sources of income</label>
             <input type="text" name="income" /><br/>

             <label for="profession">profession</label>
             <input type="text" name="profession" /><br/>


             <label for="annual_income">annual income</label>
             <input type="text" name="annual_income" /><br/>

             <p>note:these details are to be accompanied with proofs</p>

              <input type="submit" value="submit" name="submit">
        </form>
    </body>
</html>
