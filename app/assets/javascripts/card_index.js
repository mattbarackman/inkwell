$(document).ready(function() {
  $('li img').hover(function(e) {
    console.log(e);
    $(this).parent().children('.pop-up').fadeIn()
      .css('z-index', 1000)
      .css('position', 'absolute');
      // .css('top', e.pageY)
      // .css('left', e.pageX)
      // .appendTo(this);
  }, function() {
    $(this).parent().children('.pop-up').fadeOut();
  });
});
