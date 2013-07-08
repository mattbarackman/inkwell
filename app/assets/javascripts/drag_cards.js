//= require jquery.ui.draggable
//= require jquery.ui.droppable

function Occasion(occasion) {
    this.occasion = occasion;
    this.DOM = this.domify();
}

Occasion.prototype = {

    domify: function() {
        result = "<div class='occasion_partial'><ul>";
        result += "<li>" + this.occasion.name + "</li>";
        result += "<li>For: " + this.occasion.friend + "</li>";
        result += "<li>On: " + this.occasion.date + "</li></ul></div>";
        //code for card, price
        return result;
    },

    associateCard: function(card_number) {
        this.occasion.card_id = card_number;
    }

};

function UpcomingQueue() {
    this.occasions = [];
}

UpcomingQueue.prototype = {

    render: function() {
        $(".pending_orders .occasion_partial").detach();
        for (i in this.occasions) {
            $(".pending_orders").append(this.occasions[i].DOM);
        }
    },

    removeItem: function(index) {
        result = this.occasions.splice(index,1);
        return result;
    },

    addItem: function(occasion) {
        this.occasions.push(occasion);
    }
};

function ShoppingCart() {
    this.occasions = [];
}

ShoppingCart.prototype = {

    calculateTotal: function() {},

    render: function() {
        $(".shopping_cart .occasion_partial").detach();
        for (i in this.occasions) {
            $(".shopping_cart").append(this.occasions[i].DOM);
        }
        //Calculate price
    },

    addItem: function(occasion) {
        this.occasions.push(occasion);
    }
};

function SideBar() {
    this.cart = new ShoppingCart();
    this.queue = new UpcomingQueue();
    this.getOrders();
}

SideBar.prototype = {

    getOrders: function() {
        that = this
        $.get("/orders/js", function(data) {
            for (i in data.future) {
                that.cart.addItem( new Occasion(data.future[i]) );
            }
            for (i in data.upcoming) {
                that.queue.addItem( new Occasion(data.upcoming[i]) );
            }
            that.render();
        });
    },

    render: function() {
        this.cart.render();
        this.queue.render();
        this.makeDroppable();
    },

    makeDroppable: function() {
        var sidebarOverLord = this;

        $(".pending_orders .occasion_partial").droppable({
            accept: ".card img",
            drop: function(e, card) {
                //Note: need the -1 due to header... may go away later
                var index = $(this).index() - 1;

                var moved = sidebarOverLord.queue.removeItem(index)[0];
                console.log(moved);
                var cardNumber = card.draggable.attr('class').split(' ')[0];
                console.log(cardNumber);

                moved.associateCard(cardNumber);
                console.log(moved);
                sidebarOverLord.cart.addItem(moved);
                
                sidebarOverLord.render();
            }
        });
    }
}

$(document).ready(function() {
    var sidebar = new SideBar();

    $( ".card img" ).draggable({ helper: "clone" });
})
