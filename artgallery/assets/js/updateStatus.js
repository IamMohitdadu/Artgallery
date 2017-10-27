/**
* File    : updateStatus.js
* Purpose : Update status.
* Created : 09/14/2017
* Author  : Mohit Dadu
*/

  $(document).ready(function(){

      // update active status for arts.
      $('.art_checkbox').on('change',function() {
        // alert($('input:checkbox').val());
          $.ajax({
              type: "POST",
              datatype: 'json',
              // url: 'index.cfm?event=updateArtStatus&artId='+$(this).attr('id'),
              url: './model/artgalleryService.cfc?method=updateArtStatus',
              data: {'artId': $(this).attr('id'),
                     'status': $('input:checkbox').val() },
              success: function(data) {
                  alert(data);
              },
               error: function() {
                  alert('cannot update now try again later.');
              }
          });  //end ajax
          return false;

      }); //end

  });