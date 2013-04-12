<%--
    Document   : transaction_history
    Created on : Jan 28, 2012, 11:09:18 PM
    Author     : Rahul
--%>

<%@page import="application.Account"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="application.TransactionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>credit history</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>Credit History..</h1>
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

        %>

             </div>
        <%
        String username = "";
        if(session.getAttribute("type_of_user")!=null)
            {
            try{
            boolean admin=session.getAttribute("type_of_user").equals("admin");
            boolean client=session.getAttribute("type_of_user").equals("client");
            if(admin || client)
                {
        %>

       

        <% if (admin) {%>
        <form action="/Controller" method="GET">
            <label for="username">Username</label>
            <input type="text" name="username" />
            <input type="submit" name="credit_history" value="Get Credit History" />

        </form>
        <hr />

        <%} else if (client) {
              username = (String) session.getAttribute("username");%>


        <%}%>
 <%
    if(admin)
        {
        username=request.getParameter("username");
        boolean en=Account.isCreditEnabled(username);
        if(username!=null){
            if(!username.equals("")){
    %>
    <form action="/Controller" method="get">
        <input type="hidden" name="username" value="<%= username %>" />
        <%if(en){%>
        <input type="submit" name="disable_credit" value="disable credit for this user" />
        <%} else {%>
                     <label for="credit_lim">Credit Limit</label>
                    <input type="text" name="credit_lim" />
        <input type="submit" name="enable_credit" value="enable credit for this user" />
        <%} %>
    </form>
    <%
    }
        }
        }
        %>
           

        <hr />

<table class="transactions">
    <tr>
        <th>Date & Time</th>
        <th>Amount</th>
        <th>status</th>
    </tr>
   <%
        
    ResultSet rs=null;
    if(admin)rs=TransactionManager.getCreditDetails(request);
    if(client)rs=TransactionManager.getCreditDetails(username);
    System.out.println(rs);
    if(rs==null) System.out.println("rs in credit_history is null");
    else System.out.println("rs in credit_history is not null");

    System.out.println("before rs.next..");
    
    while(rs.next())
        {
        System.out.println("rs.next called:");
        System.out.println(rs.getString("time_of_trans")+" "+rs.getString("credit_amt")+" "+rs.getString("status"));

    %>
    <tr>
        <td><%= rs.getString("time_of_trans") %></td>
        <td><%= rs.getString("credit_amt") %></td>
        <td><%= rs.getString("status") %></td>
    </tr>
    <% } %>

</table>
        </div>

        <%
        System.out.println("after while.."+rs);
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
            catch(Exception e){System.out.println("Exception in credit history"); e.printStackTrace(System.out);}

        }
        %>


    </body>
</html>
