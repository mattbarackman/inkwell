# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Inkwell::Application.initialize!

# Etsy.api_key = "423vt2xp6agkds798k39ffvx"
# Etsy.api_secret = "tq0dit98n6"
require 'yaml'

config = YAML.load_file("#{Rails.root}/config/web_app_api.yaml")

Etsy.api_key = config['ETSY_KEYSTRING']
Etsy.api_secret = config['ETSY_SECRET']
Etsy.callback_url = 'http://localhost:3000'
Etsy.environment = :production
