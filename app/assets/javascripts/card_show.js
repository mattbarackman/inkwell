$(document).ready(function() {
  $('.small-1 img').on('mouseover', function() {
    var newSrc = $(this).attr('src');
    console.log(newSrc);
    newSrc = newSrc.replace("thumb","full");
    $(".small-4 img").attr("src", newSrc);
  });

  $('.small-1 img').on('mouseout', function() {
    var defaultSrc = $(".small-4").attr("data-default");
    console.log(defaultSrc);
    $(".small-4 img").attr("src", defaultSrc);
  });
});
