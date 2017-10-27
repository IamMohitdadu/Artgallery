<!---
* File: home.cfm
* Author: Mohit Dadu
* Purpose: to display all artists.
* Date: 09/26/2017
--->

<cfset LOCAL.artistBean = getPropertyManager().getproperty('servicefactory').GETBEAN('artistGateway')/>
<cfset VARIABLES.list = LOCAL.artistBean.getArtists() />
<cfif not isQuery(VARIABLES.list) >
    <h3><center>Artist list not Available.</center></h3>
    <cfexit>
</cfif>

    <!--- Page Content --->
    <div class="container">
      <!--- Introduction Row --->
      <h1 class="" align="center">
        <small>"Great things are done by a series of small things brought together."</small>
      </h1>
      <p align="center">Welcome to the Art Gallery.</p><br>

      <!--- Team Members Row --->
      <div class="row">

        <cfoutput query="list">

          <div class="col-lg-3 col-sm-6 text-center mb-4">

            <cfif fileExists(expandPath(VARIABLES.list.ImageAddress)) EQ "NO" >
               <a href="index.cfm?event=gallery&UserID=#variables.list.UserId#">
               <img class="img-fluid d-block mx-auto" src="http://placehold.it/200x200" alt=""></a>
            <cfelse>
            <!--- <cfif VARIABLES.list.ImageAddress NEQ ''> --->
              <a href="index.cfm?event=gallery&UserID=#variables.list.UserId#" addtoken='no'>
              <img class="img-rounded d-block mx-auto" src="#list.ImageAddress#" alt="" width="200" height="200"></a>
            </cfif>

            <h3>#list.Name#
              <small>.</small>
            </h3>
            <p>#list.Email#</p>
          </div>

        </cfoutput>

      </div>
    </div>
    <!--- /.container --->

    <script src="./assets/vendor/jquery/jquery.min.js"></script>
    <script src="./assets/vendor/popper/popper.min.js"></script>
    <script src="./assets/vendor/bootstrap/js/bootstrap.min.js"></script>