/**
* File: form.js
* Author: Mohit Dadu
* Date: 10/25/2017
**/


/**
 *
 * @param {imageid} Id of the art.
 * @return false.
 */

function changeStatus(ImageId){
    var Data = {'ImageId': ImageId };

    $.ajax({
        type: "POST",
        datatype: "JSON",
        url: "index.cfm?event=updateImageStatus",
        data: Data,
        success: function (data){
        },
        error: function (xhr, ajaxOptions, thrownError){
        }
    });
    return false;
}