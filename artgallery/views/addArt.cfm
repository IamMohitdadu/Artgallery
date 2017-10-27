<!--
* File: addart.cfm
* Author: Add new Image.
* Date: 09/29/2017
-->

<!--- Check for session varioables --->
<cfif not structKeyExists(SESSION, 'USER') >
  <cflocation url="/artgallery/" addtoken="false">
</cfif>

<!-- Content Section -->

<div class="container">

  <cfif event.isArgDefined('success') and arguments.event.getArg('success') NEQ 'true'>
    <cfset Local.data = arguments.event.getArg('data')/>
    <cfloop array="#local.data#" index="message">
      <cfoutput><span class="fa fa-circle-sm icon-resize-small error" aria-hidden="true">#message#</span><br></cfoutput>
    </cfloop>
    <hr>
  </cfif>

  <div class="row">
    <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xs-offset-0 col-sm-offset-0 col-md-offset-1 col-lg-offset-1 toppad" >
      <div class="panel panel-info">
        <div class="panel-heading">
          <h3 class="panel-title">Add New Art</h3>
        </div>
        <div class="panel-body">
          <!--- Add New Image Form --->
          <form id="addNewImage" class="form-horizontal" method="post" enctype="multipart/form-data" action="index.cfm?event=addArtProcess">

            <cfoutput>

              <div class="modal-body ">
                <div class="form-group">
                  <label class="col-md-3" for="ImageName">Art Title</label>
                  <div class="col-md-9">
                    <input type="hidden" id="userId" name="userId" value="<cfif structKeyExists(session,'user')>#session.user['userId']#</cfif>" />
                  </div>
                  <div class="col-md-9">
                    <input type="text" id="ImageName" name="ImageName" placeholder="ART Title" class="form-control" value="<cfif arguments.event.getArg('ImageName') NEQ ''>#arguments.event.getArg('ImageName')#</cfif>" />
                  </div>
                  <div class="col-md-12">
                    <span class="error" id="imageName_error" ></span>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-3" for="ImageDescription">Image description</label>
                  <div class="col-md-9">
                    <input type="text" id="ImageDescription" name="ImageDescription" placeholder="Image Description" class="form-control" value="<cfif arguments.event.getArg('ImageDescription') NEQ ''>#arguments.event.getArg('ImageDescription')#</cfif>"/>
                  </div>
                  <div class="col-md-12">
                    <span class="error" id="imageDescription_error" ></span>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-3" for="Image">Upload Image</label>
                  <div class="col-md-9">
                    <input type="file" id="Image" name="Image" />
                  </div>
                </div>
              </div>
              <div class="modal-footer">
                <a class="btn btn-danger" href="index.cfm?event=gallery&UserId=#SESSION.USER['USERID']#"><span class="glyphicon glyphicon-pencil"></span>Cancel</a>
                <input type="submit" class="btn btn-primary" id="submit" name="submit" value="Add Art" />
              </div>

            </cfoutput>

          </form>
        </div>
      </div>
    </div>
  </div>
</div>