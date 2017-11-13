<cfcomponent output="false" hint="I provide remote access to public
 functionality of this site.">
     <cffunction name="GetShabbatSunsetFromZipCode" access="remote"
     displayname="" returntype="struct" returnformat="json" output="false"
     hint="I return the Shabbat-adjusted sunset information for the
     given zip code and date.">
     <!--- Define arguments. --->
         <cfargument name="ZipCode" type="string" required="true" hint="The zip code for which we get the sunset.">
         <cfargument name="Date" type="date" required="true" hint="The date on which we are getting the sunset.">
         <!--- Define the local scope. --->
         <cfset var LOCAL = {}>
         <!--- Create a return struct. --->
         <cfset LOCAL.Return = APPLICATION.Service.GetShabbatSunsetFromZipCode(ARGUMENTS.ZipCode, ARGUMENTS.Date)>
         <!--- Echo back the zip code. --->
         <cfset LOCAL.Return.ZipCode = ARGUMENTS.ZipCode>
         <!---
         Check to see if the internal method call worked properly
         (as this call might hit a web service, it might fail).
         If it was a failure, add the appropriate error message.
         --->
         <cfif LOCAL.Return.Success>
            <!--- Copy sunset time. --->
            <cfset LOCAL.Return.Error = "">
         <cfelse>
            <!--- Set the error message. --->
            <cfset LOCAL.Return.Error = "Sunset time could not be determined. Try a different zip code.">
         </cfif>
         <!--- Return out. --->
         <cfreturn LOCAL.Return>
     </cffunction>
</cfcomponent>