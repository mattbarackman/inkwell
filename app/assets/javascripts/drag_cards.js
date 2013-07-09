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
    },

    updateOnServer: function() {

    }

};

function UpcomingQueue() {
    this.occasions = [];
}

UpcomingQueue.prototype = {

    render: function() {
        $(".pending_orders .occasion_partial").detach();
        for (var i in this.occasions) {
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
        for (var i in this.occasions) {
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
    this.form = new OccasionForm();
    $('#submit_form').on("ajax:success", null, this, 
                         function(e) { e.data.addOccasion(); });
    this.refreshOrders();
}

SideBar.prototype = {

    refreshOrders: function() {
        this.cart = new ShoppingCart();
        this.queue = new UpcomingQueue();
        var that = this;
        $.get("/orders/js", function(data) {
            for (var i in data.future) {
                that.cart.addItem( new Occasion(data.future[i]) );
            }
            for (var i in data.upcoming) {
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

    addOccasion: function() {
        $.fancybox.close();
        $('#submit_form').find('input[type="text"]').val('');
        console.log(this);
        this.refreshOrders();
    },

    makeDroppable: function() {
        var sidebarOverLord = this;

        $(".pending_orders .occasion_partial").droppable({
            accept: ".draggable_card",
            drop: function(e, card) {
                console.log(card);
                //Note: need the -1 due to header... may go away later
                console.log(this);
                var index = $(this).index() - 1;

                var moved = sidebarOverLord.queue.removeItem(index)[0];
                console.log(moved);
                var cardNumber = card.draggable.find('img').attr('class').split(' ')[0];
                console.log(cardNumber);

                moved.associateCard(cardNumber);
                //console.log(moved);
                sidebarOverLord.cart.addItem(moved);
                $.post("/orders/js", moved.occasion);
                sidebarOverLord.render();
            }
        });
    }
};

$(document).ready(function() {
    var sidebar = new SideBar();
    $( ".draggable_card" ).draggable({ helper: "clone",
        start: function(e, ui)
        {
          $(e.target).css('opacity', '0');
          $(ui.helper).children('li').css('background-color', 'pink');
        },
        stop: function(e, ui)
        {
          $(e.target).animate({
            opacity: 1
          }, 3000);
        }
  });
});
