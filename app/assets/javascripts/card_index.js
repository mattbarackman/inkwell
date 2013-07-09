$(document).ready(function() {
  $('li img').hover(function(e) {
    var y_coord = $(this).offset().top - $(window).scrollTop();

    mid_point = window.innerHeight / 2;

    console.log(y_coord + "|" + mid_point);

    if (y_coord <= mid_point){

      $(this).parent().children('.pop-up').fadeIn()
        .css('z-index', 1000)
        .css('position', 'absolute')
        // .css('top', y_coord + 120);
        // .css('left', e.pageX)
        // .appendTo(this);


    } else {

      // $(this).parent().children('.pop-up').fadeIn()
      //   .css('z-index', 1000)
      //   .css('position', 'absolute');

    }


  }, function() {
    $(this).parent().children('.pop-up').fadeOut();
  });
});
