var OccasionForm = {

  init: function() {
    this.occasion = $('.add_occasion form');
    this.fancyBox();
    this.setAutocomplete();
    $('#submit_form').on("ajax:success", this.addResponse);
  },

  fancyBox: function() {
    var self = this; 
    $('#add_occasion_button').fancybox({
      content: self.occasion.show()
    });
  },

  setAutocomplete: function() {
    $('#occasion_friend_name').autocomplete({
      appendTo: '#autocomple-results',
      source: $('#occasion_friend_name').data('autocomplete-source')
    });
  },

  addResponse: function(e, response) {
    $('.pending_orders').prepend(response);
    $.fancybox.close();
    $('#submit_form').find('input[type="text"]').val('');
  }

};

$(document).ready(function() {
  OccasionForm.init();
  $('.add_occasion form').hide();
});
