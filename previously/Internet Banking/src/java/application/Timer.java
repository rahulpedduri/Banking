/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application;

/**
 *
 * @author Rahul
 */
import database.Database;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Timer {

   

    public static void start()
    {
        Thread th= new Thread();
        

       for(;;)
       {
            try {
                   Database db = new Database();
                   process(db);
                    
                    th.sleep(1000 * 60 * 60 * 24); //a day!
            } catch (InterruptedException ex) {
                Logger.getLogger(Timer.class.getName()).log(Level.SEVERE, null, ex);
            
            }
        }


    }

    private static boolean process(Database db)
    {
        try {
            String query = "select * from auto_debit where ";
            Calendar currentDate = Calendar.getInstance();
            query += "pay_date=" + currentDate.DAY_OF_MONTH + "";
            ResultSet rs = db.runCode(query);
            while (rs.next()) {
                String username = rs.getString("username");
                String to_username = rs.getString("to_username");
                String amount=rs.getString("amt_per_installment");
                String comment=rs.getString("comment");
                String name=rs.getString("name");
                int no_of_inst=rs.getInt("no_of_installments");
                String id=rs.getString("autodebit_id");
                String feature=rs.getString("feature");
                if(feature.equals("yes"))
                {
                db.money_transfer(username, to_username, amount, comment, name,true);
                no_of_inst--;
                double amount_paid=rs.getDouble("amount_paid")+Double.parseDouble(amount);
                double amount_to_be_paid=rs.getDouble("amount_to_be_paid")-Double.parseDouble(amount);
                if(no_of_inst<=0)
                    query="delete from auto_debit where autodebit_id="+id;
                else
                    query="update auto_debit set no_of_installments="+no_of_inst+" and "
                            + "amount_paid="+amount_paid+" and amount_to_be_paid="+amount_to_be_paid+" where autodebit_id="+id;
                if(db.runUpdate(query)>0)
                    return true;
                else
                    return false;
                }
            }
            return true;
        } catch (SQLException ex) {
            //Logger.getLogger(Timer.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    private static void warn(Database db)
    {
        try {
            String query = "select * from auto_debit where ";
            Calendar currentDate = Calendar.getInstance();
            query += "warn_date <= " + currentDate.DAY_OF_MONTH + " and pay_date > " + currentDate.DAY_OF_MONTH;
            ResultSet rs = db.runCode(query);
            while(rs.next())
            {
                String username = rs.getString("username");
                double amount=rs.getDouble("amt_per_installment");
                String id=rs.getString("autodebit_id");
                query="select * from details where username='"+username+"'";
                ResultSet rs2=db.runCode(query);
                if(rs2.next())
                {
                    if(rs2.getDouble("balance")<=1000)
                    {
                        query="update auto_debit set feature='off' where autodebit_id="+id;
                        db.runUpdate(query);
                    }
                    if(rs2.getString("credit_enabled").equalsIgnoreCase("yes")
                            && (rs2.getDouble("credit")+amount) < rs2.getDouble("credit_limit"))
                    {
                         query="update auto_debit set by_credit='yes' where autodebit_id="+id;
                        db.runUpdate(query);
                    }
                }

            }
        } catch (SQLException ex) {
            Logger.getLogger(Timer.class.getName()).log(Level.SEVERE, null, ex);
        }
    }



}
