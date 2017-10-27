<!---
* File: index.cfm
* Author: Mohit Dadu
* Date: 09/25/2017
--->

<cfset properties = StructNew() />
<cfset properties.dsn = "artgallery" />

<!--- Set the path to the application's mach-ii.xml file. --->
<cfset MACHII_CONFIG_PATH = ExpandPath("./config/mach-ii.xml") />

<!--- Set the configuration mode (when to reload): -1=never, 0=dynamic, 1=always --->
<cfset MACHII_CONFIG_MODE = 1 />

<!--- Set the app key for sub-applications within a single cf-application. --->
<cfset MACHII_APP_KEY = GetFileFromPath(ExpandPath(".")) />

<!--- Include the mach-ii.cfm file included with the core code. --->
<cfinclude template="/MachII/mach-ii.cfm" />

<!---
<meta http-equiv="cache-control" content="max-age=0" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
<meta http-equiv="pragma" content="no-cache" /> --->

<cfheader name="Expires" value="#Now()#">
<cfheader name="Pragma" value="no-cache">
<cfheader name="cache-control" value="no-cache">
<cfheader name="cache-control" value="must-revalidate">
<cfheader name="cache-control" value="no-store">
<cfheader name="Pragma" value="no-store">