class User < ActiveRecord::Base
  has_secure_password
  has_many :votes
  # Remember to create a migration!
end
