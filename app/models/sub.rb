class Sub < ActiveRecord::Base
  # Remember to create a migration!
  has_many :comments
end
