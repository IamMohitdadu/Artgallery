<!---
* File: 404.cfm
* Author: Mohit Dadu
* Purpose: To display 404:page not found error.
* Date: 09/26/2017
--->

<cfoutput>
    The page #Replace(CGI.script_name, "/", "")# is not available.<br>
    Make sure that you entered the page correctly.<br>
    <a href="index.cfm?event=home">click here</a> to go back.
</cfoutput>