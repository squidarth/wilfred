class WebhooksController < ApplicationController
  def create
    logger.info params.inspect
  end
end
