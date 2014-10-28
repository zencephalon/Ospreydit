class AddUsernameToComments < ActiveRecord::Migration
  def up
    add_column :comments, :username, :string

    Comment.where(username: nil).each do |comment|
      comment.update(username: "zencephalon")
    end
  end

  def down
    remove_column :comments, :username
  end
end
