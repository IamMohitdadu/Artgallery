    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="index.cfm?event=home">ART GALLERY</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="index.cfm?event=home"><i class="fa fa-home" aria-hidden="true"></i>&nbsp Home</a>
            </li>

            <!--- check for available session --->
            <cfif structKeyExists(SESSION, 'USER') >
              <li class="nav-item ">
                <a class="nav-link" href="index.cfm?event=addart"><i class="glyphicon glyphicon-pencil" aria-hidden="true" ></i>Add New Image</a>
              </li>
              <li class="nav-item ">
                <a class="nav-link" href="index.cfm?event=gallery&UserId=<cfoutput>#SESSION.USER['USERID']#</cfoutput>"><i class="fa fa-user" aria-hidden="true">&nbsp <cfoutput>#SESSION.USER['NAME']#</cfoutput></i></a>
              </li>

              <li class="nav-item">
                <a class="nav-link" href="index.cfm?event=logout"><i class="fa fa-power-off" aria-hidden="true"></i>&nbsp logout</a>
              </li>
            <cfelse>
              <li class="nav-item">
                <a class="nav-link" href="index.cfm?event=login"><i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp Login/Create New Account</a>
<!---               </li>
              <li class="nav-item">
                <a class="nav-link" href="index.cfm?event=login"><i class="fa fa-user" aria-hidden="true"></i>&nbsp Create New Account</a>
              </li> --->
<!---               <li class="nav-item">
                <a class="nav-link" data-toggle="modal" data-target="#login_modal"><i class="fa fa-sign-in" aria-hidden="true"></i>&nbsp Login</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" data-toggle="modal" data-target="#register_modal" ><i class="fa fa-user" aria-hidden="true"></i>&nbsp Create New Account</a>
              </li> --->
            </cfif>

          </ul>
        </div>
      </div>
    </nav>