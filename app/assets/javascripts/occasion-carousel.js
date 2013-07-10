$(document).ready(function(){
  $('.jcarousel_test').jcarousel({
      'list': '.pending_orders',
      'items': '.occasion_partial',
      'vertical': true,
      'wrap': 'circular',
      'auto': 10,
      'animation': 'slow'

  });

  $('.scrollup').on('click', function(e){
    e.preventDefault();
    $('.jcarousel_test').jcarousel('scroll', '+=1');
  });

  $('.scrolldown').on('click', function(e) {
    e.preventDefault();
    var Scroll = function(){
      $('.jcarousel_test').jcarousel('scroll', '-=1');
      setTimeout(function(e){
      Scroll();
      console.log(e);
    }, 1000);
    }();
  });

});
