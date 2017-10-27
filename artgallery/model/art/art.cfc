<!--
* File: art.cfc
* Author: Mohit Dadu
* Purpose: Set and get variables.
* Date: 09/26/2017
-->

<cfcomponent displayname="art" output="false">

    <cfproperty name="USERID" type="numeric" default=0 />
    <cfproperty name="IMAGENAME" type="string" default="" />
    <cfproperty name="IMAGEDESCRIPTION" type="string" default="" />
    <cfset variables.instance = StructNew() />

    <!---
    INITIALIZATION / CONFIGURATION
    --->
    <cffunction name="init" access="public" returntype="model.art.art" output="true">
        <cfargument name="USERID" type="numeric" required="false" default=0 />
        <cfargument name="IMAGENAME" type="string" required="false" default="" />
        <cfargument name="IMAGEDESCRIPTION" type="string" required="false" default="" />

        <!--- run setters --->
        <cfset setUSERID(arguments.USERID) />
        <cfset setIMAGENAME(arguments.IMAGENAME) />
        <cfset setIMAGEDESCRIPTION(arguments.IMAGEDESCRIPTION) />

        <cfreturn this />
    </cffunction>

    <cffunction name="setUSERID" access="public" returntype="void" output="false">
        <cfargument name="USERID" type="string" required="true" />
        <cfset variables.instance.USERID = arguments.USERID />
    </cffunction>
    <cffunction name="getUSERID" access="public" returntype="string" output="false">
        <cfreturn variables.instance.USERID />
    </cffunction>

    <cffunction name="setIMAGENAME" access="public" returntype="void" output="false">
        <cfargument name="IMAGENAME" type="string" required="true" />
        <cfset variables.instance.IMAGENAME = arguments.IMAGENAME />
    </cffunction>
    <cffunction name="getIMAGENAME" access="public" returntype="string" output="false">
        <cfreturn variables.instance.IMAGENAME />
    </cffunction>

    <cffunction name="setIMAGEDESCRIPTION" access="public" returntype="void" output="false">
        <cfargument name="IMAGEDESCRIPTION" type="string" required="true" />
        <cfset variables.instance.IMAGEDESCRIPTION = arguments.IMAGEDESCRIPTION />
    </cffunction>
    <cffunction name="getIMAGEDESCRIPTION" access="public" returntype="string" output="false">
        <cfreturn variables.instance.IMAGEDESCRIPTION />
    </cffunction>

    <!---
        validate Art details
    --->
    <cffunction name="ValidateArtDetails" access="public" returntype="array" output="false">
        <cfset var errors = arrayNew(1) />
        <cfset var thisError = structNew() />

        <!--- NAME --->
        <cfif (len(trim(getIMAGENAME())) AND NOT IsSimpleValue(trim(getIMAGENAME())))>
            <cfset thisError.field = "IMAGENAME" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "NAME is not a string" />
            <cfset arrayAppend(errors, thisError.message) />
        </cfif>
        <cfif (len(trim(getIMAGENAME())) GT 20)>
            <cfset thisError.field = "IMAGENAME" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "NAME is too long" />
            <cfset arrayAppend(errors, thisError.message) />
            <!--- <cfset arrayAppend(errors,duplicate(thisError)) /> --->
        </cfif>
        <cfif (len(trim(getIMAGENAME())) EQ 0)>
            <cfset thisError.field = "IMAGENAME" />
            <cfset thisError.type = "tooShort" />
            <cfset thisError.message = "Please Enter NAME" />
            <cfset arrayAppend(errors, thisError.message) />
            <!--- <cfset arrayAppend(errors,duplicate(thisError)) /> --->
        </cfif>

        <!--- Description --->
        <cfif (len(trim(getIMAGEDESCRIPTION())) AND NOT IsSimpleValue(trim(getIMAGEDESCRIPTION())))>
            <cfset thisError.field = "IMAGEDESCRIPTION" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "DESCRIPTION is not a string" />
            <cfset arrayAppend(errors, thisError.message) />
            <!--- <cfset arrayAppend(errors,duplicate(thisError)) /> --->
        </cfif>
        <cfif (len(trim(getIMAGEDESCRIPTION())) GT 50)>
            <cfset thisError.field = "IMAGEDESCRIPTION" />
            <cfset thisError.type = "tooLong" />
            <cfset thisError.message = "DESCRIPTION is too long" />
            <cfset arrayAppend(errors, thisError.message) />
            <!--- <cfset arrayAppend(errors,duplicate(thisError)) /> --->
        </cfif>
        <cfif (len(trim(getIMAGEDESCRIPTION())) EQ 0)>
            <cfset thisError.field = "IMAGEDESCRIPTION" />
            <cfset thisError.type = "tooShort" />
            <cfset thisError.message = "Please Enter DESCRIPTION." />
            <cfset arrayAppend(errors, thisError.message) />
            <!--- <cfset arrayAppend(errors,duplicate(thisError)) /> --->
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
                <!--- check for image file and format --->
                <cftry>
                    <cffile
                        action="upload"
                        filefield="Image"
                        destination="#LOCAL.uploadFolder#"
                        nameconflict="overwrite"
                        accept="image/jpeg,image/png"
                        result="fileUploadResult" />

                        <cfset LOCAL.finalData.success = true />
                        <cfset LOCAL.finalData.ImageAddress = "./assets/images/gallery/" & #fileUploadResult.SERVERFILE# />

                    <cfcatch>
                        <cfset LOCAL.finalData.data = arrayNew(1)/>
                        <cfset LOCAL.finalData.success = false />
                        <cfset LOCAL.finalData.data[1] = #cfcatch.message# />
                        <cfreturn LOCAL.finalData />
                    </cfcatch>
                </cftry>

            <cfelse>
                <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false />
                <cfset LOCAL.finalData.data[1] = "Please choose the Art from the directory." />
            </cfif>
        <cfelse>
            <cfset LOCAL.finalData.data = arrayNew(1)/>
            <cfset LOCAL.finalData.success = false />
            <cfset LOCAL.finalData.data[1] = "Directory does not exist." />
        </cfif>

        <cfreturn LOCAL.finalData />
    </cffunction>

</cfcomponent>
