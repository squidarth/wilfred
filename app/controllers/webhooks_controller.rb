class WebhooksController < ApplicationController
  def create
    puts params[:payload].to_json
  end
end
