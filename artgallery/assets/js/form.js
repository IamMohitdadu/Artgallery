(function () {
    $('#login form').on('submit', function (e) {

        $.ajax({
        type: 'post',
        url: 'index.cfm?event=loginProcess',
        success: function () {
          alert('form was submitted');
        }
        });

        return false;

    });
});