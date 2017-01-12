class AddIsGroupToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_group, :boolean, default: false
  end
end
