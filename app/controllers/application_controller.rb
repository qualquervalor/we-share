class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
    redirect_to root_path
    true
  end

  protected

  def configure_permitted_parameters
    [:name,:street,:city,:zipcode,:state,:phone_num,:picture].each do |field|
      devise_parameter_sanitizer.for(:sign_up) << field
      devise_parameter_sanitizer.for(:account_update) << field
    end
  end

  def after_sign_in_path_for(user)
    resources_path
  end

end
