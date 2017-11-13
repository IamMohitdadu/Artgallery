<!---
* File: login.cfm
* Author: Mohit Dadu
* Purpose: for login and registration.
* Date: 09/04/2017
--->

<!--- google captcha api --->
<script src='https://www.google.com/recaptcha/api.js'></script>
<!--- google social login api --->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="302820124495-jhtl4lk92nf0jgm9fj259nbn9he8eamf.apps.googleusercontent.com">

<cfif structKeyExists(SESSION, 'user')>
  <cflocation url="index.cfm?event=home" addtoken="false"/>
</cfif>

<div class="container">
  <div class="row">
    <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xs-offset-0 col-sm-offset-0 col-md-offset-1 col-lg-offset-1 toppad" >
      <div class="panel panel-info">
        <div class="panel-heading">
          <h3 class="panel-title">Login or Create New Account!</h3>
        </div>
        <div class="panel-body">

          <!--- Registration Form --->
          <div class="left-form">

            <cfif event.isArgDefined('registration_success')>
              <cfset Local.data = arguments.event.getArg('registration_data')/>
                <cfloop array="#local.data#" index="message">
                  <cfoutput>
                    <span class="fa fa-circle-sm icon-resize-small" aria-hidden="true" style="color: red">#message#</span><br>
                  </cfoutput>
                </cfloop>
            </cfif>

            <form id="register" class="form-horizontal" method="post" action="index.cfm?event=registrationProcess">
              <h4>New Account:</h4><hr>
              <ul>
                <li>
                  <input type="text" id="name" name="Name" placeholder="Name" class="form-control" />
                  <div class="clear"> </div>
                </li>
                <li>
                  <input type="text" id="Address" name="Address" placeholder="Address" class="form-control" />
                  <div class="clear"> </div>
                </li>
                <li>
                  <input type="number" id="Contact" name="Contact" placeholder="Phone Number" class="form-control" />
                  <div class="clear"> </div>
                </li>
                <li>
                  <input type="email" id="email" name="Email" placeholder="Email Address" class="form-control" />
                  <div class="clear"> </div>
                </li>
                <li>
                  <input type="password" id="password" name="Password" placeholder="password" class="form-control" />
                  <div class="clear"> </div>
                </li>
                <input type="submit" name="" class="btn btn-primary" value="Submit">
                  <div class="clear"> </div>
                </ul>
                <div class="clear"> </div>

                <cfif event.isArgDefined('register_error') and arguments.event.getArg('register_error') NEQ ''>
                  <cfoutput>
                    <span style="color: red">#arguments.event.getArg('register_error')#</span>
                  </cfoutput>
                  <cfset arguments.event.setArg('register_error','')/>
                </cfif>

              </form>
            </div>

            <!--- Login Form --->
            <div class="right-form">

              <cfif event.isArgDefined('success') and arguments.event.getArg('success') NEQ 'true'>
                <cfset Local.data = arguments.event.getArg('data')/>
                <cfloop array="#local.data#" index="message">
                  <cfoutput><span class="fa fa-circle-sm icon-resize-small" aria-hidden="true" style="color: red">#message#</span></cfoutput>
                </cfloop>
              </cfif>

              <form id="login" class="form-horizontal" method="post" action="index.cfm?event=loginProcess">
                <h4>Login:</h4><hr>
                <ul>
                  <li>
                    <input type="email" id="email" name="Email" placeholder="Email Address" class="form-control" />
                    <div class="clear"> </div>
                  </li>
                  <li>
                    <input type="password" id="password" name="Password" placeholder="password" class="form-control" />
                    <div class="clear"> </div>
                  </li>
                  <li>
                    <div class="g-recaptcha" data-sitekey="6LdyWTcUAAAAAMHaPqDwy0PS0nVln8Cg_OWSVmQe"></div>
                    <input type="hidden" class="hiddenRecaptcha required" name="hiddenRecaptcha" id="hiddenRecaptcha">
                  </li>
                  <input type="submit" name="" class="btn btn-primary" value="Submit">
                  <div class="clear"> </div>
                </ul>
                <div class="clear"> </div>
              </form>
            </div>
          </div>
        </div>
        <div class="clear"> </div>
        <div class="g-signin2" data-onsuccess="onSignIn"></div>

    </div>
  </div>
</div>