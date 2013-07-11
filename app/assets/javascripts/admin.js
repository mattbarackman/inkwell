$(document).ready(function(){

  $('.delete_card_image').on("ajax:success", function(e) {
    e.preventDefault();
    $(this.parentElement).remove();
  });

  $('.delete_card_button').on("ajax:success", function(e) {
    e.preventDefault();
    this.parentElement.remove();
  });

  $('.add_tag_form').on("ajax:success", function(e) {
    e.preventDefault();
  });
});
