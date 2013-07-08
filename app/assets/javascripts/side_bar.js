$(document).ready(function() {
  $('#add_occasion_button').on('click', function() {
    $(this).hide();
    $('.add_occasion form input[type=text]').val("");
    $('.add_occasion form').show();
  });

  $('#submit_form').on("ajax:complete", function(e, xhr) {
    console.log(xhr);
    $('#add_occasion_button').show();
    $('.add_occasion form').hide();
    var object = $(xhr.responseText);
    $('.pending_orders').append(object);
  });

});
