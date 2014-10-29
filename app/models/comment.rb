class Comment < ActiveRecord::Base
  belongs_to :sub
  belongs_to :parent, class_name: "Comment", foreign_key: :parent_id
  has_many :children, class_name: "Comment", foreign_key: :parent_id

  has_many :votes
  has_many :voters, through: :votes, class_name: "User", source: :user

  def vote(user)
    if self.voters.include?(user)
      return false
    else
      self.votes.create(user: user)
      return true
    end
  end

  def score
    self.votes.size
  end
end
