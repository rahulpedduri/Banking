//
//
//PLACE THIS CODE ON ALL THE PAGES. SO THAT IF ANYTHING GOES WRONG, ERRORS CAN BE EASILY NOTIFIED.
//DEPENDING ON THE LOCATION ON THE PAGE WHERE YOU WANT TO DISPLAY THE ERROR, PLACE THIS CODE THERE.
//AND ONE MORE THING, CSS HAS TO BE DEFINED FOR CLASSES 'ERROR','USER_ERR','PROG_ERR','ANY_ERR'
//
//




        <%
            String error=request.getParameter("err");
            if(error!=null){
            if(error.equalsIgnoreCase("user"))
                {
                %>
                <div class="error user_err">Incorrect Details!</div>
                <%
                }
            else if(error.equalsIgnoreCase("prog"))
                {
                %>
                <div class="error prog_err">Oops something went wrong! Try Again</div>
                <%
                }
            else if(error.equalsIgnoreCase("any"))
                {
                %>
                <div class="error any_err">either the details provided are wrong or something went wrong!
                    Try again if the details you provided are correct</div>
                <%
                }
            }
            String success=request.getParameter("success");
            if(success!=null){
                if(success.equalsIgnoreCase("true")){
                %>
               <div class="result success">successful</div>
                <%
                   }
                else {
                %>
                <div class="result success">failed</div>
                <%
                }
            }

        %>
        
 