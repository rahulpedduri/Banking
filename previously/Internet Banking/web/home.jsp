<%-- 
    Document   : home
    Created on : Jan 14, 2012, 1:07:16 AM
    Author     : Rahul
--%>

<%@page import="application.TransactionManager"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="application.Account,application.CookieHandle"%>


<%! ResultSet rs=null;String user="";HttpSession session=null;%>

<%
session=request.getSession();
  if((!CookieHandle.check(request) && session.getAttribute("username").equals(""))
          || !CookieHandle.getCurrentUser(request).equals(session.getAttribute("username")) )
      
  {
    String redirectURL = "index.jsp";
    response.sendRedirect(redirectURL);
    }
  user=CookieHandle.getCurrentUser(request);
  
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>home</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>welcome <%=user %>,</h1>
        <div class="root">
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
        <h2><p> A/C details,</p></h2><br/>
       
        <p>name : <%=session.getAttribute("FIRST_NAME")%> <%= session.getAttribute("LAST_NAME")%> </p>
        <p> address: <%=session.getAttribute("ADDRESS")%> </p>
        <p> phone: <%=session.getAttribute("PHONE")%> </p>
        <p> email: <%=session.getAttribute("EMAIL")%> </p>
        <p> date of birth:<%=session.getAttribute("DOB")%> </p>
        <div id="pic">
            <img alt="picture"  src="<%= session.getAttribute("PHOTO") %>" />
        </div>
        <div class="edit">
            <a href="edit_details.jsp">edit</a>
        </div>
        
       

        <%
        if(session.getAttribute("type_of_user")!=null)
            {
            boolean admin= session.getAttribute("type_of_user").equals("admin");
            boolean client=session.getAttribute("type_of_user").equals("client");
            if(client)
                {
        %>
        <br/>
        <p> a/c no: <%=session.getAttribute("BANK_ACC") %> </p>
        <p> balance: <%=session.getAttribute("BALANCE") %> </p>
</div>
        <div id="navigator">
            <a href="transfer.jsp" class="block">a/c transfer</a>
            <a href="transaction_history.jsp" class="block">transaction history</a>
            <a href="credit_history.jsp" class="block">Credit History</a>
           <div class="block">
                <a href="add_auto_debit.jsp" class="interleaved">Add Auto Debit</a>
                <a href="auto_debit.jsp" class="interleaved"> View Auto Debits</a>
            </div>
           <%
           if(!TransactionManager.checkIfAppliedForCredit((String) session.getAttribute("username")))
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
        </div></div>
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
        %>

    </body>
</html>
