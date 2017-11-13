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
        To get list of active arts of particular artist
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
                        ImageDescription,
                        CreatedOn
                FROM    [dbo].[Gallery]
                WHERE   UserId = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.UserId#">
                And     ImageStatus = 1;
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
        To get list of All arts of particular artist
    --->
    <cffunction name="AllArtList" access="public" output="false" returntype="query">
        <cfargument name="UserId" type="numeric" required="false" />
        <cfset var qArtList = queryNew('') />

        <cftry>
            <cfquery name="qArtList" datasource="#variables.dsn#">
                SELECT  ImageId,
                        ImageFile,
                        ImageName,
                        ImageStatus,
                        ImageDescription,
                        CreatedOn
                FROM    [dbo].[Gallery]
                WHERE   UserId = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.UserId#">
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
        <cfset var updateArt= queryNew("")/>

        <cftry>
            <cfquery name="updateArt" datasource="#VARIABLES.dsn#">
                UPDATE  [dbo].[Gallery]
                SET     ImageStatus = CASE ImageStatus WHEN 0 THEN 1 ELSE 0 END
                WHERE   ImageId = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.artId#">;
            </cfquery>

            <!--- exception handler --->
            <cfcatch type="any">
               <cflog file="exception" text = "#cfcatch.type# - #cfcatch.message#" type = "error" >
<!---                 <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="Registration fail. Please try again."/>
                <cfreturn LOCAL.finalData /> --->
                <cfreturn false />
            </cfcatch>
        </cftry>

        <cfreturn true />

    </cffunction>

</cfcomponent>
