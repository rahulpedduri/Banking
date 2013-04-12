/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application;

import database.Database;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rahul
 */
public class CookieHandle {

    public static boolean check(String username, javax.servlet.http.HttpServletRequest request)
    {
        Cookie[] list = request.getCookies();
            if(list != null)
            {
                for(int i = 0; i < list.length;i++)
                {
                    if(list[i].getName().equalsIgnoreCase("username") && list[i].getValue().equalsIgnoreCase(username))
                        return true;
                }
        }
        return false;
    }

     public static boolean check(javax.servlet.http.HttpServletRequest request)
    {
        Cookie[] list = request.getCookies();
            if(list != null)
            {
                for(int i = 0; i < list.length;i++)
                {
                    if(list[i].getName().equalsIgnoreCase("username") && !list[i].getValue().equalsIgnoreCase(""))
                        return true;
                }
        }
        return false;
    }

     public static String getCurrentUser(javax.servlet.http.HttpServletRequest request)
     {
        Cookie[] list = request.getCookies();
            if(list != null)
            {
                for(int i = 0; i < list.length;i++)
                {
                    if(list[i].getName().equalsIgnoreCase("username") )
                       return list[i].getValue();
                }
        }
       return null;
     }

     public static void personalize(HttpServletRequest request, HttpServletResponse response) {
        PrintWriter out = null;
        ResultSetMetaData rsmd=null;
        try {
            response.setContentType("text/html;charset=UTF-8");

            out = response.getWriter();
            Database db = new Database();
            String query = "select username,type_of_user from security where "
                    + "username='" + request.getParameter("username") + "' "
                    + "and password='" + request.getParameter("password") + "'";
            ResultSet rs = db.runCode(query);
            if (rs.next()) {
                String username = rs.getString("username");
                String type_of_user = rs.getString("type_of_user");
                Cookie[] c = new Cookie[2];
                c[0] = new Cookie("username", username);
                c[1] = new Cookie("type_of_user", type_of_user);
                for (int i = 0; i < c.length; i++) {
                    response.addCookie(c[i]);
                }

                HttpSession session = request.getSession(true);
                session.setAttribute("username", username);
                session.setAttribute("type_of_user", type_of_user);

                rs = Account.getDetailsForSession(username);
                rsmd = rs.getMetaData();
                if (rs.next()) {
                    for (int i = 1; i < rsmd.getColumnCount(); i++) {
                        session.setAttribute(rsmd.getColumnLabel(i), rs.getString(i));
                        System.out.println(rsmd.getColumnLabel(i)+" "+rs.getString(i));
                    }
                }

            }
        } catch (Exception e) { }
        finally {

        }
    }

     public static String checkForCookie(HttpServletRequest request)
    {
        Cookie[] cookies = request.getCookies();
        String username="";

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    username = cookie.getValue();
                    return username;
                }
            }
        }
         return null;
     }
     public static void temporaryStoreForVerification(HttpServletRequest request)
    {
         HttpSession session=request.getSession(true);
         String email=request.getParameter("email");
         String reason=request.getParameter("reason");
         String next=request.getParameter("next");

         session.setAttribute("veri_email", email);
         session.setAttribute("veri_reason", reason);
         session.setAttribute("veri_next", next);

     }

}
