class Commit < ActiveRecord::Base
  attr_accessible :state, :user_id, :sha1, :email, :message, :ci_passed

  scope :failed, where(state: "failed")
  scope :unchecked, where(state: nil)
  scope :verified, where(state: "verified")

  def formatted_sha1
    self.sha1[0..6]
  end
end
