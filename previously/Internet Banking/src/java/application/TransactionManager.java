/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application;

import database.Database;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Rahul
 */
public class TransactionManager {

    public static boolean addAutoDebit
        (HttpServletRequest request)
    {
        try{
        System.out.println("in transaction manager..");
        String username=request.getParameter("username");
        String target=request.getParameter("target");
        String down_payment=(request.getParameter("down_payment"));
        String  per_emi=(request.getParameter("amt_per_ins"));
        int no_of_inst=Integer.parseInt(request.getParameter("installments"));
        String day=request.getParameter("day");
        String month=request.getParameter("month");
        String year=request.getParameter("year");
        String start_date=day+"-"+month+"-"+year;
        int pay_date=Integer.parseInt(request.getParameter("pay_date"));
        String comment=request.getParameter("comment");
        String name=request.getParameter("name");
        System.out.println("parameters from request taken..");
        Database db= new Database();
        return db.addAutoDebit(username, target, down_payment, per_emi, no_of_inst, start_date, pay_date, comment, name);
        }
 catch (Exception e) {
            System.out.println("exception in transaction manager()add auto debit..");
            e.printStackTrace(System.out);
            return false;
        }
        
    }

    public static boolean applyForCredit
        (HttpServletRequest request)
    {
        try {
            String username = request.getParameter("username");
            String source_income = request.getParameter("source_income");
            String profession = request.getParameter("profession");
            float annual_income = Float.parseFloat(request.getParameter("annual_income"));
            String surety = request.getParameter("surety");
            String verified = "no";
            String query = "insert into credit_enable_details values" + ""
                    + "('" + username + "','" + source_income + "','" + profession + "',"
                    + annual_income + ",'" + surety + "','" + verified + "')";
            //
            //
            //
            ////..........INCOMPLETE...........
            //
            //
            Database db = new Database();
            if (db.runUpdate(query) > 0) {
                return true;
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionManager.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }

    }

public static ResultSet getTransactions(HttpServletRequest request)
    {
    try
    {
    System.out.println("inside get transactions..");
    String username=request.getParameter("username");
    System.out.println(username);
    String from_day=request.getParameter("from_day");
    String from_month=request.getParameter("from_month");
    String from_year=request.getParameter("from_year");
    if(from_day==null) from_day="1";
    if(from_month==null) from_month="january";
    if(from_year==null) from_year="2011";
    String from=from_day+"/"+from_month+"/"+from_year;
       
        System.out.println(from);
         String to_day=request.getParameter("to_day");
    String to_month=request.getParameter("to_month");
    String to_year=request.getParameter("to_year");
    if(to_day==null) to_day="1";
    if(to_month==null) to_month="january";
    if(to_year==null) to_year="2011";
    
    String to=to_day+"/"+to_month+"/"+to_year;
        
         System.out.println(to);
    boolean withdraw=false;
    if(request.getParameter("withdraws")!=null) if(request.getParameter("withdraws").equals("on")) withdraw=true;
    boolean deposit=false;
    if(request.getParameter("deposits")!=null) if(request.getParameter("deposits").equals("on")) deposit=true;
    boolean money_transfer=false;
    if(request.getParameter("money_transfer")!=null) if(request.getParameter("money_transfer").equals("on")) money_transfer=true;

    Database db= new Database();
    ResultSet rs=db.getTransactions(username, from, to, withdraw, deposit, money_transfer);
    System.out.println(rs);
        return rs;
        }
    catch(Exception e)
        {
        System.out.println("exception in gettransactions(transaction manager)");
        e.printStackTrace(System.out);
        return null;
        }
    }

public static ResultSet getAutoDebits(String username )
    {
        try {
            String query = "select * from auto_debit where username='" + username + "'";
            Database db = new Database();
            return db.runCode(query);
        } catch (SQLException ex) {
            Logger.getLogger(TransactionManager.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
public static ResultSet getAutoDebits(HttpServletRequest request )
    {
    return getAutoDebits(request.getParameter("username"));
}

public static boolean payAutoDebit(String id)
    {
        try {
            String query = "select * from auto_debit where autodebit_id=" + id;
            Database db = new Database();
            ResultSet rs = db.runCode(query);
                if(rs.next()){
            String username = rs.getString("username");
                String to_username = rs.getString("to_username");
                String amount=rs.getString("amt_per_installment");
                String comment=rs.getString("any_comment");
                String name=rs.getString("name");
                int no_of_inst=rs.getInt("no_of_installments");
                String feature=rs.getString("feature");
               
                db.money_transfer(username, to_username, amount, comment, name,true);
                no_of_inst--;
                double amount_paid=rs.getDouble("amount_paid")+Double.parseDouble(amount);
                double amount_to_be_paid=rs.getDouble("amount_to_be_paid")-Double.parseDouble(amount);
                if(no_of_inst<=0)
                    query="delete from auto_debit where autodebit_id="+id;
                else
                    query="update auto_debit set no_of_installments="+no_of_inst+", "
                            + "amount_paid="+amount_paid+", amount_to_be_paid="+amount_to_be_paid+" where autodebit_id="+id;
                System.out.println(query);
                int res=db.runUpdate(query);
                System.out.println(res);
                    if (res == 0) {
                        return true;
                    }
            }
            return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(TransactionManager.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

public static boolean edit_auto_debit(HttpServletRequest request)
    {
        try {
            
            int flag = 0;
            String id = request.getParameter("id");
            int installments = 0;
            int pay_date = 0;
            double amount = 0;
            String comment = "";
            String feature = "";
            String query = "update auto_debit set ";
            if (request.getParameter("installments_check") != null) {
                if (request.getParameter("installments_check").equals("on")) {
                    installments = Integer.parseInt(request.getParameter("installments"));
                    if (flag > 0) {
                        query += ", no_of_installments=" + installments;
                    } else {
                        flag++;
                        query += "no_of_installments=" + installments;
                    }
                }
            }
            if (request.getParameter("pay_date_check") != null) {
                if (request.getParameter("pay_date_check").equals("on")) {
                    pay_date = Integer.parseInt(request.getParameter("pay_date"));
                    if (flag > 0) {
                        query += ", pay_date=" + pay_date;
                    } else {
                        query += "pay_date=" + pay_date;
                        flag++;
                    }
                }
            }
            if (request.getParameter("emi_check") != null) {
                if (request.getParameter("emi_check").equals("on")) {
                    amount = Double.parseDouble(request.getParameter("amt_per_ins"));
                    if (flag > 0) {
                        query += ", amt_per_installment=" + amount;
                    } else {
                        query += "amt_per_installment=" + amount;
                        flag++;
                    }
                }
            }
            if (request.getParameter("comment_check") != null) {
                if (request.getParameter("comment_check").equals("on")) {
                    comment = request.getParameter("comment");
                    if (flag > 0) {
                        query += ", comment='" + comment + "'";
                    } else {
                        query += "comment='" + comment + "'";
                        flag++;
                    }
                }
            }
            if (request.getParameter("feature_check") != null) {
                if (request.getParameter("feature_check").equals("on")) {
                    feature = request.getParameter("feature");
                    if (flag > 0) {
                        query += ", feature='" + feature + "'";
                    } else {
                        query += "feature='" + feature + "'";
                        flag++;
                    }
                }
            }
            query += " where autodebit_id=" + id;
            System.out.println(query);
            Database db = new Database();
            int res = db.runUpdate(query);
            System.out.println(res);
            if(res==1)
                return true;
            else
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionManager.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }


public static boolean transfer(HttpServletRequest request)
    {
    System.out.println("in tranaction manager");
        String from=request.getParameter("from_username");
        String to = request.getParameter("to_username");
        String amount= (request.getParameter("amount"));
        String name=request.getParameter("name");
        String comment=request.getParameter("comment");
        Database db=new Database();
        boolean res=db.isBalanceSufficient(from, amount);
        System.out.println("from isbalsuff "+res);
        if(res){
            System.out.println("true, before db.money_transfer call");
            return db.money_transfer(from, to, amount, comment, name, false);
        }
        else
            return false;
    }

public static boolean deposit(HttpServletRequest request)
    {
    System.out.println("in transaction manager");
        String username=request.getParameter("username");
        String amount= (request.getParameter("amount"));
        String name=request.getParameter("name");
        String comment=request.getParameter("comment");
        Database db=new Database();
        
            return db.deposit(username, amount, name, comment);
       
           
    }
public static boolean withdraw(HttpServletRequest request)
    {
    System.out.println("in transaction manager");
        String username=request.getParameter("username");
        String amount= (request.getParameter("amount"));
        String name=request.getParameter("name");
        String comment=request.getParameter("comment");
        Database db=new Database();
        if(db.isBalanceSufficient(username, amount))
            return db.withdraw(username, amount, name, comment);
        else
            return false;
    }


public static boolean checkIfAppliedForCredit(String username)
    {
        try {
            String query = "select verified from credit_enable_details where username='" + username + "'";
            Database db = new Database();
            ResultSet rs=db.runCode(query);
            if(rs.next())
                return true;
            else
                return false;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionManager.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }


public static boolean createAccount(HttpServletRequest request)
    {
    String appno=(request.getParameter("appno"));
    String balance=(request.getParameter("balance"));
    Database db= new Database();
    return db.createAccount(appno,balance);
}

public static ResultSet getCreditDetails(HttpServletRequest request)
    {
   return  getCreditDetails(request.getParameter("username"));
    }
public static ResultSet getCreditDetails(String username)
    {
        try {
            String query = "select * from credit_history where username='" + username + "'";
            Database db = new Database();
            System.out.println(query+" (getCreditDetails)");
            return db.runCode(query);
        } catch (SQLException ex) {
            Logger.getLogger(TransactionManager.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Exception in getCreditDetails");
            return null;
        }
    }

public static boolean disableCredit(HttpServletRequest request)
    {
        String username=request.getParameter("username");
        return disableCredit(username);
    }
public static boolean disableCredit(String username)
    {
        try {
            String query = "update details set credit_enabled='no'";
            Database db = new Database();
            int i = db.runUpdate(query);
            if(i>0)
                return true;
            else
                return false;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionManager.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }


public static boolean enableCredit(HttpServletRequest request)
    {
        String username=request.getParameter("detail_user");
        String credit_lim=request.getParameter("credit_lim");
        String response=request.getParameter("response");
        return enableCredit(username,credit_lim,response);
    }

/*work left out on this function.*/
public static boolean enableCredit(String username,String credit_lim,String response)
    {
        try {
            System.out.println("1.in enablecredit");
            if(response.equals("allow"))
            {
            String query = "update details set credit_enabled='yes',credit_limit="+credit_lim+" where username='"+username+"'";
            Database db = new Database();
            System.out.println(query);
            int i = db.runUpdate(query);
            System.out.println(i);
            if(i==0){
                query = "update credit_enable_details set ='yes' where username='"+username+"'";
                System.out.println(query);
                i = db.runUpdate(query);
                System.out.println(i);
                if(i==0)
                    return true;
                else 
                    return false;
            }
            else
                return false;
            }
            else if(response.equals("deny")){
                String query = "delete from credit_enable_details where username='"+username+"'";
                 Database db = new Database();
            System.out.println(query);
            int i = db.runUpdate(query);
            System.out.println(i);
            if(i==0){
                return true;
            }
                return false;
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(TransactionManager.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
