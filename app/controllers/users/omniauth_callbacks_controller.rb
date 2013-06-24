class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    redirect_to root_url
  end
end
