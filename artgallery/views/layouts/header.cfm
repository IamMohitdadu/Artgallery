<!---
* File: header.cfm
* Author: Mohit Dadu
* Purpose: Header page.
* Date: 09/26/2017
--->

<!DOCTYPE html>
<html lang="en">

  <head>

    <cfif not isNull(event.getArg("qArtList"))>
        <cfset VARIABLES.artList = event.getArg("qArtList") />
    </cfif>

    <meta charset="utf-8">
    <!--- use to redirect to defined page in 5 seconds --->
    <!--- <meta http-equiv="Refresh" content="5; url=https://www.google.com"> --->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>
        <cfif event.isArgDefined('pageTitle') >
            <cfoutput>#event.getArg("pageTitle")#</cfoutput>
        <cfelse>
            ArtGallery
        </cfif>
    </title>

    <!-- Bootstrap core CSS -->
    <link href="./assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Droid+Sans:400,700" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.css">
        <!-- Custom styles for this template -->
    <link href="./assets/css/style.css" rel="stylesheet">
    <link href="./assets/css/thumbnail-gallery.css" rel="stylesheet">


<!--- *************** YUI libraries ***************** --->
<!--- <!--CSS file (default YUI Sam Skin) -->
<link type="text/css" rel="stylesheet" href="http://yui.yahooapis.com/2.9.0/build/datatable/assets/skins/sam/datatable.css">

<!-- Dependencies -->
<script src="http://yui.yahooapis.com/2.9.0/build/yahoo/yahoo-min.js"></script>
<script src="http://yui.yahooapis.com/2.9.0/build/yahoo-dom-event/yahoo-dom-event.js"></script>
<script src="http://yui.yahooapis.com/2.9.0/build/element/element-min.js"></script>
<script src="http://yui.yahooapis.com/2.9.0/build/datasource/datasource-min.js"></script>
<!-- OPTIONAL: JSON Utility (for DataSource) -->
<script src="http://yui.yahooapis.com/2.9.0/build/json/json-min.js"></script>
<!-- OPTIONAL: Connection Manager (enables XHR for DataSource) -->
<script src="http://yui.yahooapis.com/2.9.0/build/connection/connection-min.js"></script>
<!-- OPTIONAL: Get Utility (enables dynamic script nodes for DataSource) -->
<script src="http://yui.yahooapis.com/2.9.0/build/get/get-min.js"></script>
<!-- OPTIONAL: Drag Drop (enables resizeable or reorderable columns) -->
<script src="http://yui.yahooapis.com/2.9.0/build/dragdrop/dragdrop-min.js"></script>
<!-- OPTIONAL: Calendar (enables calendar editors) -->
<script src="http://yui.yahooapis.com/2.9.0/build/calendar/calendar-min.js"></script>
<!-- Source files -->
<script src="http://yui.yahooapis.com/2.9.0/build/datatable/datatable-min.js"></script>

<!-- Event source file -->
<script src="http://yui.yahooapis.com/2.9.0/build/event/event-min.js" ></script>

<!-- Dom source file -->
<script src="http://yui.yahooapis.com/2.9.0/build/dom/dom-min.js" ></script>

<!-- MouseEnter source file -->
<script src="http://yui.yahooapis.com/2.9.0/build/event-mouseenter/event-mouseenter-min.js" ></script> --->

 <!--- ****************** End *************** --->
    </head>
    <body>