class AddExportedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :exported, :boolean, default: false
  end
end
