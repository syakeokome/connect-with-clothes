class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!, except: [:about]


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :postal_code, :address, :nickname, :self_introduction, :height, :age])
  end
end
