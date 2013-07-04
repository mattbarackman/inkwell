# Load the rails application
require File.expand_path('../application', __FILE__)

FactoryGirl.find_definitions

# Initialize the rails application
Inkwell::Application.initialize!
