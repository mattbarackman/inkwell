$(document).ready(function() {

  var occasionBox = $('.occasion_friend_name').autocomplete({
    minLength: 0,
    source: ['foo', 'bar', 'baaar', 'bad']
  });

  $('#add_occasion_button').fancybox({
    // $('.add_occasion form input[type=text]').val("");
    content: $('.add_occasion').html()
  });

  $('#submit_form').on("ajax:complete", function(e, xhr) {
    console.log(xhr);
    $('#add_occasion_button').show();
    $('.add_occasion form').hide();
    var object = $(xhr.responseText);
    $('.pending_orders').append(object);
    occasionBox.close();
  });

});
