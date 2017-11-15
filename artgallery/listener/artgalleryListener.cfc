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
    <cffunction name="Login" access="public" output="false" returntype="void"
        hint="Validates a login attempt and announces a success or failure event">
        <cfargument name="event" type="MachII.framework.Event" required="true" />
        <cfset response_error = arrayNew(1)/>

<!---         <cfset st['a']= "hi"/>
        <cfset st['b'] = "hello"/>
        <cfset event.setArg('st', st['b'])/>
        <cfset redirectEvent("login","",true, st['a'])/><cfexit>
 --->
        <!--- check for available login session details --->
        <cfif structKeyExists(SESSION, 'user') >
            <cfset redirectEvent('gallery', event) />
        </cfif>

        <!--- redirect to login page if captcha is not available --->
        <cfif event.getArg('g-recaptcha-response') EQ ''>
            <cfset redirectEvent("login")/>
            <cfexit>
        </cfif>

        <cftry>
            <!--- For captcha validation after form data validate --->
            <cfset recaptcha = event.getArg('g-recaptcha-response') >

            <!--- check for captcha submittion --->
            <cfif len(recaptcha)>
                <cfset googleUrl = "https://www.google.com/recaptcha/api/siteverify">
                <cfset secret = "6LdyWTcUAAAAABxbtHuGCOrYqbvG0ZJokpxZ19Zx">
                <cfset ipaddr = CGI.REMOTE_ADDR>
                <cfset request_url = googleUrl & "?secret=" & secret & "&response=" & recaptcha & "&remoteip" & ipaddr>

                <cfhttp url="#request_url#" method="get" timeout="10">
                <cfset response = deserializeJSON(cfhttp.filecontent)>

                <cfif response.success EQ "YES">
                    <!--- Call artgallery service for login data validation --->
                    <cfset LOCAL.validate = VARIABLES.artgalleryService.UserLogin(
                            ARGUMENTS.event.getArg("Email"),
                            ARGUMENTS.event.getArg("Password")
                            ) />

                    <!--- Check for validate user --->
                    <cfif LOCAL.validate.success EQ true>
                        <cfset exitEvent = "gallery" />
                        <cfset event.setArg("UserId", LOCAL.validate.data.UserId) />
                        <cfset event.setArg("success", LOCAL.validate.success) />
                        <cfset event.setArg("data", LOCAL.validate.data) />
                        <cfset redirectEvent(exitEvent,"",false, event.getArgs()) />
                    <cfelse>
                        <cfset exitEvent = "fail" />
                        <cfset event.setArg("success", LOCAL.validate.success) />
                        <cfset event.setArg("data", LOCAL.validate.data) />
                        <cfset announceEvent(exitEvent, event.getArgs())/>
                        <cfexit>
                    </cfif>
                </cfif>
            </cfif>
            <!--- Handle Exception --->
            <cfcatch>
                <cfset arrayAppend(response_error, "Request denied, Please try again.")/>
                <cfset exitEvent = "fail" />
                <cfset event.setArg("success", "false") />
                <cfset event.setArg("data", response_error) />
                <cfset announceEvent(exitEvent, event.getArgs())/><cfexit>
            </cfcatch>
        </cftry>

        <!--- Error if login fail --->

        <cfset arrayAppend(response_error, "Please fill the complete form.")/>
        <cfset exitEvent = "fail" />
        <cfset event.setArg("success", "false") />
        <cfset event.setArg("data", response_error) />
        <cfset announceEvent(exitEvent, event.getArgs())/>

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

        <cfset ARGUMENTS.event.setArg("registration_success", LOCAL.registered.success) />
        <cfset ARGUMENTS.event.setArg("registration_data", LOCAL.registered.data) />

        <cfreturn true>
    </cffunction>

    <!---
        Logout function
    --->
    <cffunction name="Logout" access="public" output="false" returntype="void"
        hint="Logout user">

        <!--- To logout user --->
        <cfset VARIABLES.artgalleryService.LogoutUser() />
    </cffunction>

    <!---
        Get list of art of an artist
    --->
    <cffunction name="GetArts" access="public" output="false" returntype="struct" hint="get all the art of the artist">
        <cfargument name="event" type="MachII.framework.Event" required="true" />
        <cfset LOCAL.artgallery = structNew() />

        <!--- Check for user id and call artgallery service to get list of art --->
        <cfif arguments.event.isArgDefined('UserId') and ARGUMENTS.event.getArg('UserId') NEQ ''>
            <cfset LOCAL.artgallery = VARIABLES.artgalleryService.GetArtList(ARGUMENTS.event.getArg("UserId") ) />
        <cfelseif structKeyExists(SESSION, 'user') >
            <cfset event.setArg("UserId", SESSION.user['userId']) />
            <cfset LOCAL.artgallery = VARIABLES.artgalleryService.GetArtList( SESSION.user['userId'] ) />
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
        </cfif>

    </cffunction>

    <!---
        upload and change user profile image
    --->
    <cffunction name="ChangeProfileImage" access="public" output="false" returntype="void"
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
    <cffunction name="EditProfile" access="public" output="false" returntype="void"
        hint="Update profile information">
        <cfset ARGUMENTS.Contact = event.getArg("Contact")/>
        <cfset ARGUMENTS.UserId = event.getArg("UserId")/>

        <cfif Not isNumeric(ARGUMENTS.Contact)>
            <cfset ARGUMENTS.Contact = 0/>
        </cfif>
        <!--- check user id --->
        <cfif Not isNumeric(ARGUMENTS.UserId)>
            <cfset ARGUMENTS.UserId = session.user['userId']/>
        </cfif>

        <cfset LOCAL.updateProfile =  VARIABLES.artgalleryService.UpdateProfile(
                    ARGUMENTS.UserId,
                    event.getArg("Name"),
                    event.getArg("Address"),
                    ARGUMENTS.Contact,
                    event.getArg("comment")
                    ) />

    </cffunction>

    <!---
        artist profile
    --->
    <cffunction name="MyProfile" access="public" output="false" returntype="struct" hint="Profile Details">
        <cfargument name="event" type="MachII.framework.Event" required="true" />
        <cfset LOCAL.artgallery = structNew() />

        <!--- Check for user id and call artgallery service to get list of art --->
        <cfif structKeyExists(SESSION, 'user') >
            <cfset event.setArg("UserId", SESSION.user['userId']) />
            <cfset LOCAL.artgallery = VARIABLES.artgalleryService.ProfileDetails( SESSION.user['userId'] ) />
        <cfelse>
            <cfset redirectEvent('login')/>
            <cfexit>
        </cfif>

        <cfreturn LOCAL.artgallery />
    </cffunction>

    <!---
        Change Art public/private status
    --->
    <cffunction name="UpdateImageStatus" access="public" output="false" returntype="boolean"
        hint="change art public status">
        <!--- Call artgallery service to change profile Image --->
        <cfset LOCAL.imageData =  VARIABLES.artgalleryService.UpdateArtStatus(event.getArg("ImageId")) />

        <cfreturn LOCAL.imageData/>
    </cffunction>

</cfcomponent>