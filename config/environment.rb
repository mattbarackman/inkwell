# Load the rails application
require File.expand_path('../application', __FILE__)

FactoryGirl.find_definitions

# Initialize the rails application
Inkwell::Application.initialize!

require 'yaml'

config = YAML.load_file("#{Rails.root}/config/web_app_api.yaml")

Etsy.api_key = config['ETSY_KEYSTRING']
Etsy.api_secret = config['ETSY_SECRET']
Etsy.callback_url = 'http://localhost:3000'
Etsy.environment = :production
