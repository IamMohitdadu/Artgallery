<!--
* File: artgalleryListener.cfc
* Author: Mohit Dadu
* Purpose: to call services(artgalleryService).
* Date: 09/28/2017
-->

<cfcomponent displayname="artgalleryListener" extends="MachII.framework.Listener" hint="artgalleryListener">

    <!--- Configuration function --->
    <cffunction name="configure" access="public" output="false" returntype="void" hint="configure this listener as the part of the MachII framework" >
        <cfset VARIABLES.artgalleryService = getProperty("serviceFactory").GETBEAN("artgalleryService") />
    </cffunction>

    <!---
        Login function
    --->
    <cffunction name="Login" access="public" output="true" returntype="void"
        hint="Validates a login attempt and announces a success or failure event">
        <cfargument name="event" type="MachII.framework.Event" required="true" />
        <cfset ARGUMENTS.event.setArg("login_error", "")/>

        <!--- check for available login session details --->
        <cfif structKeyExists(SESSION, 'user') >
            <cfset announceEvent('gallery') />
        </cfif>

        <!--- Call artgallery service for login validation --->
        <cfset LOCAL.validate = VARIABLES.artgalleryService.UserLogin(
                ARGUMENTS.event.getArg("Email"),
                ARGUMENTS.event.getArg("Password")
                ) />

        <!--- Check for validate user --->
        <cfif LOCAL.validate.success EQ true>
            <cfset exitEvent = "pass" />
            <cfset event.setArg("UserId", LOCAL.validate.data.UserId) />
        <cfelse>
            <cfset exitEvent = "fail" />
        </cfif>

        <cfset event.setArg("success", LOCAL.validate.success) />
        <cfset event.setArg("data", LOCAL.validate.data) />
        <cfset announceEvent(exitEvent, event) />
        <!--- <cfset redirectEvent(exitEvent, "",true) /> --->

    </cffunction>

    <!---
        Registration function
    --->
    <cffunction name="Registration" access="public" output="false" returntype="boolean"
        hint="Registration of new user">
        <cfargument name="event" type="MachII.framework.Event" required="true" />
        <cfset ARGUMENTS.event.setArg("register_error", "") />
        <cfset ARGUMENTS.Contact = ARGUMENTS.event.getArg("Contact") />

        <cfif Not isNumeric(ARGUMENTS.Contact)>
            <cfset ARGUMENTS.Contact = 0 />
        </cfif>

        <!--- call artgallery to register user --->
        <cfset LOCAL.registered = VARIABLES.artgalleryService.UserRegistration(
                    ARGUMENTS.event.getArg("Name"),
                    ARGUMENTS.event.getArg("Address"),
                    ARGUMENTS.Contact,
                    ARGUMENTS.event.getArg("Email"),
                    ARGUMENTS.event.getArg("Password")
                    ) />

        <!--- <cfset ARGUMENTS.event.setArg("event", "login") /> --->
<!--- <cfdump var="#event.getArgs()#"/><cfabort> --->
<!--- <cfdump var="#LOCAL.registered.data#"/><cfabort> --->

        <cfset ARGUMENTS.event.setArg("registration_success", LOCAL.registered.success) />
        <cfset ARGUMENTS.event.setArg("registration_data", LOCAL.registered.data) />
        <!--- <cfset announceEvent("fail", ARGUMENTS.event.getArgs()) /> --->
        <!--- <cfset redirectEvent("login", ARGUMENTS.event.getArgs()) /> --->

        <!--- Check for validate user --->
<!---         <cfif Local.registered EQ "true" >
            <cfset event.setArg("register_error", "Registration successful. Please login.") />
        <cfelse>
            <cfset event.setArg("register_error", "Please enter the valid data/User already exists.") />
        </cfif> --->

        <cfreturn true>
    </cffunction>

    <!---
        Logout function
    --->
    <cffunction name="Logout" access="public" output="true" returntype="void"
        hint="Logout user">

        <!--- To logout user --->
        <cfset VARIABLES.artgalleryService.LogoutUser() />
    </cffunction>

    <!---
        Get list of art of an artist
    --->
    <cffunction name="GetArt" access="public" output="false" returntype="struct" hint="get all the art of the artist">
        <cfargument name="event" type="MachII.framework.Event" required="true" />
        <cfset LOCAL.artgallery = structNew() />

        <!--- Check for user id and call artgallery service to get list of art --->
        <cfif arguments.event.isArgDefined('UserId') and ARGUMENTS.event.getArg('UserId') NEQ ''>
            <cfset LOCAL.artgallery = VARIABLES.artgalleryService.GetArtList(ARGUMENTS.event.getArg("UserId") ) />
        <cfelseif structKeyExists(SESSION, 'user') >
            <cfset LOCAL.artgallery = VARIABLES.artgalleryService.GetArtList( session.user['userId'] ) />
        </cfif>

        <cfreturn LOCAL.artgallery />
    </cffunction>

    <!---
        add art to the database of an artist
    --->
    <cffunction name="AddArt" access="public" output="false" returntype="void"
        hint="Validates a login attempt and announces a success or failure event">
        <cfargument name = "event" type="MachII.framework.Event" required="true" />
        <cfset LOCAL.artError = "" />
    <!--- <cfdump var="#ARGUMENTS.event.getArgs()#"><cfabort> --->

        <!--- call artgallery service to add new art --->
        <cfif ARGUMENTS.event.getArg("UserId") NEQ ''>
            <cfset LOCAL.addArt = VARIABLES.artgalleryService.AddArtDetails(
                    ARGUMENTS.event.getArg("UserId"),
                    ARGUMENTS.event.getArg("ImageName"),
                    ARGUMENTS.event.getArg("ImageDescription"),
                    ARGUMENTS.event.getArg("Image")
                    ) />

            <cfset event.setArg("success", LOCAL.addArt.success) />
            <cfset event.setArg("data", LOCAL.addArt.data) />

<!---             <cfif LOCAL.addArt EQ true>
                <cfset LOCAL.artError = "Image Uploaded Successfully." />
                <cfset ARGUMENTS.event.setArg('artError', LOCAL.artError) />
            <cfelse>
                <cfset LOCAL.artError = "Sorry, Image cannot be uploaded now. Please try again later." />
                <cfset ARGUMENTS.event.setArg('artError', LOCAL.artError) />
            </cfif> --->
<!---         <cfelse>
            <cfset LOCAL.artError = "Sorry, Image cannot be uploaded now. Please try again later." />
            <cfset ARGUMENTS.event.setArg('artError', LOCAL.artError) /> --->
        </cfif>

        <!--- <cfset announceEvent("imageAdded",ARGUMENTS.event.getArgs()) /> --->
        <!--- <cfreturn true> --->

    </cffunction>

    <!---
        upload and change user profile image
    --->
    <cffunction name="ChangeProfileImage" access="public" output="true" returntype="void"
        hint="change user profile image">

        <!--- Call artgallery service to change profile Image --->
        <cfset LOCAL.imageData =  VARIABLES.artgalleryService.ChangeProfileImage(
                    ARGUMENTS.event.getArg("UserId"),
                    ARGUMENTS.event.getArg("Image")) />

        <cfset ARGUMENTS.event.setArg('imageMessage', LOCAL.imageData.message)/>

    </cffunction>

    <!---
        Edit profile of the user
    --->
    <cffunction name="EditProfile" access="public" output="true" returntype="void"
        hint="Update profile information">

        <cfset ARGUMENTS.Contact = ARGUMENTS.event.getArg("Contact")/>
        <cfset ARGUMENTS.UserId = ARGUMENTS.event.getArg("UserId")/>

        <cfif Not isNumeric(ARGUMENTS.Contact)>
            <cfset ARGUMENTS.Contact = 0/>
        </cfif>
        <!--- check user id --->
        <cfif Not isNumeric(ARGUMENTS.UserId)>
            <cfset ARGUMENTS.UserId = session.user['userId']/>
        </cfif>

        <cfset LOCAL.updateProfile =  VARIABLES.artgalleryService.UpdateProfile(
                    ARGUMENTS.UserId,
                    ARGUMENTS.event.getArg("Name"),
                    ARGUMENTS.event.getArg("Address"),
                    ARGUMENTS.Contact
                    ) />

    </cffunction>

</cfcomponent>