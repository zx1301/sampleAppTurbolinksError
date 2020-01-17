class Users::OmniauthController < Devise::OmniauthCallbacksController

  # facebook callback
  def facebook
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end

def google_oauth2
  auth = request.env["omniauth.auth"]
  user = User.where(provider: auth["provider"], uid: auth["uid"])
          .first_or_initialize(email: auth["info"]["email"])
  user.name ||= auth["info"]["name"]
  user.save!

  user.remember_me = true
  sign_in(:user, user)

  redirect_to after_sign_in_path_for(user)
end
  # google callback
=begin
  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end
=end

  # twitter callback
  def twitter
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Twitter. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
    redirect_to new_user_registration_url
  end
end
