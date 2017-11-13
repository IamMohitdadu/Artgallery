<!--
* File: artistGateway.cfc
* Author: Mohit Dadu
* Purpose: select and check user details VARIABLES.
* Date: 09/26/2017
-->

<cfcomponent displayname="artistGateway" output="false">

    <!---
        constructor - init
    --->
    <cffunction name="init" access="public" output="false" returntype="model.artists.artistGateway">
        <cfargument name="artgalleryDSN" type="string" required="true" />
        <cfset VARIABLES.dsn = ARGUMENTS.artgalleryDSN />
        <cfreturn this />
    </cffunction>

    <!---
        check for available users
    --->
    <cffunction name="CheckUser" access="public" output="false" returntype="struct">
        <cfargument name="Email" type="string" required="true" />
        <cfargument name="Password" type="string" required="true" />
        <cfset qCheckUser = queryNew("")/>
        <cfset LOCAL.finalData= structNew()/>

        <cftry>
            <cfquery name="qCheckUser" datasource="#VARIABLES.dsn#">
                SELECT  UserId,
                        Name,
                        Email,
                        ImageAddress
                FROM    [dbo].[User]
                WHERE   Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.Email#">
                AND     Password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(ARGUMENTS.Password)#">
            </cfquery>

            <cfif qcheckUser.RecordCount NEQ 0>
                <!--- structure when success --->
                <cfset LOCAL.finalData.success = true/>
                <cfset LOCAL.finalData.data = qCheckUser/>
            <cfelse>
                <!--- structure when fail --->
                <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="User Does not exists.Please enter the valid credentials."/>
            </cfif>
            <cfreturn LOCAL.finalData/>

            <!--- exception handler --->
            <cfcatch type="any">
               <cflog file="exception" text = "#cfcatch.type# - #cfcatch.message#" type = "error" >
                <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="Login Fail. Please try again."/>
                <cfreturn LOCAL.finalData/>
            </cfcatch>
        </cftry>

    </cffunction>

    <!---
        check for available users
    --->
    <cffunction name="RegisterUser" access="public" output="false" returntype="struct">
        <cfargument name="Name" type="string" required="true" />
        <cfargument name="Address" type="string" required="true" />
        <cfargument name="Contact" type="numeric" required="true" />
        <cfargument name="Email" type="string" required="true" />
        <cfargument name="Password" type="string" required="true" />
        <cfset LOCAL.finalData= structNew()/>
        <cfset qCheckUser = queryNew("")/>

        <cftry>
            <!--- check if user already available --->
            <cfquery name="qCheckUser" datasource="#VARIABLES.dsn#">
                SELECT  UserId
                FROM    [dbo].[User]
                WHERE   Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.Email#">
            </cfquery>

            <!--- Add user details if not available --->
            <cfif qcheckUser.RecordCount EQ 0>
                <cfset qCreate = queryNew("") />
                <cftry>
                    <cfquery name="qCreate" datasource="#VARIABLES.dsn#" result="adduser">
                        INSERT INTO [dbo].[User]
                            (
                            UserTypeId,
                            NAME,
                            ADDRESS,
                            CONTACT,
                            EMAIL,
                            PASSWORD,
                            CreatedOn
                            )
                        VALUES
                            (1,
                             <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.Name#">,
                             <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.Address#">,
                             <cfqueryparam cfsqltype="cf_sql_bigint" value="#ARGUMENTS.Contact#">,
                             <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.Email#">,
                             <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(ARGUMENTS.Password)#">,
                             GETDATE()
                            )
                    </cfquery>
                    <cfcatch>
                        <cfrethrow>
                    </cfcatch>
                </cftry>

                <cfif adduser.RecordCount GT 0>
                    <cfset LOCAL.finalData.data = arrayNew(1)/>
                    <cfset LOCAL.finalData.success = false/>
                    <cfset LOCAL.finalData.data[1] ="Registration successful. Please Login."/>
                    <!--- <cfreturn true /> --->
                </cfif>
            <cfelse>
                <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="User Already Exists."/>
            </cfif>

            <cfreturn LOCAL.finalData />

            <!--- exception handler --->
            <cfcatch type="any">
               <cflog file="exception" text = "#cfcatch.type# - #cfcatch.message#" type = "error" >
                <cfset LOCAL.finalData.data = arrayNew(1)/>
                <cfset LOCAL.finalData.success = false/>
                <cfset LOCAL.finalData.data[1] ="Registration fail. Please try again."/>
                <cfreturn LOCAL.finalData />
            </cfcatch>
        </cftry>

    </cffunction>

    <!---
        to get all the artists
    --->
    <cffunction name="getArtists" access="public" output="false" returntype="query">
        <cfargument name="USERID" type="string" required="false" />
        <cfargument name="NAME" type="string" required="false" />
        <cfargument name="ADDRESS" type="string" required="false" />
        <cfargument name="EMAIL" type="string" required="false" />
        <cfargument name="CONTACT" type="numeric" required="false" />
        <cfargument name="PASSWORD" type="string" required="false" />
        <cfargument name="orderby" type="string" required="false" />
        <cfset qList = queryNew("")/>

        <cftry>
            <cfquery name="qList" datasource="#VARIABLES.dsn#" >
                SELECT
                    USERID,
                    NAME,
                    ADDRESS,
                    EMAIL,
                    CONTACT,
                    PASSWORD,
                    IMAGEADDRESS
                FROM    [dbo].[User]
                WHERE   0=0
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

        <cfreturn qList />
    </cffunction>

    <!---
        to get artist details
    --->
    <cffunction name="GetArtistDetails" access="public" output="false" returntype="query">
        <cfargument name="USERID" type="string" required="false" />
        <cfset qartist = queryNew("")/>

        <cftry>
            <!--- get artist details --->
            <cfquery name="qartist" datasource="#VARIABLES.dsn#">
                SELECT
                    USERID,
                    NAME,
                    ADDRESS,
                    EMAIL,
                    CONTACT,
                    COMMENT,
                    IMAGEADDRESS
                FROM    [dbo].[User]
                WHERE   USERID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.USERID#">
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

        <cfreturn qartist />

    </cffunction>

    <!---
        to change user image
    --->
    <cffunction name="ProfileImage" access="public" output="false" returntype="boolean">
        <cfargument name="UserId" type="numeric" required="true" />
        <cfargument name="ImageAddress" type="string" required="true" />

        <cfset var qCreate = "" />
        <cftry>
            <!--- update profile images --->
            <cfquery name="qCreate" datasource="#VARIABLES.dsn#" result="addrecord">
                UPDATE [dbo].[user]
                SET
                    ImageAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ImageAddress#">,
                    ModifiedOn = GETDATE()
                WHERE UserId = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.UserId#">
            </cfquery>

            <cfif addrecord.RecordCount GT 0>
                <cfreturn true />
            <cfelse>
                <cfreturn false />
            </cfif>

            <!--- exception handler --->
            <cfcatch type="any">
               <cflog file="exception" text = "#cfcatch.type# - #cfcatch.message#" type = "error" >
               <cfreturn false />
            </cfcatch>
        </cftry>

    </cffunction>

    <!---
        Update profile data
    --->
    <cffunction name="UpdateUser" access="public" output="false" returntype="boolean">
        <cfargument name="USERID" type="numeric" required="true" />
        <cfargument name="NAME" type="string" required="true" />
        <cfargument name="ADDRESS" type="string" required="true" />
        <cfargument name="CONTACT" type="numeric" required="true" />
        <cfargument name="COMMENT" type="string" required="true" />
        <cfset var qCreate = "" />

        <cftry>
            <!--- update user details --->
            <cfquery name="qCreate" datasource="#VARIABLES.dsn#" result="updateRecord">
                UPDATE [dbo].[user]
                SET
                    NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.NAME#">,
                    ADDRESS = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.ADDRESS#">,
                    CONTACT = <cfqueryparam cfsqltype="cf_sql_bigint" value="#ARGUMENTS.CONTACT#">,
                    COMMENT = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.COMMENT#">,
                    ModifiedOn = GETDATE()
                WHERE UserId = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.USERID#">
            </cfquery>

            <cfif updateRecord.RecordCount GT 0>
                <cfreturn true />
            <cfelse>
                <cfreturn false />
            </cfif>

            <!--- exception handler --->
            <cfcatch type="any">
               <cflog file="exception" text = "#cfcatch.type# - #cfcatch.message#" type = "error" >
               <cfreturn false />
            </cfcatch>
        </cftry>

    </cffunction>

</cfcomponent>
