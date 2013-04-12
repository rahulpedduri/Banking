<%-- 
    Document   : edit_details
    Created on : Nov 26, 2011, 4:05:52 PM
    Author     : Rahul
--%>

<%@page import="application.TransactionManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>edit details</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>Edit Details</h1>
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
                 if (session.getAttribute("type_of_user") != null) {
                     boolean admin = session.getAttribute("type_of_user").equals("admin");
                     boolean client = session.getAttribute("type_of_user").equals("client");
                     if (admin || client) {
                         %>
          <form action="./Controller" method="POST">
            
              <input type="checkbox" name="name_check"/>
              <label for="first_name">first name</label>
            <input type="text" name="first_name"/>
            <label for="last_name">last name</label>
            <input type="text" name="last_name"/>
            <br/>

             <input type="checkbox" name="address_check"/>
             <label for="address">address</label>
            <input type="text" name="address" /><br/>
         
              <input type="checkbox" name="email_check"/>
             <label for="email">email id</label>
            <input type="text" name="email "  /><br/>

             <input type="checkbox" name="dob_check"/>
             <label for="dob">date of birth</label>
             <label for="day">day</label>
            <select name="day">
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

             <label for="month">month</label>
            <select name="month">
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

              <label for="year">year</label>
            <select name="year">
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
             <br/>

             <input type="checkbox" name="phone_no_check"/>
             <label for="phone_no">phone number</label>
            <input type="text" name="phone_no "  /><br/>

             

            <input type="submit" name="edit_details" value="change">

            <p class="notesa">note:any documents regarding the selected changes have to be submitted to the bank.
                       thanq you.have a nice day!!!</p>
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
