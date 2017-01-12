class CorrectUsersEmailIndexForParanoia < ActiveRecord::Migration
  def change
    remove_index :spree_users, name: :email_idx_unique
    add_index    :spree_users, :email, unique: true, where: "deleted_at IS NULL", name: :email_idx_unique
  end
end
