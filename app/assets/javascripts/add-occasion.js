var Occasion = {
  init: function() {
    this.occasion = $('.add_occasion form');
    this.fancybox();
    this.setAutocomplete();
    $('#submit_form').on("ajax:success", this.addResponse);

  },

  fancybox: function() {
    var self = this;
    $('#add_occasion_button').fancybox({
      content: self.occasion.show()
    });
  },

  setAutocomplete: function() {
    $('#occasion_friend_name').autocomplete({
      appendTo: '#autocomple-results',
      source: ['foo', 'food', 'fooker', 'foomazing']
    });
  },

  addResponse: function(e, xhr) {
    $('.pending_orders').prepend(xhr);
    $.fancybox.close();
  }
}

$(document).ready(function() {
  Occasion.init();
});
