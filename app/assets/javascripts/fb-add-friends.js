var modal = (function(){
  var 
  method = {},
  $overlay,
  $modal,
  $content,
  $close;

  // Center the modal in the viewport
  method.center = function () {
    var top, left;

    top = (Math.max($(window).height() - $modal.outerHeight(), 0) / 2) -100;
    left = Math.max($(window).width() - $modal.outerWidth(), 0) / 2;

    $modal.css({
      top:top + $(window).scrollTop(),
      left:left + $(window).scrollLeft()
    });
  };

  // Open the modal
  method.load = function (settings) {
    $content.empty().append(settings.content);

    $modal.css({
      width: settings.width || 'auto', 
      height: settings.height || 'auto'
    });

    method.center();
    $(window).bind('resize.modal', method.center);

  };

  method.show = function() {
    $modal.animate({opacity: 1.0});
    $modal.css('z-index', '1000');
    $overlay.animate({opacity: 0.5});
    $overlay.css('z-index', '1000');
  };

  // Close the modal
  method.close = function () {
    $modal.animate({opacity: 0.0, 'z-index': -1000});
    $overlay.animate({opacity: 0.0, 'z-index': -1000});
    sidebar.refreshOrders();
  };

  // Generate the HTML and add it to the document
  $overlay = $('<div id="fb-overlay"></div>');
  $modal = $('<div id="fb-modal"></div>');
  $content = $('<div id="fb-content"></div>');
  $close = $('<a id="fb-close" href="#">close</a>');

  $modal.css('opacity', '0.0');
  $modal.css('z-index', '-1000');
  $overlay.css('opacity', '0.0');
  $overlay.css('z-index', '-1000');
  $modal.append($content, $close);

  $(document).ready(function(){
    $('body').append($overlay, $modal);
  });

  $close.click(function(e){
    e.preventDefault();
    method.close();
    if ($('.side_bar').length === 0){
      location.reload();
    }
  });
  return method;
}());


var AddUser = {

  init: function() {

    $('body').on('click', '.facebook-friend-picture', this.addFriend);
    
    function allFriendData(html) {
      $.ajax({
        url: '/friends/facebook',
        method: 'get',
        success: html
      });
    };

    modal.load({content: '<img src="/assets/spinner.gif" style="margin: 40%;">', height: '570', width: '600' });

    $('.facebook-add-friends-link').on('click', function(e){
      e.preventDefault();
      modal.show();

      allFriendData(function(results){
        $('#fb-content').html(results);
      });
    });
  },

  addFriend: function() {
    $.post('/friends/facebook', $(this).parent().serialize());
    $(this).parent().animate({opacity: "0.3"});
  
  }
}



$(document).ready(function(){
  AddUser.init();
});

