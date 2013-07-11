namespace :etsy do
  desc "get cards" 
  task :refresh_production => :environment do

    shop_owners = ["jdeluce", "sarahparrott825", "CatherineMcginniss", "papillonpress", "kissandpunch", "Benchpressed", "McBittersonsShop"]

    p "#################################"
    p "#################################"

    current_listings = []

    shop_owners.each do |owner|
      p "#################################"
      p "#################################"
      p owner
      shop = Etsy.user(owner).shop
      shop.listings.each do |listing|
        
        company_name = shop.title
        company_url = shop.url
        title = listing.title
        inventory = listing.quantity
        description = listing.description
        price = ((listing.price.to_f)*100).round
        listing_id = listing.result["listing_id"]
        
        current_listings << listing_id

        card = Card.find_by_listing_id(listing_id)
        
        if card
          card.update_attributes(price: price, inventory: inventory)
        else
          card = Card.create(title: title, 
                      description: description, 
                      inventory: inventory, 
                      company_url: company_url,
                      company_name: company_name, 
                      price: price, 
                      listing_id: listing_id)

          listing.images.each do |image|
            photo1 = Photo.new
            photo1.picture_from_url image.result["url_fullxfull"]
            photo1.save
            card.photos << photo1
            sleep(0.5)
            photo2 = Photo.new
            photo2.picture_from_url image.result["url_75x75"]
            photo2.save
            card.photos << photo2
            sleep(0.5)
          end
          card.save
        end
      end
    end
    cards_in_db = Card.all.map {|card| card.listing_id}
    
    retired_cards = cards_in_db - current_listings

    retired_cards.each do |listing_id|
      Card.find_by_listing_id(listing_id).update_attribute("status", "retired")
    end
  end
end
