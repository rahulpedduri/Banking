/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package database;

import java.sql.*;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Rahul
 */
public class Database {

    Connection con=null;
    Statement st=null;
    PreparedStatement ps=null;
    CallableStatement cs=null;
    ResultSet rs=null;
    boolean flag=true;

    public Database()
    {
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con=DriverManager.getConnection("jdbc:oracle:thin:@RAHUL-PC:1521:XE","rahuldon74","dare2die");
            System.out.println("database connection established");
        }
        catch(Exception e)
        {
            System.out.println("Exception in the constructor");
            flag=false;
        }
    }

    @Override
    protected void finalize() throws Throwable {
        super.finalize();
        con.close();
        st.close();
        ps.close();
        rs.close();
        cs.close();
        System.out.println("database connection closed");
    }
    public void closeAll() {
        try {
            con.close();
        st.close();
        ps.close();
        rs.close();
        cs.close();
        System.out.println("database connection closed");

        } catch (Exception e) {
        }
    }



     public  boolean insert_into_application_form(
             long application_no,
             String first_name,
             String last_name,
             String dob,
             String address,
             String email,
             String phone,
             String pan_no,
             String username,
             String password,
             String security_ques,
             String security_ans,
             String photo,
             String email_verified,
             String type_of_user
             )
    {
         if(!flag)
             return false;

         try
         {
             String query="";
             dob="to_date('"+dob+"','dd-month-yyyy')";
             String appno=null;
             if(application_no!=0) appno=""+ application_no;
             query="insert into application_form"
                     + "(application_no,first_name,last_name,dob,address,email,"
                     + "phone,pan_no,username,password,security_ques,security_ans,photo,email_verified,type_of_user)"
                     + "values("+appno+",?,?,"+dob+",?,?,"+phone+",?,?,?,?,?,?,?,?)";
             
         ps=con.prepareStatement(query);

         System.out.println(query);
         ps.setString(1,first_name);
         ps.setString(2,last_name);
         ps.setString(3,address);
         ps.setString(4,email);
         ps.setString(5,pan_no);
         ps.setString(6,username);
         ps.setString(7,password);
         ps.setString(8,security_ques);
         ps.setString(9,security_ans);
         ps.setString(10,photo);
         ps.setString(11,email_verified);
         ps.setString(12,type_of_user);
            System.out.println(ps);
         int count = ps.executeUpdate();
         ps.close();
         if(count<=0)
             return false;

         }
         catch(Exception e)
         {
             e.printStackTrace(System.out);
             return false;
         }
         return true;
    }

     public boolean insert_into_verification_code(
             String email,
             String code,
             String reason)
    {
      if(!flag)
             return false;
       try
         {
             ps=con.prepareStatement("insert into verification_code(email,code,datetime,reason) values(?,?,sysdate,?)");
             ps.setString(1, email);
             ps.setString(2, code);
             ps.setString(3,reason);
             int count=ps.executeUpdate();
             ps.close();
             if(count<=0)
                 return false;

         }
       catch(Exception e) 
         {
           e.printStackTrace(System.out);
            return false;
         }
    return true;
    }


      public boolean insert_into_temp_edit_details(
        String username,
        String details,
        String value)
 {
    if(!flag)
             return false;

try
    {
      ps=con.prepareStatement("insert into temp_edit_details(username,details,datetime,value) values(?,?,sysdate,?)");
      ps.setString(1,username);
      ps.setString(2,details);
      ps.setString(3,value);
      int count=ps.executeUpdate();
      ps.close();
      if(count<=0)
          return false;
     }
catch(Exception e)
     {
        e.printStackTrace(System.out);
       return false;
     }
    return true;
}

public boolean insert_into_request_edit_details(
     String username,
     String details,
     String value)
    {
        if(!flag)
             return false;

try
    {
      ps=con.prepareStatement("insert into request_edit_details(username,details,time_of_trans,value) values(?,?,sysdate,?)");
      ps.setString(1,username);
      ps.setString(2,details);
      ps.setString(3,value);
      int count=ps.executeUpdate();
      ps.close();
      if(count<=0)
          return false;
     }
catch(Exception e)
     {
    e.printStackTrace(System.out);
       return false;
     }
    return true;
}

public boolean insert_into_security_edit_details(
     String username,
     String details,
     String value)
    {
        if(!flag)
             return false;

try
    {
      ps=con.prepareStatement("insert into security_edit_details(username,details,time_of_trans,value) values(?,?,sysdate,?)");
      ps.setString(1,username);
      ps.setString(2,details);
      ps.setString(3,value);
      int count=ps.executeUpdate();
      ps.close();
      if(count<=0)
          return false;
     }
catch(Exception e)
     {
    e.printStackTrace(System.out);
       return false;
     }
    return true;
}

public boolean insert_into_credit_enable_details(
     String username,
     String sources_of_income,
     String profession,
     Double annual_income,
     String surity,
     String verified)
    {
        if(!flag)
             return false;

try
    {
      ps=con.prepareStatement("insert into credit_enable_details(username,sources_of_income,"
              + "profession,annual_income,surity,verified) values(?,?,?,?,?,?)");
      ps.setString(1,username);
      ps.setString(2,sources_of_income);
      ps.setString(3,profession);
      ps.setDouble(4,annual_income);
      ps.setString(5,surity);
      ps.setString(6,verified);
      int count=ps.executeUpdate();
      ps.close();
      if(count<=0)
          return false;
     }
catch(Exception e)
     {
    e.printStackTrace(System.out);
       return false;
     }
    return true;
}


public ResultSet runCode(String query) throws SQLException
    {
    System.out.println("in database runCode.."+query);
    st=con.createStatement();
    System.out.println(st+"");
    rs=st.executeQuery(query);
 
    return rs;

    }

public int runUpdate(String query) throws SQLException
    {
    System.out.println("in database runUpdate..");
    int i;
    st=con.createStatement();
    i=st.executeUpdate(query);
    System.out.println(i);
    return i;
    }

//...................................................................................
//code to call a procedure
//FUNCTION: callProcedure()
//...................................................................................

public long username_accno(String username)
    {
        try {
            String query = "select bank_ac_no from details where username='" + username + "'";
            st = con.createStatement();
            rs = st.executeQuery(query);
            if(rs.next())
                return rs.getLong("bank_ac_no");
            else return 0;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

public String accno_username(long accno)
    {
        try {
            String query = "select username from details where bank_ac_no=" + accno + "";
            st = con.createStatement();
            rs = st.executeQuery(query);
            if(rs.next())
                return rs.getString("username");
            else return "0";
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            return "0";
        }
    }

//........................................................................................................
//-------------------------------------PROCEDURE CALLS----------------------------------------------------
//..........................................................................................................

public boolean createAccount(long appno,double balance)
    {
        try {
            cs = con.prepareCall("{call create_bank_acc(?,?,?) }");
            cs.setLong(1, appno);
            cs.setDouble(2, balance);
            cs.registerOutParameter(3, Types.VARCHAR);

            System.out.println(cs);
            cs.execute();
            String result=cs.getString(3);
            boolean res=result.equalsIgnoreCase("success");
            System.out.println(result);
           if(res)
            return true;
           else
               return false;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
public boolean createAccount(String appno,String balance)
    {
        try {
            cs = con.prepareCall("{call create_bank_acc("+appno+","+balance+",?) }");
           
            cs.registerOutParameter(1, Types.VARCHAR);

            System.out.println(cs);
            cs.execute();
            String result=cs.getString(1);
            boolean res=result.equalsIgnoreCase("success");
            System.out.println(result);
           if(res)
            return true;
           else
               return false;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }


public boolean deposit(String username, String amount,String name,String comment)
    {

        try {
            System.out.println("in database");
            String result="";
            long accno=username_accno(username);
            System.out.println("before call");
            cs = con.prepareCall("{call deposit(?,"+amount+",?,?,?)}");
            System.out.println("after call");
            cs.setLong(1, accno);
            cs.setString(2, comment);
            cs.setString(3, name);

            cs.registerOutParameter(4,Types.VARCHAR);
            System.out.println(cs);
            cs.execute();
            result=cs.getString(4);
            boolean res=result.equalsIgnoreCase("success");
            System.out.println(result+" "+res);
           if(res)
            return true;
           else
               return false;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Exception in deposit");
            return false;
        }
    }

public boolean deposit(long accno, String amount,String name,String comment)
    {
    return deposit(accno_username(accno), amount, name, comment);
    }
public boolean withdraw(long accno, String amount,String name,String comment)
    {
    return withdraw(accno_username(accno), amount, name, comment);
    }


public boolean withdraw(String username, String amount,String name,String comment)
    {

        try {
            System.out.println("in database");
            String result="";
            long accno=username_accno(username);
            cs = con.prepareCall("{call withdraw(?,"+amount +",?,?,?)}");
            cs.setLong(1, accno);
            cs.setString(2, comment);
            cs.setString(3, name);

            cs.registerOutParameter(4,Types.VARCHAR);
            System.out.println(cs);
            if(!isBalanceSufficient(username, amount))
                return false;
            cs.execute();
            System.out.println("after withdraw execute");
            result=cs.getString(4);
            boolean res=result.equalsIgnoreCase("success");
            System.out.println(result);
           if(res)
            return true;
           else
               return false;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }



public boolean money_transfer(long accno,long target,String amount,String comment, String name,boolean autodebit)
    {
        try {
            System.out.println("in database");
            String result="";
            cs = con.prepareCall("{call money_transfer(?,?,"+amount+",?,?,?,?)}");
            cs.setLong(1, accno);
            cs.setLong(2, target);
            cs.setString(3, comment);
            cs.setString(4, name);
            if(autodebit)
                cs.setString(5, "yes");
            else
                cs.setString(5, "no");
            cs.registerOutParameter(6,Types.VARCHAR);
            System.out.println(cs);
            if(!isBalanceSufficient(accno_username(accno), amount))
                return false;
            cs.execute();
            System.out.println("after transfer execute");
            result=cs.getString(6);
            boolean res=result.equalsIgnoreCase("success");
            System.out.println(result);
           if(res)
            return true;
           else return false;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Exception in money_transfer");
            return false;
        }
    }
public boolean money_transfer(String username,long target,String amount,String comment, String name,boolean autodebit)
    {
        long accno=username_accno(username);
        money_transfer(accno, target, amount, comment, name,autodebit);

        return true;
    }
public boolean money_transfer(long accno,String target,String amount,String comment, String name,boolean autodebit)
    {
            long ta_acno=username_accno(target);
            money_transfer(accno, ta_acno, amount, comment, name,autodebit);

        
        return true;
    }
public boolean money_transfer(String accno,String target,String amount,String comment, String name,boolean autodebit)
    {
            long so_acno=username_accno(accno);
            long ta_acno=username_accno(target);
            money_transfer(so_acno, ta_acno, amount, comment, name,autodebit);
   
        return true;
    }

//........................................................................................................
//-------------------------------------ENDS---------------------------------------------------------------
//..........................................................................................................


public boolean addAutoDebit
        (long accno,long target, String down_payment, String per_emi, int no_of_inst,
        String start_date, int pay_date, String comment, String name)
    {
        try {
            System.out.println("in database, add auto debit..");
            String username = accno_username(accno);
            String to_username = accno_username(target);
            double amount_to_be_paid = Double.parseDouble(per_emi) * no_of_inst;
            int warn_date=pay_date-5;
                if(warn_date-5<=0)warn_date = 1;

            String query = "insert into auto_debit "
                    + "(autodebit_id, username, to_username, downpayment, amt_per_installment,"
                    + "no_of_installments, start_date, pay_date, amount_paid, amount_to_be_paid, name, any_comment,warn_date,feature, by_credit)"
                    + "values(null,'" + username + "', '" + to_username + "', " + down_payment + ", " + per_emi + ", " + no_of_inst + ", "
                    + "to_date('" + start_date + "','dd-month-yyyy'), " + pay_date + ", " + down_payment + ", " + amount_to_be_paid + ", '" + name + "', '" + comment + "'"
                    + ","+warn_date+",'on','no')";
            System.out.println(query);
            int res = runUpdate(query);
            System.out.println(res);
            if(res>0){
                if(isBalanceSufficient(username, down_payment)){
                    boolean result=money_transfer(accno, target, down_payment, comment, name,true);
                    System.out.println(result);
                    return result;
                }
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Exception in database add auto debit..");
            return false;
        }
    }
public boolean addAutoDebit
        (String accno,String target, String down_payment, String per_emi, int no_of_inst,
        String start_date, int pay_date, String comment, String name)
    {
    long sa_accno=username_accno(accno);
    long ta_accno=username_accno(target);
    return addAutoDebit(sa_accno, ta_accno, down_payment, per_emi, no_of_inst, start_date, pay_date, comment, name);

    }

public ResultSet getTransactions(String username, String from, String to, boolean withdraw, boolean deposit, boolean money_transfer)
    {
        try {
            int i = 0;
            String query = "select * from trans_history where username='" + username + "' ";
            if (withdraw) {
                query += "and trans_type in ('withdraw'";
                i++;
            }
            if (deposit) {
                if (i > 0) {
                    query += ",'deposit'";
                } else {
                    query += "and trans_type in ('deposit'";
                }
                i++;
            }
            if (money_transfer) {
                if (i > 0) {
                    query += ",'money transfer'";
                } else {
                    query += "and trans_type in ('money transfer'";
                }
                i++;
            }
            if (i > 0) {
                query += ")";
            }
            query += " and time_of_trans >= to_date('"+from+"','dd/month/yyyy')"
                    + " and time_of_trans <= to_date('"+to+"','dd/month/yyyy') order by time_of_trans" ;
           
           System.out.println(query);
           rs=runCode(query);

           if(rs==null) {System.out.println("failure");return null;}
           else{
               System.out.println("success");
            return rs;}
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("getTransactions exception.");
            return null;
        }
    }

public double getBalance(String username)
    {
        try {
            String query = "select balance from details where username='" + username + "'";
            rs = runCode(query);
            System.out.println(rs+" "+query);
            if(rs.next()){
            Double bal=rs.getDouble("balance");
            System.out.println("balance: "+bal);
            return bal;
            }
            return 0;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("exception in getbalance()");
            return 0;
        }

}

public double getBalance(Long accno)
    {
       String username=accno_username(accno);
       return getBalance(username);
}

public boolean isBalanceSufficient(String username, double amount)
    {
    System.out.println("before getbalance");
    double bal=getBalance(username);
    System.out.println("after getbalance, bal: "+bal);
    if(bal-amount>=1000){
        System.out.println("true from isbalsuff");
        return true;
        }
    else { 
        if(checkCredit(username,amount))
            return true;
        else
        System.out.println("false from isbalsuff"); return false;}
}
public boolean isBalanceSufficient(String username, String amount)
    {
    try{
        System.out.println("before parsing ");
        double amt=Double.parseDouble(amount);
        System.out.println("after parsing ");
    return isBalanceSufficient(username, amt);
        }

    catch(Exception e)
    {
        System.out.println("in database, isbalsufffunc");
        return false;
    }
}
//public boolean checkCredit(String username, double amount)
//    {
//    return checkCredit(username,amount);
//    }

public boolean checkCredit(String username, double amount)
    {
        try {
            String query = "select credit_enabled,credit_limit,credit from details where username='" + username + "' and credit_enabled='yes'";
            rs = runCode(query);
            if(rs.next())
            {
                String credit_enabled=rs.getString("credit_enabled");
                String credit_limit=rs.getString("credit_limit");
                String credit=rs.getString("credit");
                //double amt=Double.parseDouble(amount);
                System.out.println("amount: "+amount);
                double cre=Double.parseDouble(credit);
                System.out.println("credit: "+cre);
                double lim=Double.parseDouble(credit_limit);
                System.out.println("limit: "+lim);
                if(cre+amount<=lim)
                    return true;
                else
                    return false;
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
}


}








