<!---
* File: login.cfm
* Author: Mohit Dadu
* Purpose: for login and registration.
* Date: 09/04/2017
--->

<cfif structKeyExists(SESSION, 'user')>
  <cflocation url="index.cfm?event=home" addtoken="false"/>
</cfif>

<div class="main">
  <div class="header" >
    <h1>Login or Create New Account!</h1><hr>
  </div>

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
      <h2>New Account:</h2>
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
      <h3>Login:</h3>
      <ul>
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
    </form>

  </div>
  <div class="clear"> </div>
</div>
