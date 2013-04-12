/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import application.Account;
import application.CookieHandle;
import application.Detail;
import application.Login;
import application.TransactionManager;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import database.Database;
import java.sql.ResultSet;

/**
 *
 * @author Rahul
 */
public class Controller extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

   String next="", url="";
    HttpSession session=null;
    ResultSet rs=null;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            next="";url="";
            boolean flag=false;
            session=request.getSession();
            String email="";
            boolean client=false,admin=false;
            if (session.getAttribute("type_of_user") != null) {
                admin = session.getAttribute("type_of_user").equals("admin");
                client = session.getAttribute("type_of_user").equals("client");
                }
 /*------------------------------------------login(index.jsp)----------------------------------------------------------------------*/
             if(request.getParameter("login")!=null)
            {
                 System.out.println("login");
               flag=application.Login.verify(request.getParameter("username"), request.getParameter("password"));
               if(flag)
               {
                  CookieHandle.personalize(request, response);
                url="home.jsp";
                }
               else
                   url="index.jsp?err=user";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*-----------------------------------------change_password(change_password.jsp)----------------------------------------------------*/
            else if (request.getParameter("change_password") != null)
            {
                System.out.println("change_password");
                if(application.Account.pre_password_change(request))
                {
                    CookieHandle.temporaryStoreForVerification(request);
                    if(application.Account.password_change(request))
                        next="home.jsp?success=true";
                    else
                        next="change_password.jsp?err=user";
                   // next = "verification_code.jsp";
                }
                else url="change_password.jsp?err=any";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*-----------------------------------------change_security_question(change_security_question.jsp)----------------------------------*/
            else if (request.getParameter("change_security_question") != null)
            {
                System.out.println("change_security_question");
                if(application.Account.pre_security_question_change(request))
                {
                    CookieHandle.temporaryStoreForVerification(request);
                    if(application.Account.security_question_change(request))
                        next="home.jsp?success=true";
                    else next="change_security_question.jsp?err";
                    //next = "verification_code.jsp";
                }
                else url="change_security_question.jsp?err=any";
                System.out.println(next);
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*--------------------------------------------verify(verification_code.jsp)---------------------------------------------------------*/
            else if (request.getParameter("verify") != null)
            {
                System.out.println("verify");
                String code=request.getParameter("code");
                String reason=request.getParameter("reason");
                email=request.getParameter("email");

                String query="select * from verification_code where email='"+email+"' and code='"+code+"' and reason='"+reason+"'";
                System.out.println(query);
                Database db= new Database();
                rs=db.runCode(query);
                if(rs.next())
                {
                    if(reason.equalsIgnoreCase("email_verification"))
                    {
                       if( Account.emailVerified(request))
                           next=request.getParameter("next");
                       else
                           next="verification_code.jsp?err=user";
                    }
                    if(reason.equalsIgnoreCase("change_security_question"))
                    {application.Account.security_question_change(request);}
                    if(reason.equalsIgnoreCase("change_password"))
                    {application.Account.password_change(request);}
                    next=request.getParameter("next");
                }
                else
                next="verification_code.jsp?err=user";
             }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*------------------------------------------edit_details(edit_details.jsp)---------------------------------------------------------*/
            else if (request.getParameter("edit_details") != null)
            {
                System.out.println("edit_details");
                if(Detail.editDetails(request))
                    next="home.jsp?success=true";
                else
                    next="edit_details.jsp?err=prog";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*------------------------------------forgot_password(forgot.jsp)------------------------------------------------------------------*/
            else if (request.getParameter("forgot_password") != null)
            {
                System.out.println("forgot_password");
                String username=request.getParameter("username");
                String security_question=request.getParameter("security_question");
                String security_answer=request.getParameter("security_answer");
                if(Login.verifySecurityQuestion(username, security_question, security_answer))
                {
                 // if(Account.resetPassword(username))
                        next="new_password.jsp";
                } else url="forgot.jsp?err=user";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------reset_password(forgot.jsp)------------------------------------------------------------------*/
            else if (request.getParameter("reset_password") != null)
            {
                System.out.println("reset_password");
               
                if(Account.saveNewPassword(request))
                    next="index.jsp?success=true";
                else
                    next="new_password.jsp?err=prog";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------transfer(transfer.jsp)----------------------------------------------------------------------*/
             else if (request.getParameter("transfer") != null)
            {
                 System.out.println("transfer");
                if(TransactionManager.transfer(request))
                    next="transfer.jsp?success=true";
                else
                    next="transfer.jsp?err=any";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------add_auto_debit(add_auto_debit.jsp)--------------------------------------------------------*/
            else if (request.getParameter("add_auto_debit") != null)
            {
                System.out.println("add_auto_debit");
                if(TransactionManager.addAutoDebit(request)) 
                    next="auto_debit.jsp?success=true";
                else next="add_auto_debit.jsp?err=any";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*------------------------------------------withdraw(withdraw.jsp)-----------------------------------------------------------------*/
            else if (request.getParameter("withdraw") != null)
            {
                System.out.println("withdraw");
                System.out.println("in controller");
                if(TransactionManager.withdraw(request))
                    next="withdraw.jsp?success=true";
                else
                    next="withdraw.jsp?err=any";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------deposit(deposit.jsp)------------------------------------------------------------------*/
            else if (request.getParameter("deposit") != null)
            {
                System.out.println("deposit");
                System.out.println("in controller");
                if(TransactionManager.deposit(request))
                    next="deposit.jsp?success=true";
                else
                    next="deposit.jsp?err=any";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------------create_account(create_account.jsp,application_form.jsp)-----------------------------*/
             else if (request.getParameter("create_account") != null)
            {
                 System.out.println("create_account");
                if(TransactionManager.createAccount(request))
                    url="application_form.jsp?success=true";
                else next="application_form.jsp?err=any";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*----------------------------------------------application_form(application_form.jsp)---------------------------------------------*/
            else if (request.getParameter("application_form") != null)
            {
                System.out.println("application_form");
                String first_name = request.getParameter("first_name");
                String last_name = request.getParameter("last_name");
                String day=request.getParameter("day");
                String month=request.getParameter("month");
                String year=request.getParameter("year");
                String dob = day+"-"+month+"-"+year;
                String address = request.getParameter("address");
                email = request.getParameter("email");
                String phone = (request.getParameter("phone"));
                String pan_no = request.getParameter("pan_no");
                String username = request.getParameter("username");
                String password ="";
                String security_ques = "";
                String security_ans ="";
                if(!admin)
                {
                if(request.getParameter("password").equals(request.getParameter("confirm_password")))
                    password=request.getParameter("password");
                 security_ans=request.getParameter("security_answer");
                 security_ques=request.getParameter("security_question");
                 }
                String photo = request.getParameter("photo");
                if(photo==null || photo.equals(""))
                    photo="photos/image.jpg";
                String email_verified = "no";
                String type_of_user = "client";
                flag = application.Account.apply(
                        0,
                        first_name,
                        last_name,
                        dob,
                        address,
                        email,
                        phone,
                        pan_no,
                        username,
                        password,
                        security_ques,
                        security_ans,
                        photo, email_verified,
                        type_of_user);
                System.out.println(flag);
                if(admin)
                    flag=Account.resetPassword(username) && flag;
                System.out.println(flag+" controller-flags "+(true && true));

                if(flag && !admin){
                    CookieHandle.temporaryStoreForVerification(request);
                    if( Account.emailVerified(request))
                           next="index.jsp?success=true";
                       else
                           url="application_form.jsp?err=any";
                    //next="verification_code.jsp";
                    System.out.println(url);
                }
                else if(flag && admin)
                {
                    next="create_account.jsp";
                    System.out.println(next);
                }
                else {
                   next = "application_form.jsp?err=any";
                   System.out.println(next);
                }
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*----------------------------------------apply_for_credit(apply_for_credit.jsp)---------------------------------------------------*/
             else if (request.getParameter("apply_for_credit") != null)
            {
                 System.out.println("apply_for_credit");
                if(TransactionManager.applyForCredit(request))
                    next="home.jsp?success=true";
                else url="apply_for_credit.jsp?err=any";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*-----------------------------------------transactions(transaction_history.jsp)---------------------------------------------------*/
            else if(request.getParameter("transactions") != null)
            {
                System.out.println("transactions");
                System.out.println("in controller..");
                next="transaction_history.jsp";
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

/*--------------------------------------------auto_debit(auto_debit.jsp)-------------------------------------------------------*/
            else if(request.getParameter("auto_debit") != null)
            {
                System.out.println("auto_debit");
                next="auto_debit.jsp";
            }

/*---------------------------------------------------------------------------------------------------------------------------------*/

/*--------------------------------------------pay_auto_debit(auto_debit.jsp)-------------------------------------------------------*/
            else if(request.getParameter("pay_auto_debit") != null)
            {
                System.out.println("pay_auto_debit");
                String id=request.getParameter("id");
                if(TransactionManager.payAutoDebit(id))
                    next="auto_debit.jsp?success=true";
                else
                    next="auto_debit.jsp?err=user";
            }

/*---------------------------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------edit_auto_debit(autodebit_edit.jsp)---------------------------------------------------*/
            else if(request.getParameter("edit_auto_debit") != null)
            {
                System.out.println("edit_auto_debit");
                if(TransactionManager.edit_auto_debit(request))
                    url="auto_debit.jsp?success=true";
                else
                    next="autodebit_edit.jsp?err=any";
            }

/*---------------------------------------------------------------------------------------------------------------------------------*/

/*------------------------------------------get_requests(requests.jsp)-------------------------------------------------------------*/
             else if(request.getParameter("get_requests") != null)
            {
                 System.out.println("get_requests");
                next="requests.jsp";
            }

/*---------------------------------------------------------------------------------------------------------------------------------*/

/*-----------------------------------------detail_change(requests.jsp)-------------------------------------------------------------*/
            else if(request.getParameter("detail_change") != null)
            {
                System.out.println("detail_change");
                if(Detail.commitChange(request))
                    next="requests.jsp?success=true";
                else
                    next="requests.jsp?err=prog";
            }

/*----------------------------------------------------------------------------------------------------------------------------------*/

/*------------------------------------------credit_enable(requests.jsp)-------------------------------------------------------------*/
            else if(request.getParameter("enable_credit") != null)
            {
                System.out.println("enable_credit");
                if(TransactionManager.enableCredit(request)){
                    next="requests.jsp?success=true";
                    System.out.println(next);
                }
                else
                    next="requests.jsp?err=prog";
            }

/*---------------------------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------credit_history(credit_history.jsp)----------------------------------------------------*/
             else if(request.getParameter("credit_history") != null)
            {
                 System.out.println("credit_history");
                next="credit_history.jsp";
            }

/*---------------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------------disable_credit(credit_history.jsp)--------------------------------------------------*/
            else if(request.getParameter("disable_credit") != null)
            {
                System.out.println("disable_credit");
                if(TransactionManager.disableCredit(request))
                    next="credit_history.jsp?success=true";
                else
                    next="credit_history.jsp?err=prog";
            }

/*----------------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------------enable_credit(credit_history.jsp)--------------------------------------------------*/
            else if(request.getParameter("enable_credit") != null)
            {
                System.out.println("enable_credit");
                if(TransactionManager.enableCredit(request))
                    url="credit_history.jsp?success=true";
                else
                    next="credit_history.jsp?err=prog";
            }

/*----------------------------------------------------------------------------------------------------------------------------------*/

/*-------------------------if the url is changed, explicitly------------------------------------------------------------------------*/
             else {
                System.out.println("controller else part..");
                url="index.jsp?err=prog";
             }


/*------------------if url is set,it is redirected, else the request is dispatched to next-----------------------------------------*/
           if(!url.equals(""))
                response.sendRedirect(url);
            else{
            RequestDispatcher dispatcher = request.getRequestDispatcher(next);
            dispatcher.forward(request, response);
            }
/*---------------------------------------------------------------------------------------------------------------------------------*/

        }
        catch (Exception e) {
            System.out.println("Exception in Controller" + e);
            e.printStackTrace(System.out);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
