function Occasion() {}

Occasion.prototype = {}

function UpcomingQueue() {
    this.occasions = [];
}

UpcomingQueue.prototype = {}

function ShoppingCart() {
    this.occasions = [];
}

ShoppingCart.prototype = {}

function getOccasions() {
    $.get("/occasions/js", function(data) {
        console.log(data);
    });
}

$(document).ready(function() {
    getOccasions();
})
