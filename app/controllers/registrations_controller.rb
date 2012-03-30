class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end
end
