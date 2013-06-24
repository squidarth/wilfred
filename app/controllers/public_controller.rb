class PublicController < ApplicationController
  def index
    @user = current_user 
    @commits = Commit.order("created_at DESC").limit(100).all
  end
end
