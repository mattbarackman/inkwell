$(document).ready(function (){

    $("#addBar").scrollspy({
        min: $("#addBar").offset().top-55,
        max: 9999999,
        onEnter: function(element, position) {
            $("#addBar").addClass("locked");
        },
        onLeave: function(element, position) {
            $("#addBar").removeClass("locked");
        }
    });


});



