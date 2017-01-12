class AddNamesToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :first_name, :string
  	add_column :events, :last_name, :string
  end
end
