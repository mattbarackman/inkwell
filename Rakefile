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
    shop.listings.each do |listing|

      company_name = shop.title
      company_url = shop.url
      title = listing.title
      inventory = listing.quantity
      description = listing.description
      price = ((listing.price.to_f)*100).round
      listing_id = listing.result["listing_id"]

      card = Card.create(title: title, description: description, 
        inventory: inventory, company_url: company_url,
        company_name: company_name, price: price, listing_id: listing_id)

      listing.images.each do |image|
        photo1 = Photo.new
        photo1.picture_from_url image.result["url_fullxfull"]
        photo1.save
        puts photo1.errors.full_messages
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

