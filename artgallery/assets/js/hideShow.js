/**
* File    : hideShow.js
* Purpose : To hide/show form and buttons.
* Created : 10/25/2017
* Author  : Mohit Dadu
*/

  $(document).ready(function(){

      // remove edit form and cancle the update profile.
      $("#Cancel").click(function(){
          $("div .EditProfileDetails").hide();
          $("#EditProfile").show();
          $("#ChangeImage").show();
      });  //end

      // Show edit profile form and Hide buttons while click edit button
      $("#EditProfile").click(function(){
          $("div .EditProfileDetails").show();
          $("#EditProfile").hide();
          $("#ChangeImage").hide();
      });  //end

  });