require "omniauth-facebook"
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    # You need to implement the method below in your model
    if current_user
      @user = User.find_by_uid(env['omniauth.auth']['uid'])
      if @user and current_user.id == @user.id
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
        sign_in_and_redirect @user, :event => :authentication
      elsif !@user
        current_user.link_twitter env['omniauth.auth']
        redirect_to :root, :notice => "Successfully linked Twitter account!"
      else
        redirect_to :root, :notice => "Your Twitter account have benn already linked!"
      end
    else
      @user = User.find_for_twitter_oauth(env["omniauth.auth"], current_user)
      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.twitter_data"] = env["omniauth.auth"]['extra']['user_hash']
        session["devise.oauth"] = env["omniauth.auth"]['credentials']
        redirect_to new_user_registration_url
      end
    end
  end
end