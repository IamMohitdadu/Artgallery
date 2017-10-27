<!--
* File: artGateway.cfc
* Author: Mohit Dadu
* Purpose: get data from database.
* Date: 09/26/2017
-->

<cfcomponent displayname="artGateway" output="false">

    <!---
        constructor - init
    --->
    <cffunction name="init" access="public" output="false" returntype="model.art.artGateway">
        <cfargument name="artgalleryDSN" type="string" required="true" />
        <cfset variables.dsn = arguments.artgalleryDSN />
        <cfreturn this />
    </cffunction>

    <!---
        To get list of arts of particular artist
    --->
    <cffunction name="GetArtList" access="public" output="false" returntype="query">
        <cfargument name="UserId" type="numeric" required="false" />
        <cfset var qArtList = queryNew('') />

        <cftry>
            <cfquery name="qArtList" datasource="#variables.dsn#">
                SELECT  ImageId,
                        ImageFile,
                        ImageName,
                        ImageStatus,
                        ImageDescription
                FROM    [dbo].[Gallery]
                WHERE   UserId = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.UserId#">
    <!---                    <CFIF isDefined( SESSION.USER['USERID']) AND #ARGUMENTS.UserId# NEQ #SESSION.USER['USERID']# >
                            AND Status = 1
                        </CFIF>
                        --->
            </cfquery>

            <!--- exception handler --->
            <cfcatch type="any">
               <cflog file="exception" text = "#cfcatch.type# - #cfcatch.message#" type = "error" >
<!---                 <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="Registration fail. Please try again."/>
                <cfreturn LOCAL.finalData /> --->
            </cfcatch>
        </cftry>

        <cfreturn qArtList />
    </cffunction>

    <!---
        Update Active status of art
    --->
    <cffunction name="UpdateArtStatus" access="public" output="false" returntype="boolean">
        <cfargument name="artId" type="numeric" required="true" />
        <cfargument name="status" type="numeric" required="true" />
        <cfset var updateArt= queryNew("")/>

        <cftry>
            <cfquery name="updateArt" datasource="#VARIABLES.dsn#">
                UPDATE  [dbo].[Gallery]
                SET     ImageStatus = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.status#">
                WHERE   ImageId = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.artId#">;
            </cfquery>

            <!--- exception handler --->
            <cfcatch type="any">
               <cflog file="exception" text = "#cfcatch.type# - #cfcatch.message#" type = "error" >
<!---                 <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="Registration fail. Please try again."/>
                <cfreturn LOCAL.finalData /> --->
            </cfcatch>
        </cftry>

        <cfif isDefined(updateArt.recordCount) >
            <cfreturn true />
        <cfelse>
            <cfreturn false />
        </cfif>

    </cffunction>

</cfcomponent>
