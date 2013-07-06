var AddUser = {

  init: function() {
    $('add-fb-friend-form').on('ajax:success', this.addFriend);
  },

  addFriend: function(e, data) {
    console.log('data')
  }



}




$(document).ready(function(){
  AddUser.init();
});
