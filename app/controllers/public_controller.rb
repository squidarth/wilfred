class PublicController < ApplicationController
  def index
    @user = current_user
    render layout: false
  end
end
