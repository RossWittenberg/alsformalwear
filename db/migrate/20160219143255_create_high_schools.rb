class CreateHighSchools < ActiveRecord::Migration
  def change
    create_table :high_schools do |t|
    	t.string :name
    	t.integer :number
    	t.string :name_first_half
    	t.string :name_second_half
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps null: false
    end
  end
end
