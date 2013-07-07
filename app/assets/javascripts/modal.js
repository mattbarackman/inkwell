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

      top = Math.max($(window).height() - $modal.outerHeight(), 0) / 2;
      left = Math.max($(window).width() - $modal.outerWidth(), 0) / 2;

      $modal.css({
        top:top + $(window).scrollTop(), 
        left:left + $(window).scrollLeft()
      });
    };

    // Open the modal
    method.open = function (settings) {
      $content.empty().append(settings.content);

      $modal.css({
        width: settings.width || 'auto', 
        height: settings.height || 'auto'
      });

      method.center();
      $(window).bind('resize.modal', method.center);
      $modal.show();
      $overlay.show();
    };

    // Close the modal
    method.close = function () {
      $modal.hide();
      $overlay.hide();
      $content.empty();
      $(window).unbind('resize.modal');
    };

    // Generate the HTML and add it to the document
    $overlay = $('<div id="overlay"></div>');
    $modal = $('<div id="modal"></div>');
    $content = $('<div id="content"></div>');
    $close = $('<a id="close" href="#">close</a>');

    $modal.hide();
    $overlay.hide();
    $modal.append($content, $close);

    $(document).ready(function(){
      $('body').append($overlay, $modal);                     
    });

    $close.click(function(e){
      e.preventDefault();
      method.close();
    });
    
    $('.add-fb-friend-form').on('click', function(e){
      e.preventDefault();
      console.log(e);
      console.log(this);
    });
    return method;
  }());

// Wait until the DOM has loaded before querying the document
$(document).ready(function(){

  $('#facebook-add-friends-link').click(function(e){
    e.preventDefault();

    $.get('/friends/facebook', function(data){
      var friendData = '';

      data.forEach(function(friend){
        var birthday = friend['birthday'];
        if(birthday === undefined) {
          birthday = '';
        }

        friendData += '<div class="facebook-friend">';
        friendData += '<form action="/friends/facebook" method="post" class="add-fb-friend-form">';
        friendData += '<img class="facebook-friend-picture" src="' + friend['picture']['data']['url'] + '">';
        friendData += '<ul><li><input type="text" name="name" value="' + friend['name'] + '">' + '</li>';
        friendData += '<li><input type="text" name="birthday" value="' + birthday + '">' + '</li></ul>';
        friendData += '<input type="submit"></form></div>';
      });

      modal.open({content: friendData });
    });
    
  });
});
