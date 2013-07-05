# Load the rails application
require File.expand_path('../application', __FILE__)

FactoryGirl.find_definitions

# Initialize the rails application
Inkwell::Application.initialize!

require 'yaml'

if ENV['RAILS_ENV'] == "development"

  config = YAML.load_file("#{Rails.root}/config/web_app_api.yaml")
  Etsy.api_key = config['ETSY_KEYSTRING']
  Etsy.api_secret = config['ETSY_SECRET']

end

Etsy.callback_url = 'http://localhost:3000'
Etsy.environment = :production


