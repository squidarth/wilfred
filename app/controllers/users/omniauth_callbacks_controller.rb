class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    omniauth_params = request.env["omniauth.auth"] 
    email = omniauth_params["info"]["email"]
    @user = User.find_by_email(email)
    if @user.nil?
      @user = User.create(name: omniauth_params["info"]["name"], email: email) 
      @user.provider = "github"
      @user.uid = omniauth_params["uid"] 
      @user.save!
    end 
    
    sign_in @user

    redirect_to root_url
  end
end
