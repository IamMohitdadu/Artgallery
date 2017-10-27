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
    <h3><center>User does Not Exists.</center></h3>
    <cfexit>
  </cfif>

  <cfif VARIABLES.artList.artist.Name EQ ''>
    <h3><center>User does Not Exists.</center></h3>
    <cfexit>
  </cfif>

  <div class="container">
    <div class="row">

      <cfoutput query="VARIABLES.artList.artist">

        <div class="col-sm-6 col-md-3">

          <cfif fileExists(expandPath(VARIABLES.artList.artist.ImageAddress)) EQ "NO" >
            <img class="img-thumbnail" src="http://placehold.it/200x200" alt="">
          <cfelse>
            <img src="#VARIABLES.artList.artist.ImageAddress#" alt="#VARIABLES.artList.artist.Name#" class="" width="200" height="200">
          </cfif>

          <cfif structKeyExists(SESSION, 'user') and SESSION.user['userId'] EQ event.getArg('userid')  >
            <form class="" id="ChangeImage" name="ChangeImage" method="post" enctype="multipart/form-data" action="index.cfm?event=uploadProfileImage">
              <input type="hidden" id="UserId" name="UserId" value="<cfif structKeyExists(SESSION,'user')><cfoutput>#SESSION.user['userId']#</cfoutput></cfif>" />
              <input type="file" name="Image" id="Image" >
              <input class="btn btn-primary btn-sm" type="Submit" name="Submit" value="Submit"><br>

              <cfif event.isArgDefined('imageMessage') >
                <span class="fa fa-circle-sm icon-resize-small" aria-hidden="true" style="color: red">#arguments.event.getArg('imageMessage')#</span>
              </cfif>

            </form>
          </cfif>

        </div>
        <div class="col-sm-6 col-md-3 ">
          <h3>#VARIABLES.artList.artist.Name#</h3>
          <p>Address: #VARIABLES.artList.artist.Address#</p>
          <p>Email: #VARIABLES.artList.artist.Email#</p>
          <p>Contact: #VARIABLES.artList.artist.Contact#</p>

          <cfif structKeyExists(SESSION, 'user') and SESSION.user['userId'] EQ event.getArg('userid')  >
              <input class="btn btn-primary btn-sm" type="button" id="EditProfile" name="EditProfile" value="EditProfile">
          </cfif>

        </div>

        <div class="EditProfileDetails col-sm-6 col-md-6" style="display: none">
          <form id="updateProfile" method="post" action="index.cfm?event=EditProfile">
            <input type="hidden" id="UserId" name="UserId" value="<cfif structKeyExists(SESSION,'user')>#SESSION.user['userId']#</cfif>" />
            <label for="Email">Name</label>
            <input type="text" id="Name" name="Name" placeholder="Name" value="#VARIABLES.artList.artist.Name#" class="form-control" /><br>
            <label for="Address">Address</label>
            <input type="text" id="Address" name="Address" placeholder="Address" value="#VARIABLES.artList.artist.Address#" class="form-control" /><br>
            <label for="Contact">Contact</label>
            <input type="number" id="Contact" name="Contact" placeholder="Contact" value="#VARIABLES.artList.artist.Contact#" class="form-control" /><br>
            <input class="btn btn-danger btn-sm" type="button" id="Cancel" name="Cancel" value="Cancel">
            <input class="btn btn-primary btn-sm" type="Submit" name="Submit" value="Submit">
          </form>
        </div>

      </cfoutput>

    </div>
  </div><hr>
  <div class="container gallery-container">
    <p class="page-description text-center">Art is Everything and Everything is Art.</p>
    <div class="tz-gallery">
      <div class="row">

        <cfoutput query="VARIABLES.artList.art" >

          <div class="col-sm-6 col-md-4">
            <div class="thumbnail">
              <a class="lightbox" href="#VARIABLES.artList.art.ImageFile#">
                <img src="#VARIABLES.artList.art.ImageFile#" alt="#VARIABLES.artList.art.ImageName#" class="img-rounded" width="350" height="250">
              </a>
              <div class="caption">
                <h3>#VARIABLES.artList.art.ImageName#</h3>
                <p>Description: #VARIABLES.artList.art.ImageDescription#.</p>
              </div>
            </div>
          </div>

        </cfoutput>

      </div>
    </div>
  </div>

  <script src="./assets/vendor/jquery/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.8.1/baguetteBox.min.js"></script>
  <script src="./assets/vendor/popper/popper.min.js"></script>
  <script src="./assets/vendor/bootstrap/js/bootstrap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
  <script src="./assets/js/validation.js"></script>
  <script src="./assets/js/updateStatus.js"></script>
  <script src="./assets/js/hideShow.js"></script>
  <script> baguetteBox.run('.tz-gallery'); </script>

<cfelse>
  <h3><center>User does Not Exists.</center></h3>
  <cfexit>
</cfif>