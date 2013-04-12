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




//......................................................
public class Detail {

    public static boolean editDetails(HttpServletRequest request)
    {
        try {
           
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("USERNAME");
            String query = "insert all " + " ";
            if (request.getParameter("name_check") != null) {
                String first_name = request.getParameter("first_name");
                String last_name = request.getParameter("last_name");
                query += "into request_edit_details(username,details,time_of_trans,value)"
                        + " values('" + username + "','first_name',current_timestamp,'" + first_name + "')" + ""
                        + "into request_edit_details(username,details,time_of_trans,value)"
                        + " values('" + username + "','last_name',current_timestamp,'" + last_name + "')";
            }
            if (request.getParameter("address_check") != null) {
                String address = request.getParameter("address");
                query += " into request_edit_details(username,details,time_of_trans,value)"
                        + " values('" + username + "','address',current_timestamp,'" + address + "')";
            }
            if (request.getParameter("email_check") != null) {
                String email = request.getParameter("email");
                query += "into request_edit_details(username,details,time_of_trans,value)"
                        + " values('" + username + "','email',current_timestamp,'" + email + "')";
            }
            if (request.getParameter("dob_check") != null) {
                String day=request.getParameter("day");
                String month=request.getParameter("month");
                String year=request.getParameter("year");
//                String dob = "to_char(to_date('"+day+"/"+month+"/"+year+"','dd/month/year'))";
                String dob = day+"/"+month+"/"+year;
                query += "into request_edit_details(username,details,time_of_trans,value)"
                        + " values('" + username + "','dob',current_timestamp,'" + dob + "')";
            }
            if (request.getParameter("phone_no_check") != null) {
                String phone = request.getParameter("phone_no");
                query += "into request_edit_details(username,details,time_of_trans,value)"
                        + " values('" + username + "','phone',current_timestamp,'" + phone + "')";
            }
            query+=" select * from dual";

            System.out.println(query);
            Database db = new Database();
            int i = db.runUpdate(query);
            System.out.println(i);
            if(i>0) return true;
            else
                return false;
        } catch (SQLException ex) {
            Logger.getLogger(Detail.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean commitChange(String username)
    {
        try {
            Database db = new Database();
            boolean flag = true;
            String query = "select * from request_edit_details where username='" + username + "'";
            System.out.println(query);
            ResultSet rs = db.runCode(query);
            for (flag = rs.next(); rs.next();) {
                String detail = rs.getString("details");
                String value = rs.getString("value");
                query = "update details set " + detail + " ='" + value + "' where username='" + username + "'";
                flag = db.runUpdate(query)>0 && flag;
                query = "delete from request_edit_details where username='" + username + "' and details='" + detail + "' "
                        + "and value='" + value + "'";
                db.runUpdate(query);
            }
            return flag;
        } catch (SQLException ex) {
            Logger.getLogger(Detail.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }

    }
     public static boolean commitChange(String username,String detail,String response)
    {
         try {
            Database db = new Database();
            boolean flag = true;
            if(response.equals("allow")){
            String query = "select * from request_edit_details where username='" + username + "' and details='"+detail+"'";
            ResultSet rs = db.runCode(query);
            for (; rs.next();) {
                String details = rs.getString("details");
                String value = rs.getString("value");
                query = "update details set " + details + " ='" + value + "' where username='" + username + "'";
                System.out.println(query);
                flag = db.runUpdate(query)>0 && flag;
                query = "delete from request_edit_details where username='" + username + "' and details='" + details + "' "
                        + "and value='" + value + "'";
                System.out.println(query);
                flag=db.runUpdate(query)>0 && flag;
            }
            return flag;
             }
            else{
                String query="select * from request_edit_details where username='" + username + "' and details='"+detail+"'";
            ResultSet rs = db.runCode(query);
            for (; rs.next();) {
                String details = rs.getString("details");
                String value = rs.getString("value");
                query = "delete from request_edit_details where " + details + " ='" + value + "' and username='" + username + "'";
                System.out.println(query);
                flag = db.runUpdate(query)>0 && flag;
            }
            return flag;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Detail.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }

     }

      public static boolean commitChange(HttpServletRequest request)
    {
          String username=request.getParameter("detail_user");
          String detail=request.getParameter("detail");
          String response=request.getParameter("response");
          return commitChange(username, detail,response);
      }

    public static String getDetail(String detail,String username)
    {
        try {
            String query = "select " + detail + " from details where username='" + username + "'";
            Database db = new Database();
            ResultSet rs = db.runCode(query);
            System.out.println(query);
            if(rs.next()){
                System.out.println("after rs.next, returning the detail");
            return rs.getString(detail);
            }
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(Detail.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

}
