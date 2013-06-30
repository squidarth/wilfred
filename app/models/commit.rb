class Commit < ActiveRecord::Base
  attr_accessible :state, :user_id, :sha1, :email, :message

  def formatted_sha1
    self.sha1[0..6]
  end
end
