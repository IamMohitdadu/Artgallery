<!---
* File: Profile.cfm
* Author: Mohit Dadu
* Purpose: to display arts.
* Date: 11/02/2017
--->

<!--CSS file (default YUI Sam Skin) -->
<link type="text/css" rel="stylesheet" href="http://yui.yahooapis.com/2.9.0/build/datatable/assets/skins/sam/datatable.css">
<!--- jquery datatable css --->
<link rel="stylesheet" type="text/css" href="./assets/vendor/DataTables/datatables.min.css"/>
<!--- custom css --->
<link rel="stylesheet" type="text/css" href="./assets/css/profile.css">

<!--- check event arguments exists --->
<cfif event.isArgDefined('qArtList')>
  <cfset VARIABLES.artList = event.getArg("qArtList") />

  <cfif structIsEmpty(VARIABLES.artList)>
    <div id="" class="text-center" ><h3>Invalid Session.</h3></div>
    <cfexit>
  </cfif>

  <cfif VARIABLES.artList.artist.Name EQ ''>
    <div id="" class="text-center" ><h3>Invalid Session.</h3></div>
    <cfexit>
  </cfif>

  <!--- content --->
<div class="">
  <!--- left side --->
  <div class="left-side col-sm-12 col-lg-3 text-center">
    <div class="profile-details">

      <cfoutput query="VARIABLES.artList.artist">
        <cfif fileExists(expandPath(VARIABLES.artList.artist.ImageAddress)) EQ "NO" >
          <img class="img-thumbnail" src="http://placehold.it/200x200" alt="">
        <cfelse>
          <img src="#VARIABLES.artList.artist.ImageAddress#" alt="#VARIABLES.artList.artist.Name#" id="" class="img-profile" width="200px" height="200px"  style="margin: 10px;">
        </cfif>

        <h3>#VARIABLES.artList.artist.Name#</h3>
        <p>Address: #VARIABLES.artList.artist.Address#</p>
        <p>Email: #VARIABLES.artList.artist.Email#</p>
        <p>Contact: #VARIABLES.artList.artist.Contact#</p>

      </cfoutput>
    </div>
    <hr>
    <div class="list">
      <ul class="list-group">
          <li class="list-group-item profile_details_button">Edit Profile</li>
          <li class="list-group-item art_details_button">Art Details(JQUERY DATATABLE)</li>
          <li class="list-group-item artyui_details_button">Art Details(YUI DATATABLE)</li>
      </ul>
    </div>
  </div>
  <!--- end left side --->

  <!--- right side bar --->
  <div class="right-side col-sm-12 col-lg-9">
    <!--- edit form --->
    <div class="col-sm-12 col-md-11 col-lg-11 col-lg-offset-1 profile_details pull-right">
      <!--- change profile image form --->
      <h4>Change Profile Image:</h4>
      <div class="container-fluid">
        <div class="col-md-10 col-lg-10 col-sm-10">

          <cfif structKeyExists(SESSION, 'user') and SESSION.user['userId'] EQ event.getArg('userid') >

            <form class="" id="ChangeImage" name="ChangeImage" method="post" enctype="multipart/form-data" action="index.cfm?event=uploadProfileImage">
              <input type="hidden" id="UserId" name="UserId" value="<cfif structKeyExists(SESSION,'user')><cfoutput>#SESSION.user['userId']#</cfoutput></cfif>" />

              <div class="col-md-10 col-lg-10 col-sm-10 pull-left">
                <input type="file" name="Image" id="Image" class="image-file" >
              </div>
              <div class="pull-right">
                <input class="btn btn-primary btn-sm" type="Submit" name="Submit" value="Save">
              </div>
            </form>

            <cfif event.isArgDefined('imageMessage') >
              <span class="fa fa-circle-sm icon-resize-small" aria-hidden="true" style="color: red"><cfoutput>#arguments.event.getArg('imageMessage')#</cfoutput></span>
            </cfif>
          </cfif>

        </div>
      </div>
      <!--- End update profile Image --->
      <!--- Edit profile details form --->
      <cfoutput query="VARIABLES.artList.artist">

        <h4 class="">Edit Profile:</h4><br>
        <div class="container-fluid">
          <div class="col-md-10 col-lg-10 col-sm-10">

            <form id="updateProfile" method="post" action="index.cfm?event=EditProfile">
              <input type="hidden" id="UserId" name="UserId" value="<cfif structKeyExists(SESSION,'user')>#SESSION.user['userId']#</cfif>" />
              <div class="form-group">
                <label for="Name">Name:</label>
                <input type="text" id="Name" name="Name" placeholder="Name" value="#VARIABLES.artList.artist.Name#" class="form-control" />
              </div>
              <div class="form-group">
                <label for="Address">Address:</label>
                <input type="text" id="Address" name="Address" placeholder="Address" value="#VARIABLES.artList.artist.Address#" class="form-control" />
              </div>
              <div class="form-group">
                <label for="Contact">Contact:</label>
                <input type="number" id="Contact" name="Contact" placeholder="Contact" value="#VARIABLES.artList.artist.Contact#" class="form-control" />
              </div>
              <div class="form-group">
                <label for="Contact">About Me:</label>
                <textarea name="comment" id="comment" style="width:100%;height:90px;border:none; padding:1%;font:15px sans-serif;">#VARIABLES.artList.artist.Comment#</textarea>
              </div>
              <div class="pull-right">
                <!--- <input class="btn btn-danger btn-sm" type="button" id="Cancel" name="Cancel" value="Cancel"> --->
                <input class="btn btn-primary btn-sm" type="Submit" name="Submit" value="Submit">
              </div>
            </form>
          </div>
        </div>

      </cfoutput>

    </div>
    <!--- End edit form --->
    <!--- Art details --->
    <div class="col-sm-12 col-md-11 col-lg-11 col-lg-offset-1 art_details table-responsive pull-right" id="datatable" style="display: none;">
      <input type="text" name="search" class="search pull-right" id="search" placeholder="Search...">
      <table id="artlist" class="table table-striped table-bordered" cellspacing="0" width="100%">
        <thead>
          <tr>
            <th>S.No.</th>
            <th style="display: none;">Art</th>
            <th>Name</th>
            <th>Description</th>
            <th>Added On</th>
            <th>Public</th>
          </tr>
        </thead>
        <tbody>

          <cfset counter = 1/>
          <cfoutput query="VARIABLES.artList.art" >

            <tr class="tableRow">
              <td>#counter#</td>
              <td style="display: none; background-color: lightgray;"><img src="#VARIABLES.artList.art.ImageFile#" height="250" width="250"></td>
              <td>#VARIABLES.artList.art.ImageName#</td>
              <td>#VARIABLES.artList.art.ImageDescription#</td>
              <td>#VARIABLES.artList.art.CreatedOn#</td>
              <td class="text-center">
                <input type="checkbox" class="checkbox" name="Status" value="1" id="#VARIABLES.artList.art.ImageId#" <cfif VARIABLES.artList.art.ImageStatus EQ 1 > checked="checked" </cfif> onclick="changeStatus('#VARIABLES.artList.art.ImageId#')" >
              </td>
            </tr>

            <cfset counter = counter+1/>
          </cfoutput>

        </tbody>
      </table>
    </div>
    <!--- End art details --->
    <!--- art details YUI Data table --->
    <div class="col-sm-12 col-md-11 col-lg-11 col-lg-offset-1 artyui_details table-responsive pull-right" id="datatable" style="display: none;">

      <cfset jsonobj = []/>
      <cfoutput query="VARIABLES.artList.art" >
        <cfset dataobj = {}/>
        <cfset dataobj['Id'] = VARIABLES.artList.art.ImageId />
        <cfset dataobj['Name'] = VARIABLES.artList.art.ImageName />
        <cfset dataobj['Address'] = VARIABLES.artList.art.ImageFile />
        <cfset dataobj['Description'] = VARIABLES.artList.art.ImageDescription />
        <cfset dataobj['Status'] = VARIABLES.artList.art.ImageStatus />
        <cfset dataobj['CreatedOn'] = VARIABLES.artList.art.CreatedOn />
        <cfset arrayappend(jsonobj, dataobj) />
      </cfoutput>
      <cfset jsondata = serializejson(jsonobj) />

      <div id="myContainer" class="myContainer yui-skin-sam"></div>
    </div>
    <!--- End YUI Datatable --->
  </div>
  <!--- end Right side --->

</div>

<!--- include files --->
<!--- <script src="./assets/vendor/jquery/jquery.min.js"></script> --->
<script src="./assets/vendor/popper/popper.min.js"></script>
<script src="./assets/vendor/jquery/jquery.min.js"></script>
<script src="./assets/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.17.0/jquery.validate.min.js"></script>
<!--- <script src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js"></script> --->
<script type="text/javascript" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<!--- jquery datatable plugins --->
<script type="text/javascript" src="./assets/vendor/DataTables/datatables.min.js"></script>
<!--- custom Js --->
<script src="./assets/js/validation.js"></script>
<script src="./assets/js/updateStatus.js"></script>
<script src="./assets/js/hideShow.js"></script>
<script src="./assets/js/form.js"></script>
<script>
  $(document).ready(function(){
    $.noConflict();
    var dtable = $('#artlist').DataTable({
      "dom": 't',
      "dom": 'p',
      "pagingType": "simple",
      "dom": "dt-responsive"
      });
    $('#search').keyup(function(){
      dtable.search($(this).val()).draw() ;
      });
  // });

/* Formatting function for row details - modify as you need */
function format ( d ) {
    // `d` is the original data object for the row
    return '<div style="text-align:center;">' +d[1]+ '</div>';
}
  // Add event listener for opening and closing details
    $('#artlist tbody').on('click', 'td', function () {
        var tr = $(this).closest('tr');
        var row = dtable.row( tr );

        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
            tr.css("background-color", "");
        }
        else {
            // Open this row
            row.child( format(row.data()) ).show();
            tr.addClass('shown');
            tr.css("background-color", "lightblue");
        }
    } );
} );
</script>
<!--- *************** DataTable constructor(YUI) ******************** --->
<!-- Dependencies -->
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
<!--  Data table-->
<script src="http://yui.yahooapis.com/2.9.0/build/datatable/datatable-min.js"></script>
<!--- paginator --->
<script src="http://yui.yahooapis.com/2.9.0/build/paginator/paginator-min.js"></script>
<script>jsdata = eval(<cfoutput>#jsondata#</cfoutput>);</script>
<script src="./assets/js/yuiTable.js"></script>
<!--- *************** END YUI ******************** --->

<cfelse>
  <div id="" class="text-center" ><h3>Invalid Session.</h3></div>
  <cfexit>
</cfif>
