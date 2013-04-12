<%-- 
    Document   : requests
    Created on : Jan 31, 2012, 10:22:18 AM
    Author     : Rahul
--%>

<%--
some kind of error!!!
--%>
<%@page import="application.Detail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="application.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Requests from Clients</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>Requests from Clients</h1>
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
            boolean admin=session.getAttribute("type_of_user").equals("admin");
            if(admin)
                {
                try{
        %>

        <form action="/Controller" method="get">
            <label for="username">Username</label>
            <input type="text" name="username" />
            <input type="submit" name="get_requests" value="Get Requests"/>
        </form>
        <hr />

        <%
        String username=request.getParameter("username");
        System.out.println("before getDetailChangeRequests");
        ResultSet rs=Account.getDetailChangeRequests(username);
        System.out.println("after getDetailChangeRequests");

        %>

        <table>
            <caption>Details Change Requests</caption>
            <tr>
                <th></th>
                <th>Username</th>
                <th>Change</th>
            </tr>
            <%
             while(rs.next())
            {
                 String detail_user=rs.getString("username");
                 String detail=rs.getString("details");
                 String previous=Detail.getDetail(detail, detail_user);
                 System.out.println(detail+""+previous);
            %>
            <tr>           
                <td>
                  <form action="/Controller" method="get">
                    <select name="response">
                        <option>Allow
                        <option>Deny
                    </select>
               
                    <input type="hidden" name="detail_user" value="<%= detail_user %>" />
                    <input type="hidden" name="detail" value="<%= detail %>" />
                    <input type="submit" name="detail_change" value="submit" />
                  </form>
                </td>
                <td><%= detail_user %></td>
                <td>
                    <%= detail %>: '<%= previous %>' to '<%= rs.getString("value") %>'
                </td>
            
            </tr>
            <%
            System.out.println(rs.getString("username")+""+detail);
            }
            %>
        </table>
<%
              ResultSet rs2=Account.getCreditEnableRequests(username);
%>

      <br />

        <table>
            <caption>Credit Enable Requests</caption>
            <tr>
                <th></th>
                <th>Username</th>
                <th>Sources of Income</th>
                <th>Profession</th>
                <th>Annual Income</th>
                <th>surety</th>
            </tr>

            <%
            while(rs2.next())
                {
                System.out.println();
                String detail_user=rs2.getString("username");
            %>
            <tr>

                <td>
                <form action="/Controller" method="get">

                    <select name="response">
                        <option>Allow
                        <option>Deny
                    </select>
                    <label for="credit_lim">Credit Limit</label>
                    <input type="text" name="credit_lim" />
                    <input type="hidden" name="detail_user" value="<%= detail_user %>" />
                    <input type="submit" name="enable_credit" value="submit" />
                 </form>
                </td>
            <td><%= detail_user %></td>
            <td> <%= rs2.getString("sources_of_income") %> </td>
            <td> <%= rs2.getString("profession") %> </td>
            <td> <%= rs2.getString("annual_income") %> </td>
            <td> <%= rs2.getString("surety") %> </td>
            </tr>
            <%
            System.out.println(rs2.getString("sources_of_income")+""+
            rs2.getString("profession")+""+
            rs2.getString("annual_income")+""+
            rs2.getString("surety"));
            }
            %>
        </table>
        </div>

        <%
            }catch(Exception e){
                System.out.println("exception in requests.jsp");
                e.printStackTrace(System.out);
            }

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
                }
                }
             }
        %>
    </body>
</html>
