<%-- 
    Document   : transaction_history
    Created on : Jan 28, 2012, 11:09:18 PM
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
        <title>transaction history</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>Transaction History..</h1>
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
        if(session.getAttribute("type_of_user")!=null)
            {
            try {
            boolean admin=session.getAttribute("type_of_user").equals("admin");
            boolean client=session.getAttribute("type_of_user").equals("client");
            if(admin || client)
                {
        %>

        <form action="/Controller" method="GET">

            <% if(admin){ %>
            <label for="username">Username</label>
            <input type="text" name="username" />

            <%}else if(client){  String username=(String) session.getAttribute("username"); %>
            <input type="hidden" name="username" value="<%= username %>" />

            <%} %>
            <br/>
            <input type="checkbox" name="withdraws" />
            <label for="withdraws">Withdraws</label>
            <br />

            <input type="checkbox" name="deposits" />
            <label for="deposits" >Deposits</label>
            <br />

            <input type="checkbox" name="money_transfer" />
            <label for="money_transfer">A/C transfers</label>
            <br />

            <p>From Date:<br />
            <label for="from_day" >Day</label>
            <select name="from_day" >
                <option>1
                <option>2
                <option>3
                <option>4
                <option>5
                <option>6
                <option>7
                <option>8
                <option>9
                <option>10
                <option>11
                <option>12
                <option>13
                <option>14
                <option>15
                <option>16
                <option>17
                <option>18
                <option>19
                <option>20
                <option>21
                <option>22
                <option>23
                <option>24
                <option>25
                <option>26
                <option>27
                <option>28
            </select>

            <label for="from_month" >Month</label>
            <select name="from_month" >
                <option>January
                <option>February
                <option>March
                <option>April
                <option>May
                <option>June
                <option>July
                <option>August
                <option>September
                <option>October
                <option>November
                <option>December
            </select>
         
            <label for="from_year" >Year</label>
            <select name="from_year" >
                <option>2009
                <option>2010
                <option>2011
                <option>2012
                <option>2013
                <option>2014
                <option>2015
                <option>2016
                <option>2017
                <option>2018
                <option>2019
                <option>2020
                <option>2021
                <option>2022
            </select>

            <br />

            <p>To Date:<br />
            <label for="to_day" >Day</label>
            <select name="to_day" >
                <option>1
                <option>2
                <option>3
                <option>4
                <option>5
                <option>6
                <option>7
                <option>8
                <option>9
                <option>10
                <option>11
                <option>12
                <option>13
                <option>14
                <option>15
                <option>16
                <option>17
                <option>18
                <option>19
                <option>20
                <option>21
                <option>22
                <option>23
                <option>24
                <option>25
                <option>26
                <option>27
                <option>28
            </select>

            <label for="to_month" >Month</label>
            <select name="to_month" >
                <option>January
                <option>February
                <option>March
                <option>April
                <option>May
                <option>June
                <option>July
                <option>August
                <option>September
                <option>October
                <option>November
                <option>December
            </select>

            <label for="to_year" >Year</label>
            <select name="to_year" >
                <option>2009
                <option>2010
                <option>2011
                <option>2012
                <option>2013
                <option>2014
                <option>2015
                <option>2016
                <option>2017
                <option>2018
                <option>2019
                <option>2020
                <option>2021
                <option>2022
            </select>

            <input type="submit" name="transactions" value="Get Transactions" />

        </form>

        <hr />


<table class="transactions">
    <tr>
    <th>Transaction</th>
    <th>Amount</th>
    <th>Balance Before Transaction</th>
    <th>Balance After Transaction</th>
    <th>Date & Time</th>
    <th>Target Account No.</th>
    <th>Name</th>
    <th>Comment</th>
    <th>Paid By</th>
    <th>Auto Debit</th>
    </tr>

    <%
    System.out.println("before get transactions..");
    ResultSet rs=TransactionManager.getTransactions(request);
    System.out.println(rs);
    while(rs.next())
        {
        System.out.println(rs.getString("trans_type")+""+ rs.getString("amount")+""+ rs.getString("balance_before")
        +""+rs.getString("balance_after")+""+ rs.getString("time_of_trans")+""+ rs.getString("target_ac_no")
        +""+ rs.getString("full_name")+""+
        rs.getString("any_comment")+""+ rs.getString("paid_by") +""+ rs.getString("auto_debit"));
    %>
    <tr>
        <td><%= rs.getString("trans_type") %></td>
        <td><%= rs.getString("amount") %></td>
        <td><%= rs.getString("balance_before") %></td>
        <td><%= rs.getString("balance_after") %></td>
        <td><%= rs.getString("time_of_trans") %></td>
        <td><%= rs.getString("target_ac_no") %></td>
        <td><%= rs.getString("full_name") %></td>
        <td><%= rs.getString("any_comment") %></td>
        <td><%= rs.getString("paid_by") %></td>
        <td><%= rs.getString("auto_debit") %></td>


    </tr>
    <% } %>

</table>
         </div>

        <%
        }
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
            catch(Exception e){System.out.println("Exception in trans hist"); e.printStackTrace(System.out);}
        }

        %>

<br/>
<br/>
    </body>
</html>
