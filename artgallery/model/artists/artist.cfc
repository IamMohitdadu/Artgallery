<!--
* File: artist .cfc
* Author: Mohit Dadu
* Purpose: Set & get variables and validate details.
* Date: 09/26/2017
-->


<cfcomponent displayname="artist" output="false">
    <cfproperty name="USERID" type="numeric" default=0 />
    <cfproperty name="NAME" type="string" default="" />
    <cfproperty name="ADDRESS" type="string" default="" />
    <cfproperty name="CONTACT" type="numeric" default=0 />
    <cfproperty name="EMAIL" type="string" default="" />
    <cfproperty name="PASSWORD" type="string" default="" />

    <!---
    PROPERTIES
    --->
    <cfset variables.instance = StructNew() />

    <!---
    INITIALIZATION / CONFIGURATION
    --->
    <cffunction name="init" access="public" returntype="model.artists.artist" output="false">
        <cfargument name="USERID" type="numeric" required="false" default=0 />
        <cfargument name="NAME" type="string" required="false" default="" />
        <cfargument name="ADDRESS" type="string" required="false" default="" />
        <cfargument name="CONTACT" type="numeric" required="false" default=0 />
        <cfargument name="EMAIL" type="string" required="false" default="" />
        <cfargument name="PASSWORD" type="string" required="false" default="" />

        <!--- run setters --->
        <cfset setUSERID(arguments.USERID) />
        <cfset setNAME(arguments.NAME) />
        <cfset setADDRESS(arguments.ADDRESS) />
        <cfset setEMAIL(arguments.EMAIL) />
        <cfset setCONTACT(arguments.CONTACT) />
        <cfset setPASSWORD(arguments.PASSWORD) />
        <cfreturn this />
    </cffunction>

    <!---
    PUBLIC FUNCTIONS
    --->
    <cffunction name="setMemento" access="public" returntype="model.artists.artist" output="false">
        <cfargument name="memento" type="struct" required="yes"/>
        <cfset variables.instance = arguments.memento />
        <cfreturn this />
    </cffunction>
    <cffunction name="getMemento" access="public" returntype="struct" output="false" >
        <cfreturn variables.instance />
    </cffunction>

    <!---
        validate login data
    --->
    <cffunction name="ValidateLogin" access="public" returntype="array" output="false">
        <cfset var errors = arrayNew(1) />
        <cfset var thisError = structNew() />

        <!--- EMAIL --->
        <cfif (len(trim(getEMAIL())) AND NOT IsSimpleValue(trim(getEMAIL())))>
            <cfset thisError.field = "EMAIL" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "EMAIL is not a string" />
            <cfset arrayAppend(errors,thisError.message) />
        </cfif>
        <cfif (len(trim(getEMAIL())) GT 50)>
            <cfset thisError.field = "EMAIL" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "EMAIL is too long" />
            <cfset arrayAppend(errors,thisError.message) />
        </cfif>
        <cfif (len(trim(getEMAIL())) EQ 0)>
            <cfset thisError.field = "EMAIL" />
            <cfset thisError.type = "tooShort" />
            <cfset thisError.message = "EMAIL cannot be blank." />
            <cfset arrayAppend(errors,thisError.message) />
        </cfif>

        <!--- PASSWORD --->
        <cfif (len(trim(getPASSWORD())) AND NOT IsSimpleValue(trim(getPASSWORD())))>
            <cfset thisError.field = "PASSWORD" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "PASSWORD is not a string" />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>
        <cfif (len(trim(getPASSWORD())) LT 8)>
            <cfset thisError.field = "PASSWORD" />
            <cfset thisError.type = "tooShort" />
            <cfset thisError.message = "PASSWORD is too Short" />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>

        <cfreturn errors />
    </cffunction>

    <!---
        validate registration data
    --->
    <cffunction name="ValidateRegistration" access="public" returntype="array" output="false">
        <cfset var errors = arrayNew(1) />
        <cfset var thisError = structNew() />

        <!--- NAME --->
        <cfif len(trim(getNAME())) EQ 0>
            <cfset thisError.field = "NAME" />
            <cfset thisError.type = "tooShort" />
            <cfset thisError.message = "NAME is too short" />
            <cfset arrayAppend(errors,thisError.message ) />
            <!--- <cfset arrayAppend(errors,duplicate(thisError)) /> --->
        </cfif>
        <cfif (len(trim(getNAME())) GT 20)>
            <cfset thisError.field = "NAME" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "NAME is too long" />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>

        <!--- ADDRESS --->
        <cfif len(trim(getADDRESS())) EQ 0>
            <cfset thisError.field = "ADDRESS" />
            <cfset thisError.type = "tooShort" />
            <cfset thisError.message = "ADDRESS is too short" />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>
        <cfif (len(trim(getADDRESS())) GT 50)>
            <cfset thisError.field = "ADDRESS" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "ADDRESS is too long" />
            <cfset arrayAppend(errors,thisError.message ) />
            <!--- <cfset arrayAppend(errors,duplicate(thisError)) /> --->
        </cfif>

        <!--- EMAIL --->
        <cfif (len(trim(getEMAIL())) AND NOT IsSimpleValue(trim(getEMAIL())))>
            <cfset thisError.field = "EMAIL" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "EMAIL is not a string" />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>
        <cfif (len(trim(getEMAIL())) GT 50)>
            <cfset thisError.field = "EMAIL" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "EMAIL is too long" />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>

        <!--- CONTACT --->
        <cfif len(trim(getCONTACT())) NEQ 10>
            <cfset thisError.field = "CONTACT" />
            <cfset thisError.type = "invalid length" />
            <cfset thisError.message = "CONTACT must be of 10 digits." />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>

        <!--- PASSWORD --->
        <cfif (len(trim(getPASSWORD())) AND NOT IsSimpleValue(trim(getPASSWORD())))>
            <cfset thisError.field = "PASSWORD" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "PASSWORD is not a string" />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>
        <cfif (len(trim(getPASSWORD())) LT 8)>
            <cfset thisError.field = "PASSWORD" />
            <cfset thisError.type = "tooShort" />
            <cfset thisError.message = "PASSWORD is too short" />
            <cfset arrayAppend(errors,thisError.message ) />
        </cfif>

        <cfreturn errors />
    </cffunction>

    <!---
        To upload image file
    --->
    <cffunction name="UploadImage" access="public" output="false" returnType="struct" hint="check image format" >
        <cfargument name="Image" type="string" required="false" />

        <cfset LOCAL.uploadFolder = expandPath("./assets/images/gallery") />
        <cfset LOCAL.finalData = structNew() />

        <cfif DirectoryExists(LOCAL.uploadFolder) >
            <cfif structKeyExists(ARGUMENTS, 'Image')>
                <cftry>
                    <cffile
                        action="upload"
                        filefield="Image"
                        destination="#LOCAL.uploadFolder#"
                        nameconflict="overwrite"
                        accept="image/jpeg,image/png"
                        result="fileUploadResult" />

                        <cfset LOCAL.finalData.error = false />
                        <cfset LOCAL.finalData.imageAddress = "./assets/images/artists/" & #fileUploadResult.SERVERFILE# />

                    <cfcatch>
                        <cfset LOCAL.finalData.error = true />
                        <cfset LOCAL.finalData.message = #cfcatch.message# />
                        <cfreturn LOCAL.finalData />
                    </cfcatch>
                </cftry>

            <cfelse>
                <cfset LOCAL.finalData.error = true />
                <cfset LOCAL.finalData.message = "Please choose the Art from the directory." />
            </cfif>
        <cfelse>
            <cfset LOCAL.finalData.error = true />
            <cfset LOCAL.finalData.message = "Directory does not exist." />
        </cfif>

        <cfreturn LOCAL.finalData />

    </cffunction>


    <!---
        validate update Profile data
    --->
    <cffunction name="ValidateProfileDetails" access="public" returntype="array" output="false">
        <cfset var errors = arrayNew(1) />
        <cfset var thisError = structNew() />

        <!--- NAME --->
        <cfif (len(trim(getNAME())) AND NOT IsSimpleValue(trim(getNAME())))>
            <cfset thisError.field = "NAME" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "NAME is not a string" />
            <cfset arrayAppend(errors,duplicate(thisError)) />
        </cfif>
        <cfif (len(trim(getNAME())) GT 20)>
            <cfset thisError.field = "NAME" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "NAME is too long" />
            <cfset arrayAppend(errors,duplicate(thisError)) />
        </cfif>

        <!--- ADDRESS --->
        <cfif (len(trim(getADDRESS())) AND NOT IsSimpleValue(trim(getADDRESS())))>
            <cfset thisError.field = "ADDRESS" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "ADDRESS is not a string" />
            <cfset arrayAppend(errors,duplicate(thisError)) />
        </cfif>
        <cfif (len(trim(getADDRESS())) GT 50)>
            <cfset thisError.field = "ADDRESS" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "ADDRESS is too long" />
            <cfset arrayAppend(errors,duplicate(thisError)) />
        </cfif>

        <!--- CONTACT --->
        <cfif (len(trim(getCONTACT())) AND NOT IsSimpleValue(trim(getCONTACT())))>
            <cfset thisError.field = "CONTACT" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "CONTACT is not numeric" />
            <cfset arrayAppend(errors,duplicate(thisError)) />
        </cfif>
        <cfif (len(trim(getCONTACT())) GT 20)>
            <cfset thisError.field = "CONTACT" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "CONTACT is too long" />
            <cfset arrayAppend(errors,duplicate(thisError)) />
        </cfif>

        <cfreturn errors />
    </cffunction>


    <!---
    ACCESSORS
    --->
    <cffunction name="setUSERID" access="public" returntype="void" output="false">
        <cfargument name="USERID" type="string" required="true" />
        <cfset variables.instance.USERID = arguments.USERID />
    </cffunction>
    <cffunction name="getUSERID" access="public" returntype="string" output="false">
        <cfreturn variables.instance.USERID />
    </cffunction>

    <cffunction name="setNAME" access="public" returntype="void" output="false">
        <cfargument name="NAME" type="string" required="true" />
        <cfset variables.instance.NAME = arguments.NAME />
    </cffunction>
    <cffunction name="getNAME" access="public" returntype="string" output="false">
        <cfreturn variables.instance.NAME />
    </cffunction>

    <cffunction name="setADDRESS" access="public" returntype="void" output="false">
        <cfargument name="ADDRESS" type="string" required="true" />
        <cfset variables.instance.ADDRESS = arguments.ADDRESS />
    </cffunction>
    <cffunction name="getADDRESS" access="public" returntype="string" output="false">
        <cfreturn variables.instance.ADDRESS />
    </cffunction>

    <cffunction name="setEMAIL" access="public" returntype="void" output="false">
        <cfargument name="EMAIL" type="string" required="true" />
        <cfset variables.instance.EMAIL = arguments.EMAIL />
    </cffunction>
    <cffunction name="getEMAIL" access="public" returntype="string" output="false">
        <cfreturn variables.instance.EMAIL />
    </cffunction>

    <cffunction name="setCONTACT" access="public" returntype="void" output="false">
        <cfargument name="CONTACT" type="numeric" required="true" />
        <cfset variables.instance.CONTACT = arguments.CONTACT />
    </cffunction>
    <cffunction name="getCONTACT" access="public" returntype="numeric" output="false">
        <cfreturn variables.instance.CONTACT />
    </cffunction>

    <cffunction name="setPASSWORD" access="public" returntype="void" output="false">
        <cfargument name="PASSWORD" type="string" required="true" />
        <cfset variables.instance.PASSWORD = arguments.PASSWORD />
    </cffunction>
    <cffunction name="getPASSWORD" access="public" returntype="string" output="false">
        <cfreturn variables.instance.PASSWORD />
    </cffunction>

    <cffunction name="setIMAGE" access="public" returntype="void" output="false">
        <cfargument name="IMAGE" type="string" required="true" />
        <cfset variables.instance.IMAGE = arguments.IMAGE />
    </cffunction>
    <cffunction name="getIMAGE" access="public" returntype="string" output="false">
        <cfreturn variables.instance.IMAGE />
    </cffunction>

</cfcomponent>
