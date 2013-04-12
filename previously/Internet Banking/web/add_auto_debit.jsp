<%-- 
    Document   : add_auto_debit
    Created on : Nov 27, 2011, 12:26:36 AM
    Author     : Rahul
--%>

<%@page import="application.TransactionManager"%>
<%--
......this page needs some changes!!......

--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Auto debit</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>Add autodebit</h1>
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
        try{
         String username="";
        if(session.getAttribute("type_of_user")!=null)
            {
            boolean admin=session.getAttribute("type_of_user").equals("admin");
            boolean client=session.getAttribute("type_of_user").equals("client");
            if(admin || client)
                {

         %>

         <form name="auto_debit" action="/Controller" method="get">

           <%
                if(client){
                     username=(String) session.getAttribute("username");
                %>
                
                <input type="hidden" name="username" value="<%= username %>"/>

             <%
                }
                if(admin)
                {

            %>

                <label for="username">Username</label>
                <input type="text" name="username" />

                <%}%>
         
            <label for="target">Target Username</label>
            <input type="text" name="target" /><br/>
            
             <label for="name">name of transaction</label>
            <input type="text" name="name" ><br/>
            
             <label for="comment">comment</label>
            <input type="text" name="comment" ><br/>

            <label for="down_payment">Downpayment</label>
            <input type="text" name="down_payment" ><br/>
            
             <label for="amt_per_ins">amount per installment</label>
            <input type="text" name="amt_per_ins" ><br/>
            
             <label for="pay_date">pay on what day of the month</label>
             <select name="pay_date">
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
             </select><br/>
            
  start date:<label for="day">day</label>  
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
            </select> <br/>
               
         <label for="installments">no of installments</label>
         <input type="text" name="installments" value=""/>

         <p class="note">note:if your balance is found to be low for the auto debit,it is
             intimated in advance and the auto debit is turned off.thanq you.
             have a nice day!!!</p>

         <input type="submit" value="ok,add the autodebit" name="add_auto_debit">
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
            }catch(Exception e)
                    {e.printStackTrace(System.out); System.out.println("Exception in add auto debit");}
                %>
                </body>
</html>
