# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Inkwell::Application.initialize!

require 'yaml'

unless Rails.env.production?
  config = YAML.load_file("#{Rails.root}/config/web_app_api.yaml")
  Etsy.api_key = config['ETSY_KEYSTRING']
  Etsy.api_secret = config['ETSY_SECRET']
end

if Rails.env.production?
  Etsy.api_key = ENV['ETSY_KEYSTRING']
  Etsy.api_secret = ENV['ETSY_SECRET']
end

Etsy.callback_url = 'http://localhost:3000'
Etsy.environment = :production



