class Commit < ActiveRecord::Base
  attr_accessible :state, :user_id, :sha1
end
