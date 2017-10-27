<!---
* File: Application.cfc
* Author: Mohit Dadu
* Date: 09/25/2017
--->

<cfcomponent name="Application.cfc" extends="mach-ii" output="false">

    <!---
        PROPERTIES - APPLICATION SPECIFIC
    --->
    <cfset THIS.name="artgallery">
    <cfset THIS.applicationTimeout = CreateTimeSpan( 0, 0, 10, 0 ) />
    <cfset THIS.sessionManagement = true />
    <cfset THIS.sessionTimeout = CreateTimeSpan( 0, 0, 10, 0 ) />
    <cfset THIS.clientManagement = true />
    <cfset THIS.clientStorage = "artgallery"/>
    <cfset THIS.setClientCookies = true />

    <!---
        POSSIBLE USES:
        Test database connection
        Test mail server
        Set application variables (do not have to lock code)
        Log the start of the application
    --->
    <cffunction name="onApplicationStart">
        <!--- If you get a database error, report an error to the user, log the
        error information, and do not start the application. --->
        <cfset application.datasource = "artgallery">
        <cfset application.sessions = structNew()>

        <cfreturn true>
    </cffunction>

    <!---
        POSSIBLE USES:
        Log the end of the application
    --->
    <cffunction name="onApplicationEnd">
        <cfargument name="applicationScope" required="true">
        <cflog file="#this.name#" text="Application timed out.">

    </cffunction>

    <!---
        POSSIBLE USES:
        Authentication code
        Output header
    --->
    <cffunction name="onRequestStart">
        <!---  --->
    </cffunction>

    <!---
        POSSIBLE USES:
    --->
    <cffunction name="onRequest">
        <cfargument name="targetPage" type="string" required="true"/>
        <cfinclude template="#Arguments.targetPage#" />

    </cffunction>

    <!---
        POSSIBLE USES:
        Output footer
    --->
    <cffunction name="onRequestEnd">
        <!---  --->
    </cffunction>

    <!---
        POSSIBLE USES:
        Set session variables
        Log the start of the session
    --->
    <cffunction name="onSessionStart" access="public" returntype="void" output="false">
        <cfset application.sessions[session.urltoken] = 1>
    </cffunction>

    <!---
        POSSIBLE USES:
        Log the end of the session
    --->
    <cffunction name="onSessionEnd" access="public" returntype="void" output="false">
        <!---  --->
    </cffunction>

    <!---
        POSSIBLE USES:
        Log errors
        Display error
        Email site administrator
    --->
    <cffunction name="onError">
        <cfargument name="Exception" required=true/>
        <cfargument type="String" name="EventName" required=true/>

        <!--- Log all errors. --->
        <cflog file="#This.Name#" type="error"
                text="Event Name: #Arguments.Eventname#" >
        <cflog file="#This.Name#" type="error"
                text="Message: #Arguments.Exception.message#">
        <cflog file="#This.Name#" type="error"
            text="Root Cause Message: #Arguments.Exception.rootcause.message#">

        <cfif arguments.exception.rootCause eq "coldfusion.runtime.AbortException">
            <cfreturn/>
        </cfif>

        <cfoutput>
           <h4>Error has occured due to server or wrong user request.
            Make sure that the requested page/data is spelled or entered correctly.<br>
            <a href="index.cfm?event=home ">click here</a> to go back.</h4>
        </cfoutput>

    </cffunction>

</cfcomponent>