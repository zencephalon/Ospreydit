class UpdateCommentsToUseAssociation < ActiveRecord::Migration
  def up
    remove_column :comments, :username
    add_column :comments, :user_id, :integer

    Comment.where(user_id: nil).each do |comment|
      comment.user = User.all.sample
      comment.save
    end
  end

  def down
    remove_column :comments, :user_id
    add_column :comments, :username, :string
  end
end
