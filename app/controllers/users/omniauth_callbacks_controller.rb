class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    omniauth_params = request.env["omniauth.auth"] 
    is_in_organization = HTTParty.get(omniauth_params[:extra][:raw_info][:organizations_url], headers: {"User-Agent" => omniauth_params[:info][:nickname]})
            .map{|org| org["login"]}.include?(ENV["GH_ORGANIZATION"]) 
   
    return render json: {success: false, error: "Access Denied"} if !is_in_organization 
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
