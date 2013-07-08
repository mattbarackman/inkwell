//= require jquery.ui.draggable
//= require jquery.ui.droppable

function UpcomingQueue() {
    this.occasions = [];
}

UpcomingQueue.prototype = {};

function ShoppingCart() {
    this.occasions = [];
}

ShoppingCart.prototype = {};

cartRenderer = {};

queueRenderer = {};

$(document).ready(function() {
    var cart = new ShoppingCart();
    var queue = new UpcomingQueue();
    $.get("/occasions/js", function(data) {
        cart.occasions = data.future;
        queue.occasions = data.upcoming;
    });

    $( ".card img" ).draggable({ helper: "clone" });
    $(".occasion_partial").droppable({
        accept: ".card img",
        drop: function(e, ui) {
            console.log(e);
            console.log(ui);
        }
    });
})
