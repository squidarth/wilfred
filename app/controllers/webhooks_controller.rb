class WebhooksController < ApplicationController
  def create
    # things i need: commit SHA1, the committer, and the message 
    payload = JSON.parse(params[:payload])

    payload["commits"].each do |commit|

      author = commit["author"]
      email = author["email"] 
      sha1 = commit["id"]
      message = commit["message"]
      Commit.create(email: email, sha1: sha1, message: message)
    end
  
    return render json: {success: true} 
  end
end