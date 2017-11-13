<!---
* File: gallery.cfm
* Author: Mohit Dadu
* Purpose: to display arts.
* Date: 09/26/2017
--->

<!--- check event arguments exists --->
<cfif event.isArgDefined('qArtList')>
  <cfset VARIABLES.artList = event.getArg("qArtList") />

  <cfif structIsEmpty(VARIABLES.artList)>
    <div id="" class="text-center" ><h3>User does Not Exists / Session Expired, Please login..</h3></div>
    <cfexit>
  </cfif>

  <cfif VARIABLES.artList.artist.UserId EQ ''>
    <div id="" class="text-center" ><h3>User does Not Exists / Session Expired, Please login..</h3></div>
    <cfexit>
  </cfif>

  <!--- content --->
  <div class="container">
    <div class="row">

      <cfoutput query="VARIABLES.artList.artist">

        <div class="col-sm-12 col-md-3 text-center" style="margin-bottom: 5px;">

          <cfif fileExists(expandPath(VARIABLES.artList.artist.ImageAddress)) EQ "NO" >
            <img class="img-thumbnail" src="http://placehold.it/200x200" alt="">
          <cfelse>
            <img src="#VARIABLES.artList.artist.ImageAddress#" alt="#VARIABLES.artList.artist.Name#" id="rcorners6" class="text-right" width="210" height="160">
          </cfif>

        </div>
        <div class="col-sm-12 col-md-9 ">
          <h3>#VARIABLES.artList.artist.Name#</h3>

          <cfif VARIABLES.artList.artist.Comment NEQ ''>
            <p>#VARIABLES.artList.artist.Comment#</p>
          <cfelse>
            <p>
              For my part I know nothing with any certainty, but the sight of the stars makes me dream.
              I dream of painting and then I paint my dream.
              I feel that there is nothing more truly artistic than to love people.
              The best way to know God is to love many things.
              I often think that the night is more alive and more richly colored than the day.
              What would life be if we had no courage to attempt anything?
              If you truly love Nature, you will find beauty everywhere.
            </p>
          </cfif>
<!---           <p>Address: #VARIABLES.artList.artist.Address#</p>
          <p>Email: #VARIABLES.artList.artist.Email#</p>
          <p>Contact: #VARIABLES.artList.artist.Contact#</p> --->
        </div>

      </cfoutput>

    </div>
  </div>
  <hr style="height: 10px; border: 0; box-shadow: 0 10px 10px -10px #8c8b8b inset";>

  <!--- Tile display --->
  <div class="container gallery-container" id="grid_display">
    <!--- <p class="page-description text-center col-md-8">Art is Everything and Everything is Art.</p> --->
    <div class="tz-gallery col-md-12 ">
      <div class="row">

        <cfoutput query="VARIABLES.artList.art" >

          <div class="col-sm-3 col-md-4 col-lg-4 imgframe">
            <div class="frame">
              <a class="lightbox" href="#VARIABLES.artList.art.ImageFile#">
                <img src="#VARIABLES.artList.art.ImageFile#" alt="#VARIABLES.artList.art.ImageName#" class="container-fluid" width="350" height="250">
              </a>
              <div class="caption">
                <h3>#VARIABLES.artList.art.ImageName#</h3>
                <p>#VARIABLES.artList.art.ImageDescription#.</p>
              </div>
            </div>
          </div>

        </cfoutput>

      </div>
    </div>
  </div>
  <!--- End tile display --->

  <!--- include files --->
  <script src="./assets/vendor/jquery/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.js"></script>
  <script src="./assets/vendor/popper/popper.min.js"></script>
  <script> baguetteBox.run('.tz-gallery'); </script>

<cfelse>
  <div id="" class="text-center" ><h3>User does Not Exists.</h3></div>
  <cfexit>
</cfif>