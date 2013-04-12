package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import application.TransactionManager;
import application.Account;

public final class verification_005fcode_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.Vector _jspx_dependants;

  private org.apache.jasper.runtime.ResourceInjector _jspx_resourceInjector;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.apache.jasper.runtime.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"\n");
      out.write("   \"http://www.w3.org/TR/html4/loose.dtd\">\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>verification code</title>\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/style.css\" type=\"text/css\" />\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div class=\"holder\">\n");
      out.write("\n");
      out.write("             <div id=\"info\">\n");
      out.write("                  ");

            String error=request.getParameter("err");
            if(error!=null){
            if(error.equalsIgnoreCase("user"))
                {
                
      out.write("\n");
      out.write("                <div class=\"error user_err\">Incorrect Details!</div>\n");
      out.write("                ");

                }
            else if(error.equalsIgnoreCase("prog"))
                {
                
      out.write("\n");
      out.write("                <div class=\"error prog_err\">Oops something went wrong! Try Again</div>\n");
      out.write("                ");

                }
            else if(error.equalsIgnoreCase("any"))
                {
                
      out.write("\n");
      out.write("                <div class=\"error any_err\">either the details provided are wrong or something went wrong!\n");
      out.write("                    Try again if the details you provided are correct</div>\n");
      out.write("                ");

                }
            }
            String success=request.getParameter("success");
            if(success!=null){
                if(success.equalsIgnoreCase("true")){
                
      out.write("\n");
      out.write("               <div class=\"result success\">successful</div>\n");
      out.write("                ");

                   }
                else {
                
      out.write("\n");
      out.write("                <div class=\"result failed\">failed</div>\n");
      out.write("                ");

                }
            }

        
      out.write("\n");
      out.write("\n");
      out.write("             </div>\n");
      out.write("        ");

           String email= (String) session.getAttribute("veri_email");
           String reason= (String) session.getAttribute("veri_reason");
           String next= (String) session.getAttribute("veri_next");

           Account.addVerificationCode(email, reason);
            if (session.getAttribute("type_of_user") != null) {
                     boolean admin = session.getAttribute("type_of_user").equals("admin");
                     boolean client = session.getAttribute("type_of_user").equals("client");
                     if (admin || client) {
        
      out.write("\n");
      out.write("       \n");
      out.write("         <form method=\"post\" action=\"./Controller\" >\n");
      out.write("             <input type=\"hidden\" name=\"email\" value=\"");
      out.print( email );
      out.write("\" />\n");
      out.write("             <input type=\"hidden\" name=\"reason\" value=\"");
      out.print( reason );
      out.write("\" />\n");
      out.write("             <input type=\"hidden\" name=\"next\" value=\"");
      out.print( next );
      out.write("\"\n");
      out.write("\n");
      out.write("                <label for=\"code\" >verify code from mail</label>\n");
      out.write("                <input type=\"text\" name=\"code\" />\n");
      out.write("\n");
      out.write("                <input type=\"submit\" name=\"verify\" value=\"verify\">\n");
      out.write("                <a href=\"verification_code.jsp\">mail not returned</a>\n");
      out.write("         </form>\n");
      out.write("    </div>\n");
      out.write("    ");

     if(client)
                {
        
      out.write("\n");
      out.write("        <div id=\"navigator\">\n");
      out.write("            <a href=\"transfer.jsp\" class=\"block\">a/c transfer</a>\n");
      out.write("            <a href=\"transaction_history.jsp\" class=\"block\">transaction history</a>\n");
      out.write("            <a href=\"credit_history.jsp\" class=\"block\">Credit History</a>\n");
      out.write("           <div class=\"block\">\n");
      out.write("                <a href=\"add_auto_debit.jsp\" class=\"interleaved\">Add Auto Debit</a>\n");
      out.write("                <a href=\"auto_debit.jsp\" class=\"interleaved\"> View Auto Debits</a>\n");
      out.write("            </div>\n");
      out.write("           ");

           if(TransactionManager.checkIfAppliedForCredit((String) session.getAttribute("username")))
               {
            
      out.write("\n");
      out.write("            <a href=\"apply_for_credit.jsp\" class=\"block\">Apply for Credit</a>\n");
      out.write("            ");
 } 
      out.write("\n");
      out.write("            <div class=\"block\">\n");
      out.write("            <a href=\"change_password.jsp\" class=\"interleaved\">change password</a>\n");
      out.write("            <a href=\"change_security_question.jsp\" class=\"interleaved\">change security question</a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        ");

                }
            else if (admin)
                {
        
      out.write("\n");
      out.write("\n");
      out.write("        <div id=\"navigator\">\n");
      out.write("            <a href=\"transfer.jsp\" class=\"block\">a/c transfer</a>\n");
      out.write("            <div class=\"block\">\n");
      out.write("                <a href=\"add_auto_debit.jsp\" class=\"interleaved\">Add Auto Debit</a>\n");
      out.write("                <a href=\"auto_debit.jsp\" class=\"interleaved\"> View Auto Debits</a>\n");
      out.write("            </div>\n");
      out.write("            <a href=\"withdraw.jsp\" class=\"block\">Withdraw</a>\n");
      out.write("            <a href=\"deposit.jsp\" class=\"block\">Deposit</a>\n");
      out.write("            <a href=\"requests.jsp\" class=\"block\">Client Requests</a>\n");
      out.write("            <a href=\"application_form.jsp\" class=\"block\">Application Form</a>\n");
      out.write("            <a href=\"apply_for_credit.jsp\" class=\"block\">Apply For Credit</a>\n");
      out.write("            <a href=\"transaction_history.jsp\" class=\"block\">Transactions</a>\n");
      out.write("            <a href=\"credit_history.jsp\" class=\"block\">Credit History</a>\n");
      out.write("            <div class=\"block\">\n");
      out.write("                <a href=\"change_password.jsp\" class=\"interleaved\">change password</a>\n");
      out.write("                <a href=\"change_security_question.jsp\" class=\"interleaved\">change security question</a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        ");

                }
     }
}

    
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
