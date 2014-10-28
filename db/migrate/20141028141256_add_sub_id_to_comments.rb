class AddSubIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :sub_id, :integer
  end
end
