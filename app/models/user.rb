class User < ActiveRecord::Base
  has_secure_password
  has_many :votes

  has_many :comments

  def may_edit(item)
    self.is_admin || item.user.id == self.id
  end
end
