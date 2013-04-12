<%-- 
    Document   : admin_auto_debit
    Created on : Nov 27, 2011, 1:49:38 AM
    Author     : Rahul
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>auto debit</title>
    </head>
    <body>
          <form name="auto_debit" action="auto_debit.jsp" method="POST">
            from:
            <label for="account_no">account number</label>
            <input type="text" name="account_no" >

             <label for="username">user name</label>
            <input type="text" name="username" ><br/>
            to:
            <label for="account_no">account number</label>
            <input type="text" name="account_no" >

             <label for="username">user name</label>
            <input type="text" name="username" ><br/>

            <label for="amt_per_ins">amount per installment</label>
            <input type="text" name="amt_per_ins" ><br/>

             <label for="pay_date">pay on what day of the month</label>
            <input type="text" name="pay_date" ><br/>

            start date:<label for="day">day</label>
            <input type="text" name="day" >
            <select>
                <option>1
                <option>2
                <option>3
                 <option>4
                <option>  5
                <option>6
                <option>7
                <option>8
                <option>9
                <option>10
                <option>11
                <option>12
                <option>13
                <option>14
                <option>15
                <option>16
                <option>17
                <option>18
                <option>19
                <option>20
                <option>21
                <option>22
                <option>23
                <option>24
                <option>25
                <option>26
                <option>27
                <option>28
                <option>29
                <option>30
                <option>31
            </select>

             <label for="month">month</label>
            <input type="text" name="month" >
            <select>
                <option>january
                <option>february
                <option>march
                 <option>april
                <option>may
                <option>june
                <option>july
                <option>august
                <option>september
                <option>october
                <option>november
                <option>december
            </select>

              <label for="year">year</label>
            <input type="text" name="year" >
            <select>
                <option>2011
                <option>2012
                <option>2013
                <option>2014
                <option>2015
                <option>2016
                <option>2017
                <option>2018
                <option>2019
                <option>2020
                <option>2021
                <option>2022
            </select> <br/>


                end date:<label for="day">day</label>
            <input type="text" name="day" >
            <select>
                <option>1
                <option>2
                <option>3
                 <option>4
                <option>  5
                <option>6
                <option>7
                <option>8
                <option>9
                <option>10
                <option>11
                <option>12
                <option>13
                <option>14
                <option>15
                <option>16
                <option>17
                <option>18
                <option>19
                <option>20
                <option>21
                <option>22
                <option>23
                <option>24
                <option>25
                <option>26
                <option>27
                <option>28
                <option>29
                <option>30
                <option>31
            </select>

             <label for="month">month</label>
            <input type="text" name="month" >
            <select>
                <option>january
                <option>february
                <option>march
                 <option>april
                <option>may
                <option>june
                <option>july
                <option>august
                <option>september
                <option>october
                <option>november
                <option>december
            </select>

              <label for="year">year</label>
            <input type="text" name="year" >
            <select>
                <option>2011
                <option>2012
                <option>2013
                <option>2014
                <option>2015
                <option>2016
                <option>2017
                <option>2018
                <option>2019
                <option>2020
                <option>2021
                <option>2022
            </select><br/>
         <label for="installments">no of installments</label>
         <input type="text" name="year" >

         <p>note:if your balance is found to be low for the auto debit,it is
             intimated in advance and the auto debit is turned off.thanq you.
             have a nice day!!!</p>

         <input type="submit" value="ok,add the autodebit" >
         <input type="reset" value="cancel">
         </form>

    </body>
</html>
