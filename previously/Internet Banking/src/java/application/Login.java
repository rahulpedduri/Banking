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


/**
 *
 * @author Rahul
 */
public class Login {
    
public static boolean verify(String username, String password )
    {
    Database db=new Database();
    String query="select username, password from security where username='"+username+"' and password='"+password+"'";
    try{
    ResultSet rs=db.runCode(query);
    if(rs.next()) return true;
    else
    return false;
        }
    catch(Exception e){return false;}
    }
public static boolean verifySecurityQuestion(String username, String question, String answer)
    {
        try {
            Database db = new Database();
            String query = "select username from security where username='" + username + "' and "
                    + "security_ques='" + question + "'" + "and security_ans='" + answer + "'";
            ResultSet rs = db.runCode(query);
            if(rs.next())
            {
                return true;
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}


