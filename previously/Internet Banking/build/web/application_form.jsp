<%-- 
    Document   : application
    Created on : Nov 26, 2011, 12:45:46 PM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>application form</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>Application Form..</h1>
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
         boolean admin=false;
         try{
             
        if(session.getAttribute("type_of_user")!=null)
            admin=session.getAttribute("type_of_user").equals("admin");
            if(admin)
                {
       %>

       <form name="aplication" action="/Controller" method="get">
           <label for="appno">Application No.</label>
           <input type="text" name="appno" />

           <label for="balance">Initial Balance Deposited</label>
           <input type="text" name="balance" />

           <input type="submit" name="create_account" value="CREATE ACCOUNT" />
       </form>

       <hr />

       <%
                }
       %>

        <form name="apply" action="./Controller" method="POST">
            <input type="hidden" name="reason" value="email_verification" />
            <input type="hidden" name="next" value="applied.jsp" />

            <label for="first_name">first name</label>
            <input type="text" name="first_name" /><br/>

             <label for="last_name">last name</label>
            <input type="text" name="last_name"  />
            <label for="last_name">(with proof)</label><br/>
            
            <label for="">date of birth</label>
            <label for="day">day</label>
            <select name="day">
                <option>1
                <option>2
                <option>3
                 <option>4
                <option> 5
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
            </select> <br/>             <label for="">(with proof)</label><br/>
             
             <label for="PAN_NO">pan no</label>
             <input type="text" name="pan_no" />
             <label for="PAN_NO">(with proof)</label><br/>

             <label for="address">address</label>
             <input type="text" name="address"  />
             <label for="address">(with proof)</label><br/>

             <label for="username">username</label>
             <input type="text" name="username" /><br/>

             <label for="email">email id</label>
             <input type="text" name="email" /><br/>

             <label for="phone">phone number</label>
             <input type="text" name="phone" /><br/>

             <label for="photo">photo</label>
             <input type="file" name="photo" /><br/>
             <%
             if(!admin)
                 {
             %>
             <label for="password">Password</label>
             <input type="password" name="password" /><br/>

             <label for="confirm_password">Confirm Password</label>
             <input type="password" name="confirm_password" /><br/>
             <%
             }
                %>

             <label for="security_question">security question</label>
                  <select name="security_question">
                    <option>what is your birth place?
                    <option>what is your nick name?
                    <option>what is your first phone number?
                </select>
             <label for="answer">answer</label>
             <input type="text" name="answer" /><br/>

            <%
                }
        catch(Exception e){}
             %>

             <input type="submit" value="submit" name="application_form">
        </form>

        </div>

        <%

            if (admin)
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
                }%>
    </body>
</html>
