/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbad.db;

import javax.servlet.ServletContext;

/**
 *
 * @author Phani Rahul
 */
public class ConnectionParameters {
     private String url = null;
    private String db = null;
    private String driver = null;
    private String username = null;
    private String password = null;
    private String props = null;

    public String getProps() {
        return props;
    }

    public void setProps(String props) {
        this.props = props;
    }

  public static ConnectionParameters getConnectionParameters(ServletContext context){
      ConnectionParameters cp = new ConnectionParameters(
              context.getInitParameter("db.url"), 
              context.getInitParameter("db.database"), 
              context.getInitParameter("db.driver"),
              context.getInitParameter("db.username"),
              context.getInitParameter("db.password"), 
              context.getInitParameter("db.properties"));
     
      return cp;
  }

    private ConnectionParameters(String url, String db, String driver, String username, String password, String props) {
        this.url = url;
        this.db = db;
        this.driver = driver;
        this.username = username;
        this.password = password;
        this.props = props;
    }
    public ConnectionParameters(){
        
    }

    @Override
    public String toString() {
        return "ConnectionParameters{" + "url=" + url
                + "db=" + db + "driver=" + driver
                + "username=" + username + "password="
                + password + "props=" + props + '}';
    }

    public String getDb() {
        return db;
    }

    public void setDb(String db) {
        this.db = db;
    }

    public String getDriver() {
        return driver;
    }

    public void setDriver(String driver) {
        this.driver = driver;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
