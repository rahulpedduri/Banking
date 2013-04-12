<%-- 
    Document   : change_password
    Created on : Nov 26, 2011, 11:19:33 PM
    Author     : Rahul
--%>

<%@page import="application.TransactionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>change password</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
       
    </head>
    <body>
        <%
            String email = (String) session.getAttribute("EMAIL");
        %>
        <h1>change password...</h1>
         <div class="holder">

             <div id="info">
                  <%
            String error=request.getParameter("err");
            if(error!=null){
            if(error.equalsIgnoreCase("user"))
                {
                %>
                <div class="error user_err">Incorrect Details!</div>
                <%
                }
            else if(error.equalsIgnoreCase("prog"))
                {
                %>
                <div class="error prog_err">Oops something went wrong! Try Again</div>
                <%
                }
            else if(error.equalsIgnoreCase("any"))
                {
                %>
                <div class="error any_err">either the details provided are wrong or something went wrong!
                    Try again if the details you provided are correct</div>
                <%
                }
            }
            String success=request.getParameter("success");
            if(success!=null){
                if(success.equalsIgnoreCase("true")){
                %>
               <div class="result success">successful</div>
                <%
                   }
                else {
                %>
                <div class="result failed">failed</div>
                <%
                }
            }
            if (session.getAttribute("type_of_user") != null) {
                     boolean admin = session.getAttribute("type_of_user").equals("admin");
                     boolean client = session.getAttribute("type_of_user").equals("client");
                     if (admin || client) {
        %>

             </div>
        <form method="post" action="./Controller">

            <input type="hidden" name="email" value="<%= email %>" />
            <input type="hidden" name="reason" value="change_password" />
            <input type="hidden" name="next" value="home.jsp"/>

            <label for="password">current password</label>
            <input type="password" name="password" >
            <br/>

             <label for="new_password">new password</label>
            <input type="password" name="new_password" >
            <br/>

             <label for="confirm_password">retype password</label>
            <input type="password" name="confirm_password" >
            <br/>

            <input type="submit" name="change_password" value="change">
        </form>
         </div>
            <%
            if(client)
                {
        %>
        <div id="navigator">
            <a href="transfer.jsp" class="block">a/c transfer</a>
            <a href="transaction_history.jsp" class="block">transaction history</a>
            <a href="credit_history.jsp" class="block">Credit History</a>
           <div class="block">
                <a href="add_auto_debit.jsp" class="interleaved">Add Auto Debit</a>
                <a href="auto_debit.jsp" class="interleaved"> View Auto Debits</a>
            </div>
           <%
           if(TransactionManager.checkIfAppliedForCredit((String) session.getAttribute("username")))
               {
            %>
            <a href="apply_for_credit.jsp" class="block">Apply for Credit</a>
            <% } %>
            <div class="block">
            <a href="change_password.jsp" class="interleaved">change password</a>
            <a href="change_security_question.jsp" class="interleaved">change security question</a>
            </div>
        </div>

        <%
                }
            else if (admin)
                {
        %>

        <div id="navigator">
            <a href="transfer.jsp" class="block">a/c transfer</a>
            <div class="block">
                <a href="add_auto_debit.jsp" class="interleaved">Add Auto Debit</a>
                <a href="auto_debit.jsp" class="interleaved"> View Auto Debits</a>
            </div>
            <a href="withdraw.jsp" class="block">Withdraw</a>
            <a href="deposit.jsp" class="block">Deposit</a>
            <a href="requests.jsp" class="block">Client Requests</a>
            <a href="application_form.jsp" class="block">Application Form</a>
            <a href="apply_for_credit.jsp" class="block">Apply For Credit</a>
            <a href="transaction_history.jsp" class="block">Transactions</a>
            <a href="credit_history.jsp" class="block">Credit History</a>
            <div class="block">
                <a href="change_password.jsp" class="interleaved">change password</a>
                <a href="change_security_question.jsp" class="interleaved">change security question</a>
            </div>
        </div>

        <%
                }

            }
                     }
            %>
    </body>
</html>
