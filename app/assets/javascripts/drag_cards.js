//= require jquery.ui.draggable
//= require jquery.ui.droppable

function Occasion(occasion, index) {
    this.occasion = occasion;
    this.index = index;
    this.DOM = this.domify();
}

Occasion.prototype = {

    domify: function() {
        result = "<div class='occasion_partial' name='" + this.index + "'>";
        result += "<div class='event_title jquery-shadow jquery-shadow-standard'>"

        if (this.occasion.friend_image_url !== undefined) {
            result += "<img class='occasion_image' src='" + this.occasion.friend_image_url + "'>";
        } 
        result += "<h1>" + this.occasion.name + "</h1>";
        result += "<div class='event_name_date'>" + this.occasion.date + "</div></div>";
        result += "<div class='event_card_container jquery-shadow jquery-shadow-lifted'>";

        if (this.occasion.image_url === undefined) {
          result += "<div class='event_card'><h1>Drag card</h1><h1>here</h1></div>";
        } else {
          result += "<div class='event_card'><img class='carousel_image' src='" + this.occasion.image_url + "'></div>";
        }
        result += "</div></div>";
        //code for card, price
        return result;
    },

    associateCard: function(card_number) {
        this.occasion.card_id = card_number;
    },

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

SideBar.prototype = {

    refreshOrders: function() {
        this.cart = new ShoppingCart();
        this.queue = new UpcomingQueue();

        var that = this;
        $.get("/orders/js", function(data) {
            for (var i in data.not_purchased_orders) {
                that.queue.addItem( new Occasion(data.not_purchased_orders[i], i) );
            }
            that.render();

            $('.jcarousel_test').jcarousel('reload');
        });

    },

    render: function() {
        this.cart.render();
        this.queue.render();
        this.makeDroppable();
        this.renderCheckout();
    },

    addOccasion: function() {
        $('#submit_form').find('input[type="text"]').val('');
        console.log("Got Here!");
        console.log(login);
        $("#occasion_date").datepicker("destroy");
        login.softclose();
        this.refreshOrders();
    },

    renderCheckout: function() {
        var totalOrders = $('.event_card').find('img').length;

        if (totalOrders > 0) {
            $('.checkout').html('<a href="/checkout">Checkout (' + $(".event_card").find(".carousel_image").length + ')</a>');
            $('.checkout').siblings().first().show();
        }
    },

    makeDroppable: function() {
        var sidebarOverLord = this;

        $(".pending_orders .occasion_partial").droppable({
            accept: ".draggable_card",
            drop: function(e, card) {
                var index = $(this).attr('name');

                var newImage = card.helper.find('img')[0];
                var replacedImage = $(this).find('.event_card').html(newImage);
                $(replacedImage).hide();
                $(replacedImage).fadeIn();
                sidebarOverLord.renderCheckout();

                var occasion = sidebarOverLord.queue.occasions[index];
                var cardNumber = card.draggable.find('img').attr('class').split(' ')[0];
                occasion.associateCard(cardNumber);

                $.post("/orders/js", occasion.occasion);
            }
        });
    }
};

$(document).ready(function() {
    $('.each-card-display').shadow('lifted');
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
