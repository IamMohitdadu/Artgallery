<!--
* File: artDAO.cfc
* Author: Mohit Dadu
* Purpose: crud operations.
* Date: 09/26/2017
-->

<cfcomponent displayname="artDAO">

    <!---
        init method initilize the dsn variable
     --->
    <cffunction name="init" access="public" output="false" returntype="model.art.artDAO">

        <cfargument name="artgalleryDSN" type="string" required="true" />
        <cfset variables.dsn = arguments.artgalleryDSN />

        <cfreturn this>
    </cffunction>

    <!---
        Add image function used to add art of an artist into gallery
     --->
    <cffunction name="AddImage" access="public" output="false" returntype="struct">
        <!--- <cfargument name="art" type="model.art.art" required="true" /> --->
        <cfargument name="UserId" type="numeric" required="true" />
        <cfargument name="ImageName" type="string" required="true" />
        <cfargument name="ImageDescription" type="string" required="true" />
        <cfargument name="ImageAddress" type="string" required="true" />

        <cfset LOCAL.finalData= structNew()/>
        <cfset var qCreate = "" />

        <cftry>
            <cfquery name="qCreate" datasource="#variables.dsn#" result="addrecord">
                INSERT INTO GALLERY
                    (
                    UserId,
                    ImageName,
                    ImageDescription,
                    ImageFile,
                    CreatedOn,
                    ImageStatus
                    )
                VALUES
                    (
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.UserId#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ImageName#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ImageDescription#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ImageAddress#">,
                    GETDATE(),
                    1
                    )
            </cfquery>

            <cfif addrecord.RecordCount GT 0>
                <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="Art Added Successfully."/>
                <!--- <cfreturn true /> --->
            <cfelse>
                <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="Image not added. Please try again."/>
                <!--- <cfreturn false /> --->
            </cfif>
            <cfreturn LOCAL.finalData />

            <!--- exception handler --->
            <cfcatch type="any">
               <cflog file="exception" text = "#cfcatch.type# - #cfcatch.message#" type = "error" >
                <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="Something went wrong, please try again later."/>
                <cfreturn LOCAL.finalData />
            </cfcatch>
        </cftry>

    </cffunction>


<!---     <cffunction name="delete" access="public" output="false" returntype="boolean">
        <cfargument name="art" type="model.art.art" required="true" />

        <cfset var qDelete = "">
        <cftry>
            <cfquery name="qDelete" datasource="#variables.dsn#">
                DELETE FROM ART
                WHERE
            </cfquery>
            <cfcatch type="database">
                <cfreturn false />
            </cfcatch>
        </cftry>
        <cfreturn true />
    </cffunction> --->

</cfcomponent>
