class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

def default_url_options
  { host: ENV["HOST"] || "localhost:3000" }
end

protected

def configure_permitted_parameters
 devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
 devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :password_confirmation])
 devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
end

end
