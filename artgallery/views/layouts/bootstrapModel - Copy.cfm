<!-- Modal - Register -->
<div class="modal fade" id="register_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="myModalLabel">Register</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>

        <form id="register" class="form-horizontal" method="post" action="index.cfm?event=registrationProcess">
          <div class="modal-body ">
            <div class="form-group">
              <label class="col-md-12" for="name">Name:</label>
              <div class="col-md-12">
                <input type="text" id="name" name="Name" placeholder="Name" class="form-control" />
              </div>
              <div class="col-md-12">
                <span class="error" id="name_error" ></span>
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-12" for="Address">Address:</label>
              <div class="col-md-12">
                <input type="text" id="Address" name="Address" placeholder="Address" class="form-control" />
              </div>
              <div class="col-md-12">
                <span class="error" id="Address_error" ></span>
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-12" for="contact">Phone:</label>
              <div class="col-md-12">
                <input type="number" id="contact" name="Contact" placeholder="Phone Number" class="form-control" />
              </div>
              <div class="col-md-12">
                <span class="error" id="contact_error" ></span>
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-12" for="email">Email:</label>
              <div class="col-md-12">
                <input type="email" id="email" name="Email" placeholder="Email Address" class="form-control" />
              </div>
              <div class="col-md-12">
                <span class="error" id="email_error" ></span>
              </div>
            </div>

            <div class="form-group">
              <label class="col-md-12" for=password>Password:</label>
              <div class="col-md-12">
                <input type="password" id="password" name="Password" placeholder="password" class="form-control" />
              </div>
              <div class="col-md-12">
                <span class="error" id="password_error" ></span>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            <input type="submit" name="" class="btn btn-primary" value="Submit">
          </div>
        </form>

      </div>
    </div>
</div>
<!-- // Modal -->

<!-- Modal - Login -->
<div class="modal fade" id="login_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="myModalLabel">Sign in</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>

        <form id="login" class="form-horizontal" method="post" action="index.cfm?event=loginProcess">
          <div class="modal-body ">
            <div class="form-group">
              <label class="col-md-12" for="email">Email:</label>
              <div class="col-md-12">
                <input type="email" id="email" name="Email" placeholder="Email Address" class="form-control" />
              </div>
              <div class="col-md-12">
                <span class="error" id="email_error" ></span>
              </div>
            </div>
            <div class="form-group">
              <label class="col-md-12" for=password>Password:</label>
              <div class="col-md-12">
                <input type="password" id="password" name="Password" placeholder="password" class="form-control" />
              </div>
              <div class="col-md-12">
                <span class="error" id="password_error" ></span>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            <input type="submit" name="" class="btn btn-primary" value="Submit">
            <!--- <button type="button" class="btn btn-primary" onclick="addRecord(this)">Submit</button> --->
          </div>
        </form>

      </div>
    </div>
</div>
<!-- // Modal -->
