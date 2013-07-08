// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require fancybox
//= require foundation
//= require_tree .

$(document).foundation();

$(document).ready(function() {
  $('.add_occasion button').on('click', function() {
    $('.add_occasion button').hide();
    $('.add_occasion form input[type=text]').val("");
    $('.add_occasion form').show();
  });

  $('#submit_form').on("ajax:complete", function(e, xhr) {
    console.log(xhr);
    $('.add_occasion button').show();
    $('.add_occasion form').hide();
    var object = $(xhr.responseText);
    $('.pending_orders').append(object);
  });

});
