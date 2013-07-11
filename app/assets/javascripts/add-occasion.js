function OccasionForm() {
    this.occasion = $('#submit_form');
    //this.occasion.hide();
    this.fancyBox();
    this.setAutocomplete();
}

OccasionForm.prototype = {

  fancyBox: function() {
    var self = this; 
    $('#add_occasion_button').on('click', function(e){
      e.preventDefault();
      login.open({content: self.occasion.show(), width: '320', height: '257'});
      $('#login-content').css('height', '240');
      $('#submit_form').on("ajax:success", null, this, 
                           function(e) { sidebar.addOccasion(); });
      $( "#occasion_date" ).datepicker();

    });
  },

  setAutocomplete: function() {
    $('#occasion_friend_name').autocomplete({
      appendTo: '#autocomple-results',
      source: $('#occasion_friend_name').data('autocomplete-source')
    });
  }

};

$(document).ready(function() {
  //$('#submit_form').hide();
});
