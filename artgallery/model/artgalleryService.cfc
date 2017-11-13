<!--
* File: artgalleryService.cfc
* Author: Mohit Dadu
* Purpose: service functions to call Validation/models files.
* Date: 09/26/2017
-->

<cfcomponent output="false">

    <!--- constructor - init --->
    <cffunction name="init" access="public" output="false" returntype="model.artgalleryService">
        <cfset VARIABLES.artDAO = 0 />
        <cfset VARIABLES.artGateway = 0 />
        <cfset VARIABLES.artistGateway = 0 />
        <cfset VARIABLES.artist = 0 />
        <cfset VARIABLES.art = 0 />

        <cfreturn this />
    </cffunction>

    <cffunction name="setartDAO" returntype="void" output="false" hint="injected service">
        <cfargument name="artDAO" type="any" required="yes" />
        <cfset VARIABLES.artDAO = arguments.artDAO />
    </cffunction>

    <cffunction name="setartGateway" returntype="void" output="false" hint="injected service">
        <cfargument name="artGateway" type="any" required="yes" />
        <cfset VARIABLES.artGateway = arguments.artGateway />
    </cffunction>

    <cffunction name="setartistGateway" returntype="void" output="false" hint="injected service">
        <cfargument name="artistGateway" type="any" required="yes" />
        <cfset VARIABLES.artistGateway = arguments.artistGateway />
    </cffunction>

    <cffunction name="setartist" returntype="void" output="false" hint="injected service">
        <cfargument name="artist" type="any" required="yes" />
        <cfset VARIABLES.artist = arguments.artist />
    </cffunction>

    <cffunction name="setart" returntype="void" output="false" hint="injected service">
        <cfargument name="art" type="any" required="yes" />
        <cfset VARIABLES.art = arguments.art />
    </cffunction>

    <!---
        Validate Login
    --->
    <cffunction name="UserLogin" access="public" output="false" returntype="any" hint="to validate user details">
        <cfargument name="Email" type="string" required="false" />
        <cfargument name="Password" type="string" required="false" />
        <cfset LOCAL.validate = arrayNew(1) />
        <cfset LOCAL.validUser = structNew() />

        <!--- Call init function to initialize VARIABLES --->
        <cfset LOCAL.artist = VARIABLES.artist.init(argumentCollection=arguments) />
        <!--- validate user login details --->
        <cfset LOCAL.validate = LOCAL.artist.validateLogin() />

        <!--- Check user into database for login if no error --->
        <cfif arrayIsEmpty(LOCAL.validate) >
            <!--- validate user details into database --->
            <cfset LOCAL.validUser = VARIABLES.artistGateway.CheckUser(argumentCollection=arguments) />

            <cfif LOCAL.validUser.success EQ true>
                <!--- Set SESSION for valid user --->
                <cfset SESSION.user['USERID'] = LOCAL.validUser.data.USERID />
                <cfset SESSION.user['NAME'] = LOCAL.validUser.data.NAME />
                <cfset SESSION.user['EMAIL'] = LOCAL.validUser.data.EMAIL />
                <cfset SESSION.user['IMAGEADDRESS'] = LOCAL.validUser.data.IMAGEADDRESS />
            </cfif>

        <cfelse>
            <!--- Set error message structure --->
            <cfset LOCAL.ValidUser.data = arrayNew(3) />
            <cfset LOCAL.validUser.success = false />
            <cfset LOCAL.ValidUser.data = #LOCAL.Validate# />
        </cfif>

        <cfreturn LOCAL.ValidUser />
    </cffunction>

    <!---
        User Registration
    --->
    <cffunction name="UserRegistration" access="public" output="false" returntype="struct" hint="to validate user details">
        <cfargument name="Name" type="string" required="false" />
        <cfargument name="Address" type="string" required="false" />
        <cfargument name="Contact" type="numeric" required="false"  default=0 />
        <cfargument name="Email" type="string" required="false" />
        <cfargument name="Password" type="string" required="false" />
        <cfset LOCAL.validUser = structNew() />
        <cfset LOCAL.validate = arrayNew(1) />

        <!--- initialize VARIABLES --->
        <cfset LOCAL.artist = VARIABLES.artist.init(argumentCollection=arguments) />
        <!--- validate user registration details--->
        <cfset LOCAL.validate = LOCAL.artist.validateRegistration() />

        <!--- add user data into database --->
        <cfif arrayIsEmpty(LOCAL.validate) >
            <cfset LOCAL.ValidUser = VARIABLES.artistGateway.RegisterUser(argumentCollection=arguments) />
        <cfelse>
            <cfset LOCAL.ValidUser.data = arrayNew(3) />
            <cfset LOCAL.validUser.success = false />
            <cfset LOCAL.ValidUser.data = #LOCAL.Validate# />
        </cfif>

        <cfreturn LOCAL.ValidUser />
    </cffunction>

    <!---
        To get list of art of a artist
    --->
    <cffunction name="GetArtList" access="public" output="false" returntype="struct">
        <cfargument name="USERID" type="string" required="false" />
        <cfset LOCAL.artgallery = structNew() />

        <!--- get artist details from database --->
        <cfset LOCAL.artgallery.artist = VARIABLES.artistGateway.GetArtistDetails(argumentCollection=arguments) />
        <!--- get art details from database of an artist--->
        <cfset LOCAL.artgallery.art = VARIABLES.artGateway.GetArtList(argumentCollection=arguments) />

        <cfreturn artgallery />
    </cffunction>

    <!---
        To get Profile details
    --->
    <cffunction name="ProfileDetails" access="public" output="false" returntype="struct">
        <cfargument name="USERID" type="string" required="false" />
        <cfset LOCAL.artgallery = structNew() />

        <!--- get artist details from database --->
        <cfset LOCAL.artgallery.artist = VARIABLES.artistGateway.GetArtistDetails(argumentCollection=arguments) />
        <!--- get art details from database of an artist--->
        <cfset LOCAL.artgallery.art = VARIABLES.artGateway.AllArtList(argumentCollection=arguments) />

        <cfreturn artgallery />
    </cffunction>

    <!---
        To add art into database
    --->
    <cffunction name="AddArtDetails" access="public" output="false" returntype="any">
        <cfargument name="USERID" type="numeric" required="false" />
        <cfargument name="IMAGENAME" type="string" required="false" />
        <cfargument name="IMAGEDESCRIPTION" type="string" required="false" />
        <cfargument name="IMAGE" type="string" required="false" />
        <cfset LOCAL.validImage = structNew() />
        <cfset LOCAL.validate = arrayNew(1) />

        <!--- initialize --->
        <cfset LOCAL.art = VARIABLES.art.init(arguments.USERID, arguments.IMAGENAME, arguments.IMAGEDESCRIPTION) />
        <!--- validate art details --->
        <cfset LOCAL.validate = LOCAL.art.ValidateArtDetails() />

        <!--- Check valid art details --->
        <cfif arrayIsEmpty(LOCAL.validate) >
            <!--- check image format --->
            <cfset LOCAL.validImage = VARIABLES.art.UploadImage(ARGUMENTS.IMAGE) />

            <!--- Add image into database --->
            <cfif LOCAL.validImage.success EQ true>
                <cfset LOCAL.ValidImage = VARIABLES.artDAO.AddImage(ARGUMENTS.USERID, ARGUMENTS.IMAGENAME, ARGUMENTS.IMAGEDESCRIPTION, LOCAL.validImage.imageAddress) />
            </cfif>

        <cfelse>
            <!--- set error structure --->
            <cfset LOCAL.ValidImage.data = arrayNew(3) />
            <cfset LOCAL.validImage.success = false />
            <cfset LOCAL.ValidImage.data = #LOCAL.Validate# />
        </cfif>

        <cfreturn LOCAL.ValidImage />
    </cffunction>

    <!---
        to logout user
    --->
    <cffunction name="LogoutUser" access="public" output="false" returnType="void" hint="logout the artist">

        <!--- Delete SESSION VARIABLES --->
        <cfif structKeyExists(SESSION,'user')>
            <cfset structDelete(SESSION,'user') />
        </cfif>

    </cffunction>

    <!---
        Change User profile Picture
    --->
    <cffunction name="ChangeProfileImage" access="public" output="false" returnType="struct" hint="change user profile Picture">
        <cfargument name="USERID" type="numeric" required="false" />
        <cfargument name="IMAGE" type="string" required="false" />

        <!--- check image format --->
        <cfset LOCAL.validImage = VARIABLES.artist.UploadImage(ARGUMENTS.IMAGE) />

        <!--- update profile image into database --->
        <cfif LOCAL.validImage.error EQ false>
            <cfset LOCAL.imageAdded = VARIABLES.artistGateway.ProfileImage(ARGUMENTS.USERID, LOCAL.validImage.imageAddress) />
            <cfif LOCAL.imageAdded EQ true>
                <cfset LOCAL.validImage.error = false />
                <cfset LOCAL.validImage.message = "image updated successfully" />
            <cfelse>
                <cfset LOCAL.validImage.error = true />
                <cfset LOCAL.validImage.message = "Image is not updated please try again." />
            </cfif>
        </cfif>

        <cfreturn LOCAL.validImage />
    </cffunction>

    <!---
        Update profile information
    --->
    <cffunction name="UpdateProfile" access="public" output="false" returnType="any" hint="update profile details">
        <cfargument name="USERID" type="numeric" required="false" />
        <cfargument name="NAME" type="string" required="false" />
        <cfargument name="ADDRESS" type="string" required="false" />
        <cfargument name="CONTACT" type="numeric" required="false" />
        <cfargument name="COMMENT" type="string" required="false" />

        <!---Validate profile details --->
        <cfset LOCAL.artist = VARIABLES.artist.init(argumentCollection=arguments) />
        <cfset LOCAL.validateProfile = VARIABLES.artist.ValidateProfileDetails() />

        <!--- update user details into database --->
        <cfif arrayIsEmpty(LOCAL.validateProfile) >
            <cfset LOCAL.profileUpdated = VARIABLES.artistGateway.UpdateUser(argumentCollection=arguments) />

            <!--- check for successfully update profile --->
            <cfif LOCAL.profileUpdated EQ true>
                <cfset SESSION.user['NAME'] = ARGUMENTS.NAME />
                <cfreturn true />
            </cfif>

        </cfif>

        <cfreturn false />
    </cffunction>

    <!--- To update art status --->
    <cffunction name="UpdateArtStatus" access="remote" output="false" returntype="any" hint="update art status">
        <cfargument name="artId" type="numeric" required="true">

        <cfif ARGUMENTS.artId NEQ 0 >
            <!--- update art active status --->
            <cfset LOCAL.updated = VARIABLES.artGateway.UpdateArtStatus(argumentCollection=arguments) />
            <cfreturn LOCAL.updated>
        </cfif>

        <cfreturn false>
    </cffunction>

</cfcomponent>