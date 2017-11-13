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
  <hr style="height: 10px; border: 0; box-shadow: 0 10px 10px -10px #8c8b8b inset";>
  <!--- Team Members Row --->
  <div class="row">
    <div class="pull-right col-lg-12 col-md-12 col-sm-12" style="padding-bottom: 20px;">
      <!--- <input type="search" class="pull-right" name="search" id="search" value=""> --->
    </div>

    <cfoutput query="list">

      <div class="col-lg-3 col-sm-6 text-center mb-4" data-filter="#list.Name#" >

        <cfif fileExists(expandPath(VARIABLES.list.ImageAddress)) EQ "NO" >
           <a href="index.cfm?event=gallery&UserID=#variables.list.UserId#">
           <img class="img-rounded d-block mx-auto" src="http://placehold.it/160x160" alt="">
        <cfelse>
        <!--- <cfif VARIABLES.list.ImageAddress NEQ ''> --->
          <a href="index.cfm?event=gallery&UserID=#variables.list.UserId#" addtoken='no'>
          <img class="img-rounded d-block mx-auto" src="#list.ImageAddress#" alt="" width="160" height="160">
        </cfif>

          <h4>#list.Name#</h4></a>
      </div>

    </cfoutput>

  </div>
</div>
<!--- /.container --->

<script src="./assets/vendor/jquery/jquery.min.js"></script>
<script src="./assets/vendor/popper/popper.min.js"></script>
<script src="./assets/vendor/bootstrap/js/bootstrap.min.js"></script>

<script>
  $('#search').on('keyup', function() {
    var val = $.trim(this.value);
    if (val) {
        $('div[data-filter=' + val + ']').show();
    }
});

</script>