class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_by_username((request.env["omniauth.auth"].info.nickname).downcase)

    if @user.nil?
      @user = User.from_omniauth(request.env["omniauth.auth"])
    end

    if @user.persisted?
      @user.token = request.env["omniauth.auth"].credentials.token
      @user.save!
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
