/**
* File    : Validation.js
* Purpose : Validate user login and registration.
* Created : 09/14/2017
* Author  : Mohit Dadu
*/

$(document).ready(function(){

    /**
    * Function to validate registration data
    * @param null.
    * @return error messages if found.
    */
    $("#register").validate({
        rules: {
            Name: {
                required: true,
                minlength: 3
            },
            Address: {
                required: true,
                minlength: 5
            },
            Email: {
                required: true,
                email: true
            },
            Contact: {
                required: true,
                minlength: 10,
                maxlength:10
            },
            Password: {
                required: true,
                minlength: 8
            }
        },
        messages: {
            Name: {
                required: "Please enter name",
                minlength: "Name should be of minimum 3 characters"
            },
            Address: {
                required: "Please enter  your address(state/country)",
                minlength: "Address should be of minimum 5 characters"
            },
            Email: {
                required: "Please enter Email",
                email: "Enter a valid Email"
            },
            Contact: {
                required: "Please enter the phone Number",
                minlength: "Phone Number must be of minimum 10 digits",
                maxlength: "Phone Number must be of maximum 10 digits"
            },
            Password: {
                required: "Please enter Password",
                minlength: "Password should be of minimum 8 characters"
            }
        }
    });

    /**
    * Function to validate login data.
    * @param null.
    * @return error messages if found.
    */
    $("#login").validate({
        ignore: ".ignore",
        rules: {
            Email: {
                required: true,
                email: true
            },
            Password: {
                required: true,
                minlength: 8
            },
            "hiddenRecaptcha": {
                 required: function() {
                     if(grecaptcha.getResponse() == '') {
                         return true;
                     } else {
                         return false;
                     }
                 }
            }
        },
        messages: {
            Email: {
                required: "Please enter Email",
                email: "Enter a valid Email"
            },
            Password: {
                required: "Please enter Password",
                minlength: "Password should be of minimum 8 charecters"
            },
            hiddenRecaptcha: {
                required: "Please verify the captcha."
            }
        },
        // submitHandler: function(form) {
        //     $(form).ajax({
        //         url: 'index.cfm?event=loginProcess',
        //         data: $('form').serialize(),
        //         type:"post",
        //         success: function(data,status){
        //           alert(data);
        //         }
        //     });
        //     return false;
        // }
    });

        /**
    * Function to validate PROFILE data
    * @param null.
    * @return error messages if found.
    */
    $("#updateProfile").validate({
        rules: {
            Name: {
                required: true,
                minlength: 3
            },
            Address: {
                required: true,
                minlength: 5
            },
            Contact: {
                required: true,
                minlength: 10,
                maxlength:10
            }
        },
        messages: {
            Name: {
                required: "Please enter Name",
                minlength: "Name should be of minimum 3 characters"
            },
            Address: {
                required: "Please enter Address",
                minlength: "Address should be of minimum 5 characters"
            },
            Contact: {
                required: "Please enter Contact Number",
                minlength: "Phone Number must be of minimum 10 digits",
                maxlength: "Phone Number must be of maximum 10 digits"
            }
        }
    });

        /**
    * Function to validate art details
    * @param null.
    * @return error messages if found.
    */
    $("#addNewImage").validate({
        rules: {
            ImageName: {
                required: true,
                minlength: 3
            },
            ImageDescription: {
                required: true,
                maxlength: 50
            },
            Image: {
                required: true,
                accept: "image/jpeg"
            }
        },
        messages: {
            ImageName: {
                required: "Please enter Name",
                minlength: "Name should be of minimum 3 characters"
            },
            ImageDescription: {
                required: "Please enter Description",
                maxlength: "Description should be of less than 50 characters"
            },
            Image: {
                required: "Please select Image File",
                accept: "image must be image/jpeg format"
            }
        }
    });

        /**
    * Function to validate user profile image
    * @param null.
    * @return error messages if found.
    */
    $("#ChangeImage").validate({
        rules: {
            Image: {
                required: true,
                accept: "image/jpeg"
            }
        },
        messages: {
            Image: {
                required: "Please select Image File",
                accept: "image must be image/jpeg format"
            }
        }
    });

});