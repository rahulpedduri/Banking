/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application;
import database.Database;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rahul
 */
public class Account {
    public static ResultSet getDetails(String username) throws SQLException
    {
        ResultSet rs=null;
        Database db= new Database();
        String query="select * from details where username='"+username+"'";
        rs=db.runCode(query);
        
        return rs;
    }

    public static ResultSet getDetailsForSession(String username) throws SQLException
    {
        ResultSet rs=null;
        Database db= new Database();
        String query="select username,first_name,last_name,to_char(dob,'dd month yyyy') as dob"
                + ",address,email,photo,balance,bank_ac_no as bank_acc,phone,status from details where username='"+username+"'";
        rs=db.runCode(query);

        return rs;
    }
    public static boolean pre_security_question_change(HttpServletRequest request)
    {
        Database db=new Database();
        try{
       
        int i=0;
        HttpSession session= request.getSession();
        String username= (String) session.getAttribute("USERNAME");
        String password= request.getParameter("password");
        String query="select * from security where username='"+username+"' and password='"+password+"'";

        System.out.println(username+" "+password+" :"+query);

        ResultSet rs=db.runCode(query);
            if (rs.next())
            {
                String question=request.getParameter("new_security_question");
                String answer=request.getParameter("new_security_answer");
                query="insert into security_edit_details(username, details,time_of_trans, value) "
                        + "values('"+username+"','security_ques',current_timestamp,'"+question+"')";
                
                System.out.println(question+" "+answer+" :"+query);
                i=db.runUpdate(query);
                System.out.println(i);
                if(i>0)
                {
                    query="insert into security_edit_details(username, details,time_of_trans, value) "
                        + "values('"+username+"','security_ans',current_timestamp,'"+answer+"')";
                    System.out.println(query);

                    i=db.runUpdate(query);
                    if(i>0)
                        {System.out.println("successful");return true; }                   
                }
            }System.out.println(false);

        return false;
        }
        catch(Exception e){ System.out.println("exception"+e);return false;}
        finally{}


       
    }


    public static boolean security_question_change(HttpServletRequest request) 
    {
        return commit_security_change(request);
    }


    public static boolean pre_password_change(HttpServletRequest request)
    {
        Database db= new Database();
         try{
       
        HttpSession session= request.getSession();
        String username= (String) session.getAttribute("USERNAME");
        String password= request.getParameter("password");
        String query="select * from security where username='"+username+"' and password='"+password+"'";
        ResultSet rs=db.runCode(query);
        if(request.getParameter("new_password").equalsIgnoreCase(request.getParameter("confirm_password")))
            {password=request.getParameter("new_password");}
        else return false;

            if (rs.next())
            {
                query="insert into security_edit_details(username, details,time_of_trans, value) "
                        + "values('"+username+"','password',current_timestamp,'"+password+"')";
                if (db.runCode(query).next()) {
                    return true;
                } else {
                    return false;
                }


            } return false;
        }
        catch(Exception e){return false;}
        finally{}
    }

    public static boolean password_change(HttpServletRequest request)
    {
         return commit_security_change(request);
    }




    private static boolean commit_security_change(HttpServletRequest request)
    {
        Database db= new Database();
        try{
        
        boolean flag=true;
        HttpSession session= request.getSession();
        String username= (String) session.getAttribute("USERNAME");
        String query="select * from security_edit_details where username='"+username+"'";
        ResultSet rs=db.runCode(query);
            for(flag=rs.next();rs.next();)
            {
                String detail=rs.getString("details");
                String value=rs.getString("value");
                query="update security set "+detail+" ='"+value+"' where username='"+username+"'";
                flag=db.runCode(query).next() && flag;
                query="delete from security_edit_details where username='"+username+"' and details='"+detail+"' and value='"+value+"'";
                db.runCode(query);
            }
        return flag;
        }
        catch(Exception e){ return false;}
    }

    public static boolean addVerificationCode(String email, String reason)
    {
        Database db= new Database();
        try{
        String query="delete from verification_code where email='"+email+"' and reason='"+reason+"'";

        System.out.println(query);
        
        db.runUpdate(query);
            String code= CodeGenerator.next()+"";
            query="insert into verification_code(email,code,datetime,reason)"
                + "values('"+email+"','"+ code+"',sysdate,'"+reason+"')";
            System.out.println(query);
            int i=db.runUpdate(query);
            System.out.println("before if "+i);
            if(i>0)
            {
                System.out.println("in if "+i);
               if( Mail.sendVerificationCode(email, code, reason))
                return true;
            }
        
        return false;
        }
        catch(Exception e){ System.out.println("exception in addVerificationCode()"); e.printStackTrace(System.out); return false;}

    }

    public static boolean emailVerified(HttpServletRequest request)
    {
         Database db = new Database();
        try {
            String email = request.getParameter("email");
            String query = "update application_form set email_verified='yes' where email='" + email + "'";
           
            int i = db.runUpdate(query);
            if(i>0) { return true; }
            else
                return false;
        } catch (SQLException ex) {
            Logger.getLogger(Account.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean resetPassword(String username)
    {
        Database db = new Database();
        try {
            
            String password=CodeGenerator.next()+"";
            String query = "update security set password='" +password+ "' where username='" + username + "'";
            int i = db.runUpdate(query);
            System.out.println(query+" "+i);
                query = "update application_form set password='" +password+ "' where username='" + username + "'";
                 i = db.runUpdate(query);
                 System.out.println(query+" "+i);
                
                query="select email from application_form where username='"+username+"'";
                System.out.println(query+" ");
                ResultSet rs= db.runCode(query) ;
                if(rs.next()){
                String email=rs.getString("email");
                Mail.sendPasswordReset(email, password);
                return true;
            }
                return false;
           
        } catch (SQLException ex) {
            Logger.getLogger(Account.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

     public static boolean apply(
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
             String type_of_user)
    {
        Database db = new Database();

        boolean flag=db.insert_into_application_form(
                application_no,
                first_name,
                last_name,
                dob, address,
                email, phone,
                pan_no,
                username,
                password,
                security_ques,
                security_ans,
                photo,
                email_verified,
                type_of_user);
        
        return flag;
    }

     public static ResultSet getDetailChangeRequests(String username)
    {
        try {
            String query = "select * from request_edit_details";
            if (username != null) {
                if (!username.equals("")) {
                    query += " where username='" + username + "'";
                }
            }
            System.out.println(query);
            Database db = new Database();
            ResultSet rs = db.runCode(query);
            System.out.println("returning result set: "+rs);
            return rs;
        } catch (SQLException ex) {
            Logger.getLogger(Account.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
     public static ResultSet getCreditEnableRequests(String username)
    {
         try {
            String query = "select * from credit_enable_details where verified='no'";
            if (username != null) {
                if (!username.equals("")) {
                    query += " and username='" + username + "'";
                }
            }
            System.out.println(query);
            Database db = new Database();
            ResultSet rs = db.runCode(query);
            System.out.println("returning result set: "+rs);
            return rs;
        } catch (SQLException ex) {
            Logger.getLogger(Account.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }

     public static boolean isCreditEnabled(String username)
    {
        try {
            String query = "select credit_enabled from details where username='" + username + "'";
            System.out.println(query);
            Database db = new Database();
            ResultSet rs = db.runCode(query);
            if (rs.next()) {
                System.out.println("in isCreditEnabled..");
                if (rs.getString("credit_enabled").equals("yes")) {
                    System.out.println("credit enabled: true");
                    return true;
                }
            }
            System.out.println("credit enabled: false");
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(Account.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
     }

     public static boolean saveNewPassword(HttpServletRequest request)
    {
         String username=request.getParameter("username");
         String password=request.getParameter("password");
         String new_password=request.getParameter("new_password");
         if(password.equals(new_password))
         {
            try {
                String query = "update security set password='" + password + "' where username='" + username + "'";
                Database db = new Database();
                int i = db.runUpdate(query);
                if(i>0)
                    return true;
                else return false;
            } catch (SQLException ex) {
                Logger.getLogger(Account.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            }

         }
         return false;
     }
}
