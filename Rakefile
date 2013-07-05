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

      card = Card.create(title: title, description: description, 
        inventory: inventory, company_url: company_url,
        company_name: company_name, price: price)

      image_num = 1

      listing.images.each do |image|
        # full_size = image.result["url_fullxfull"]
        # pic_170x135 = image.result["url_170x135"] 
        card.photos << Photo.create(file_location: "/card_images/card_#{card.id}/image_#{image_num}/img_fullxfull.jpg")
        card.photos << Photo.create(file_location: "/card_images/card_#{card.id}/image_#{image_num}/img_75x75.jpg")
        # system( "wget #{image.result["url_fullxfull"]} -O  ./app/assets/images/card_#{card.id}/image_full_#{image_num}")
        sleep(0.5)
        system("curl -o ./app/assets/images/card_images/card_#{card.id}/image_#{image_num}/img_fullxfull.jpg  #{image.result["url_fullxfull"]} --create-dirs")
        sleep(0.5)
        system("curl -o ./app/assets/images/card_images/card_#{card.id}/image_#{image_num}/img_75x75.jpg  #{image.result["url_75x75"]} --create-dirs")
        # system( "wget #{image.result["url_170x135"]} -O  ./app/assets/images/card_#{card.id}/image_#{image_num}_jpg")
        image_num += 1
      end
      card.save
    end
  end
end

