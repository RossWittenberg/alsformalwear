class CreateChildColors < ActiveRecord::Migration
  def change
    create_table :child_colors do |t|
    	t.string :name
    	t.string :hex
    	t.references :parent_color, index: true

      t.timestamps null: false
    end
  end
end
