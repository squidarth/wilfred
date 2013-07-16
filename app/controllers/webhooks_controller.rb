class WebhooksController < ApplicationController
  def github
    # things i need: commit SHA1, the committer, and the message
    payload = JSON.parse(params[:payload])

    unless VALID_BRANCHES.map {|branch| "refs/heads/#{branch}"}.include?(payload["ref"])
      return render json: {success: true}
    end

    payload["commits"].each do |commit|
      author = commit["author"]
      email = author["email"]
      sha1 = commit["id"]
      message = commit["message"]
      Commit.create(email: email, sha1: sha1, message: message)
    end

    return render json: {success: true}
  end

  def circle_ci
    puts params.inspect 
    return render json: {success: true}
  end
end
