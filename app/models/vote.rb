class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  # Remember to create a migration!
end
