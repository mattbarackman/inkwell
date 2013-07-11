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
        respond_to do |format|
          format.html { redirect_to resource_path }
          format.js { render :partial => 'layouts/occasion', locals: {occasion: resource} }
        end
      else
        redirect_to user_root_path, notice: "Failed to save", status: :internal_server_error
      end
    end
    
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def format_price(price)
    cents = (price % 100 == 0) ? "00" : (price % 100).to_s
    "$"+(price/100).to_s+"."+cents
  end

  helper_method :format_price

  def format_date(date)
    day = date.day.ordinalize
    date.strftime("%B #{day}")
  end

  helper_method :format_date

end
