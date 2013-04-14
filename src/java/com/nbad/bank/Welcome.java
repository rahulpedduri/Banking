/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbad.bank;

import com.nbad.bean.TransactionRequest;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Phani Rahul
 */
public class Welcome extends HttpServlet {

    private String WELCOME = "welcome.jsp";

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /*This has to be read from a Json request from the airlines server, however for the time being..*/
            //String clientId = request.getParameter("client_id");
            String merchantName = request.getParameter("merchant_name");
            String username = request.getParameter("username");
            String bill = request.getParameter("bill");
            String billDesc = request.getParameter("bill_description");
            String callback = request.getParameter("callback");
            String session_req = request.getParameter("session");
//            out.print("hello world");

            if (bill != null && !bill.trim().equals("")
                    && username != null && !username.trim().equals("")
                    && callback != null && !callback.trim().equals("")
                    && session_req != null && !session_req.trim().equals("")) {
                HttpSession session = request.getSession();
                
                TransactionRequest req = new TransactionRequest();
                req.setBill(Double.valueOf(bill));
                req.setUsername(username);
                req.setCallback(callback);  
                req.setSession(session_req);
                
                if (merchantName != null && !merchantName.trim().equals("")) {
                    req.setMerchant_name(merchantName);                  
                }               
                if (billDesc != null && !billDesc.trim().equals("")) {
                    req.setBill_desc(billDesc);                
                }
                session.setAttribute("transaction_request", req);
                response.sendRedirect(WELCOME);
            }
        } catch(Exception e){
            System.out.println("Exception: "+e);
        }finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
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
     * Handles the HTTP
     * <code>POST</code> method.
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
