class ApplicationController < ActionController::Base
  protect_from_forgery

  def try_to_update(resource, options = {})
    
    redirect_to user_root_path unless resource
    redirect_to user_root_path if options[:authorize_user] && resource.user != current_user

    resource_symbol = resource.class.to_s.downcase.to_sym
    redirect_to user_root_path unless resource.update_attributes(params[resource_symbol])

    resource_path = eval "#{resource.class.to_s.downcase.pluralize}_path"
    redirect_to resource_path
  end
end
