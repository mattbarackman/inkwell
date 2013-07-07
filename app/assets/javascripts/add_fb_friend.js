var AddUser = {

  init: function() {
    $('body').on('click', '.add-fb-friend-form', this.addFriend);
    console.log('hi!');
    $('.add-fb-friends-link').on('click', this.showFriendsForm);
  },

  addFriend: function() {
    console.log('this');
    $.post('/friends/facebook', $(this).serialize());
    $(this).parent().animate({opacity: "0.5"});
  }
}


$(document).ready(function(){
  AddUser.init();
});
