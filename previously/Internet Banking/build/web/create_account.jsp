<%-- 
    Document   : create_account
    Created on : Jan 31, 2012, 12:08:49 AM
    Author     : Rahul
--%>

<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
    </head>
    <body>
        <h1>Create Account..</h1>
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
            ResultSet rs=null;
            ResultSetMetaData rsmd=null;
            String appno= "";
            try
            {
                String first_name = request.getParameter("first_name");
                String last_name = request.getParameter("last_name");

                String day=request.getParameter("dob");
                String month=request.getParameter("month");
                String year=request.getParameter("year");
                String dob = day+"/"+month+"/"+year;
                String address = request.getParameter("address");
                String email = request.getParameter("email");
                String phone = (request.getParameter("phone"));
                String pan_no = request.getParameter("pan_no");
                String username=request.getParameter("username");
                String photo = request.getParameter("photo");
                String email_verified = request.getParameter("email_verified");
                String type_of_user = request.getParameter("type_of_user");

     String query="select application_no from application_form where "
             + "username='"+username+"'";
   
         Database db= new Database();
         System.out.println(query);
         rs=db.runCode(query);
         System.out.println(rs);
         if(rs.next())
            appno=rs.getString("application_no");
         System.out.println(appno);
         %>

         <div class="detailBox">

             <span class="detailLine" >  first_name = <%= first_name %> <br/> </span>
             <span class="detailLine" >  last_name = <%= last_name %> <br/> </span>
             <span class="detailLine" >  dob = <%= dob %> <br/> </span>
             <span class="detailLine" >  address = <%= address %> <br/> </span>
             <span class="detailLine" >  email = <%= email %> <br/> </span>
             <span class="detailLine" >  phone = <%= phone %> <br/> </span>
             <span class="detailLine" >  pan_no = <%= pan_no %> <br/> </span>
             <span class="detailLine" >  username = <%= username %> <br/> </span>

             <span class="pic" >  <img src="<%= photo %>" alt="image" /> <br/> </span>
             <span class="detailLine" >  email_verified = <%= email_verified %> <br/> </span>
             <span class="detailLine" >  type_of_user = <%= type_of_user %> <br/> </span>
             <form action="/Controller" method="get">
                 <input type="hidden" name="appno" value="<%= appno %>" />
                 <label for="balance">Initial Balance Deposited</label>
                 <input type="text" name="balance" />
                 <input type="submit" name="create_account" value="CREATE ACCOUNT" />
             </form>

         </div>

         <%
         }
            
        
     catch(Exception e)
     {e.printStackTrace(System.out);}
}
         }

        %>
        </div>
    </body>
</html>
