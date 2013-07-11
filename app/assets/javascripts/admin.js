$(document).ready(function(){

  $('.delete_card_image').on("ajax:success", function(e) {
    e.preventDefault();
    $(this.parentElement).remove();
  });
});
