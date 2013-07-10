//= require jquery.ui.draggable
//= require jquery.ui.droppable

function Occasion(occasion) {
    this.occasion = occasion;
    this.DOM = this.domify();
}

Occasion.prototype = {

    domify: function() {

        result = "<div class='occasion_partial'>";
        result += "<div class='event_title jquery-shadow jquery-shadow-standard'><h1>" + this.occasion.name + "</h1>";
        result += "<div class='event_name_date'>" + this.occasion.date + "</div></div>";
        result += "<div class='event_card_container jquery-shadow jquery-shadow-lifted'>";

        if (this.occasion.image_url === undefined) {
          result += "<div class='event_card'><h1>Drag card</h1><h1>here</h1></div>";
        } else {
          result += "<div class='event_card'><img src='" + this.occasion.image_url + "'></div>";
        }
        result += "</div></div>";
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

    render: function() {
        $(".shopping_cart .occasion_partial").detach();
        for (var i in this.occasions) {
            $(".shopping_cart").append(this.occasions[i].DOM);
        }
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

function extractOrderData($partial) {
    
}

SideBar.prototype = {

    refreshOrders: function() {
        this.cart = new ShoppingCart();
        this.queue = new UpcomingQueue();
        var that = this;
        $.get("/orders/js", function(data) {
            for (var i in data.not_purchased_orders) {
                that.queue.addItem( new Occasion(data.not_purchased_orders[i]) );
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
                //Note: need the -1 due to header... may go away later
                var index = $(this).index();
                var newImage = card.helper.find('img')[0];
                var replacedImage = $(this).find('.event_card').html(newImage);
                $(replacedImage).hide();
                $(replacedImage).fadeIn();
                var occasion = sidebarOverLord.queue.occasions[index];
                var cardNumber = card.draggable.find('img').attr('class').split(' ')[0];
                occasion.associateCard(cardNumber);
                $.post("/orders/js", occasion.occasion);
                // sidebarOverLord.render();
            }
        });
    }
};

$(document).ready(function() {
    sidebar = new SideBar();
    $( ".draggable_card" ).draggable({ helper: "clone",
        start: function(e, ui)
        {
          $(e.target).css('opacity', '0');
          $(ui.helper).addClass('cardclone');
        },
        stop: function(e, ui)
        {
          $(e.target).animate({
            opacity: 1
          }, 3000);
        }
  });

});
