/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


/**
 *
 * @author Rahul
 */
public class Mail {
    
    public static boolean sendVerificationCode(String email, String code, String reason)
    {
        String from="rahuldon74@gmail.com";
        String text="the verification code for "+reason+" is "+code;
        String subject="verification code for "+reason;

        return sendMail(email, from, subject, text);
    }

    public static boolean sendPasswordReset(String email, String password)
    {
        String from="rahuldon74@gmail.com";
        String text="the password  is "+password;
        String subject="password reset for "+email;

        return sendMail(email, from, subject, text);
        
    }

   public static boolean sendNotification(String email, String text)
    {
       String from="rahuldon@gmail.com";
        String subject="notification from bank";

        return sendMail(email, from, subject, text);
    }

   public static boolean sendMail(String to, String from, String subject, String text)
    {
            Properties prop = new Properties();
            prop.put("mail.smtp.host", "localhost");
            prop.put("mail.smtp.starttls.enable","false");
            prop.put("mail.smtp.port", "25");
            prop.put("mail.smtp.auth", "false");
           // prop.put("mail.smtp.user", "rahuldon74");
           // prop.put("mail.smtp.password", "dare2live");
            System.out.println("inside sendMail()");
            System.out.println(prop);
//            String username="rahuldon74";
//            String password="dare2live";
//            String host = "smtp.gmail.com";
//            int port = 587;

            Session session = Session.getInstance(prop);
            session.setDebugOut(System.out);
            System.out.println(session);
            Message msg = new MimeMessage(session);
            System.out.println(msg);
            InternetAddress from_addr = null;
            InternetAddress to_addr = null;
            try {
            from_addr=new InternetAddress(from);
            to_addr=new InternetAddress(to);
            System.out.println(from_addr+""+to_addr);
            } catch (AddressException ex) {
            Logger.getLogger(Mail.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("AddressException in sendMail()");
            return false;
        }
            try{
                msg.setFrom(from_addr);
                msg.setRecipient(RecipientType.TO, to_addr);
                msg.setSubject(subject);
                msg.setText(text);
                System.out.println("sendMail() "+msg);

//                Transport transport = session.getTransport("smtp");
//               // transport.connect(host, port, username, password);
//                Transport.send(msg);

                return true;
                }
         catch (MessagingException ex) {
            Logger.getLogger(Mail.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("MessagingException in sendMail()");
            return false;
        }
   }


}
