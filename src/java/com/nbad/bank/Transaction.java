/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbad.bank;

import com.nbad.bean.TransactionBean;
import com.nbad.bean.TransactionRequest;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Phani Rahul
 */
public class Transaction extends HttpServlet {

    private boolean SUCCESS = true;
    private boolean FAIL = false;
    public boolean transactionStatus = FAIL;

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
            //String clientId = request.getParameter("client_id");
            String account_holder_name = request.getParameter("account_holder_name");
            String account_number = request.getParameter("account_number");
            String routing_number = request.getParameter("routing_number");

            out.print("hello world");

            if (account_holder_name != null && !account_holder_name.trim().equals("")
                    && account_number != null && !account_number.trim().equals("")
                    && routing_number != null && !routing_number.trim().equals("")) {

                TransactionBean t = new TransactionBean(account_number, getServletContext());
                if (t.validateAccountDetails(account_number, account_holder_name, routing_number)) {
                    HttpSession session = request.getSession();
                    TransactionRequest inst = (TransactionRequest) session.getAttribute("transaction_request");
                    double bill = inst.getBill();
                    if (t.getBalance() >= bill) {
                        t.setBalance(t.getBalance() - bill);
                        transactionStatus = SUCCESS;
                        inst.setTransaction_status(transactionStatus);
                        String callback = inst.getCallback();
                        URL url = new URL(callback);
                        HttpURLConnection con = (HttpURLConnection) url.openConnection();
                        con.setRequestMethod("POST");

                        HashMap<String, Object> params = new HashMap();
                        params.put("username", inst.getUsername());
                        params.put("bill", inst.getBill());
                        // params.put("client_id", inst.getClient_id());
                        params.put("transaction_status", inst.isTransaction_status());
                        params.put("session", inst.getSession());

                        StringBuilder result = new StringBuilder();
                        boolean first = true;
                        Set<String> set = params.keySet();
                        for (String key : set) {
                            if (first) {
                                first = false;
                            } else {
                                result.append("&");
                            }
                            result.append(URLEncoder.encode(key.toString(), "UTF-8"));
                            result.append("=");
                            result.append(URLEncoder.encode(params.get(key).toString(), "UTF-8"));
                        }

                        con.setDoOutput(true);
                        OutputStream os = con.getOutputStream();
                        BufferedWriter writer = new BufferedWriter(
                                new OutputStreamWriter(os, "UTF-8"));
                        writer.write(result.toString());
                        writer.close();
                        os.close();

//                        con.setRequestProperty("username", inst.getUsername());
//                        con.setRequestProperty("bill", bill + "");
//                        con.setRequestProperty("client_id", inst.getClient_id());
//                        con.setRequestProperty("transaction_status", inst.isTransaction_status() + "");
                        con.connect();
                        int statusCode = con.getResponseCode();
                        if (statusCode == HttpURLConnection.HTTP_OK) {
                            String resp = "<script type='text/javascript'>"
                                    + "window.close();"
                                    + "</script>";
                            out.print(resp);
                            con.disconnect();
                            return;
                        }

                    }

                }
            }
            /*send window.close method as the response.
             and the json data to the callback url.*/
            String resp = "<html><head><script type='text/javascript'>"
                    + "function close(){"
                    + "window.close();};"
                    + "</script></head>"
                    + "<body>"
                    + "<button type=button onclick=close()>click to close</button>Transaction Failed"
                    + "</body>"
                    + "</html>";


            out.print(resp);



        } catch (Exception e) {
            System.out.println("Exception: " + e);
        } finally {
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
