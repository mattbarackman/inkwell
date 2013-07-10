$(document).ready(function(){
  $('.jcarousel_test').jcarousel({
      'list': '.pending_orders',
      'items': '.occasion_partial',
      'vertical': true,
      'wrap': 'circular'
  });

  $('.scrollup').on('mouseover', function(e){
    e.preventDefault();
    $('.jcarousel_test').jcarousel('scroll', '-=1');
  });

  $('.scrolldown').on('mouseover', function(e){
    e.preventDefault();
    $('.jcarousel_test').jcarousel('scroll', '+=1');
  });
});
