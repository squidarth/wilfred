class PublicController < ApplicationController
  def index
    @commits = Commit.order("created_at DESC").limit(100).all
  end
end
