#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Inkwell::Application.load_tasks

namespace :etsy do
  desc "get cards" 
  task :read_image => :environment do
    user = Etsy.user("jdeluce")
    shop = user.shop
    card_image_urls = []
    shop.listings.each do |listing|

      company_name = shop.title
      title = listing.title
      description = listing.description
      price = ((listing.price.to_f)*100).round

      card = Card.create(title: title, description: description, inventory: inventory)

      listing.images.each do |image|

        full_size = image.result["url_fullxfull"]
        card.images << Image.create(full_size: full_size, )

      end

      system( "wget #{listing.image.result["url_170x135"]} -O  ./app/assets/card_images/card_#{card.id}/image_#{image.id}")
      card_image_urls << listing.image.result["url_170x135"]
    end
    File.open('testfile', "w") {|f| f.write(card_image_urls)}
  end
end

