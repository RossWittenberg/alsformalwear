class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
    	t.text :text
    	t.string :page
    	t.string :description
    	t.attachment :image

    	t.timestamps null: false
    end
  end
end
