class ApplicationController < ActionController::Base
  protect_from_forgery

  def try_to_update(resource, options = {})
    
    resource_symbol = resource.class.to_s.downcase.to_sym
    resource_path = eval "#{resource.class.to_s.downcase.pluralize}_path"

    if !resource
      redirect_to user_root_path, notice: "No resource", status: :unprocessable_entity
    else

      authorized = !options[:authorize_user] || resource.user == current_user

      if !authorized
        redirect_to user_root_path, notice: "Not authorized", status: :unauthorized
      elsif resource.update_attributes(params[resource_symbol])
        redirect_to resource_path
      else
        redirect_to user_root_path, notice: "Failed to save", status: :internal_server_error
      end
    end
    
  end

end
