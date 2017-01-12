class CreateParentColors < ActiveRecord::Migration
  def change
    create_table :parent_colors do |t|
    	t.string :name, null: false
    	t.string :hex, null: false
    	t.string :display_name, null: false

      t.timestamps null: false
    end
  end
end
