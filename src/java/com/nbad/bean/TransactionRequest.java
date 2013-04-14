/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbad.bean;

import java.util.ArrayList;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Phani Rahul
 */
public class TransactionRequest {

    private String client_id;
    private String merchant_name;
    private String username;
    private double bill;
    private String bill_desc;
    private String callback;
    private boolean transaction_status;
    private ArrayList fail_reasons;
    private String session;

    public JSONObject getResponseInJSON() {

        JSONObject inst = new JSONObject();
        if (client_id != null && !client_id.trim().equals("")) {
            inst.put("client_id", client_id);
        }
         if (session != null && !session.trim().equals("")) {
            inst.put("session", session);
        }
        if (bill > 0) {
            inst.put("bill", bill);
        }       
            inst.put("transaction_status", transaction_status);
            
 
        if (fail_reasons != null && !fail_reasons.isEmpty()) {
            JSONArray reasons = new JSONArray();
            reasons.addAll(fail_reasons);
            inst.put("failure_reasons", reasons);
        }
        return inst;
    }

    public TransactionRequest() {
        bill= 0;
        transaction_status=false;
        fail_reasons = new ArrayList();        
    }

    
    public String getClient_id() {
        return client_id;
    }

    public void setClient_id(String client_id) {
        this.client_id = client_id;
    }

    public String getMerchant_name() {
        return merchant_name;
    }

    public void setMerchant_name(String merchant_name) {
        this.merchant_name = merchant_name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public double getBill() {
        return bill;
    }

    public void setBill(double bill) {
        this.bill = bill;
    }

    public String getBill_desc() {
        return bill_desc;
    }

    public void setBill_desc(String bill_desc) {
        this.bill_desc = bill_desc;
    }

    public String getCallback() {
        return callback;
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }

    public boolean isTransaction_status() {
        return transaction_status;
    }

    public void setTransaction_status(boolean transaction_status) {
        this.transaction_status = transaction_status;
    }

    public ArrayList getFail_reasons() {
        return fail_reasons;
    }

    public void setFail_reasons(ArrayList fail_reasons) {
        this.fail_reasons = fail_reasons;
    }

    public String getSession() {
        return session;
    }

    public void setSession(String session) {
        this.session = session;
    }
    
}
