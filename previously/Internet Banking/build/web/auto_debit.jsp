<%-- 
    Document   : auto_debit
    Created on : Jan 29, 2012, 1:23:41 PM
    Author     : Rahul
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="application.TransactionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>auto debits</title>
                <link rel="stylesheet" href="css/style.css" type="text/css" />

    </head>
    <body>
        <h1>Auto Debits..</h1>
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
      
         String username="";
        if(session.getAttribute("type_of_user")!=null)
            {

            boolean admin=session.getAttribute("type_of_user").equals("admin");
            boolean client=session.getAttribute("type_of_user").equals("client");
            if(admin || client)
                {
                if(client)
                     username=(String) session.getAttribute("username");

                if(admin)
                {
                    username=request.getParameter("username");

            %>

            <form action="/Controller" method="GET" >
                <label for="username">Username</label>
                <input type="text" name="username" />
                <input type="submit" name="auto_debit" value="Get AutoDebits" />
                
            </form>
                <hr />
            <%
                }
        %>
        <table class="transactions">
            <tr>
            <caption>Auto Debits</caption>
            <th></th>
                <th>Name</th>
                <th>feature</th>
                <th>EMI</th>
                <th>To </th>
                <th>Start Date</th>
                <th>Installments</th>
                <th>Amount Paid till now</th>
                <th>Amount left to Pay</th>
                <th>Downpayment</th>
                <th>by credit</th>
                <th>Comments</th>
                <th>EDIT</th>
                <th>Days to pay date</th>
            </tr>
            
                <%
                try{
                if(username!=null && !username.equals(""))
                {
                    ResultSet rs=TransactionManager.getAutoDebits(username);
               int i=0;
                System.out.println("in auto debit.jsp");
                    while(rs.next())
                        {
                        System.out.println("next: "+rs.getString("feature")+" "+rs.getObject("feature").equals("on"));
                  %>

            <tr>
                    <td>
            <%

                    Calendar currentDate = Calendar.getInstance();
                    int paydt=Integer.parseInt(rs.getString("pay_date"));
                    System.out.println(paydt+" --"+currentDate.DAY_OF_MONTH+10);

                    if(paydt==currentDate.DAY_OF_MONTH+10)
                        {
                        System.out.println("Yes, today is paydate");
                    %>
                    <form action="/Controller" method="get">
                            <input type="hidden" name="id" value="<%= rs.getString("autodebit_id") %>" />
                            <input type="submit" name="pay_auto_debit" value="Pay" />
                        </form>
                        <%  } %>

                    </td>
                   
                    <td><%= rs.getString("name") %></td>
                     <td><%= rs.getString("feature") %></td>
                    <td><%= rs.getString("amt_per_installment") %></td>
                    <td><%= rs.getString("to_username") %></td>
                    <td><%= rs.getString("start_date") %></td>
                    <td><%= rs.getString("no_of_installments") %></td>
                    <td><%= rs.getString("amount_paid") %></td>
                    <td><%= rs.getString("amount_to_be_paid") %></td>
                    <td><%= rs.getString("downpayment") %></td>
                    <td><%= rs.getString("by_credit") %></td>
                    <td><%= rs.getString("any_comment") %></td>
                    <td>
                        <a href="autodebit_edit.jsp?id=<%= rs.getString("autodebit_id") %>"> Edit </a>
                    </td>
                    <%
                       int days= paydt-(currentDate.DAY_OF_MONTH+10);
                       System.out.println(days);
                       if(days<0){
                           days=Math.abs(days);
                    %>
                    <td><%= days %> crossed</td>
                    <%
                       }else {
                    %>
                    <td><%= days %> left</td>
                    <%
                    }
                    %>

                </tr>

                <%
                }
                %>
        </table>
        <br />
        

       
          <%

            }}

         catch(Exception e){System.out.println("Exception in auto debit"); e.printStackTrace(System.out);}
        %>
        </div>
        
        <% if(client)
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
