class AddBrideNamesToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :bride_first_name, :string
  	add_column :events, :bride_last_name, :string
  end
end
