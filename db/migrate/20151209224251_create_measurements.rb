class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
    	t.belongs_to :user, index: true
    	t.string :suit_size
    	t.float :chest_overarm
    	t.float :chest_underarm
    	t.float :pants_waist
    	t.float :pants_hip
    	t.float :pants_outseam
    	t.float :shirt_collar
    	t.string :shirt_sleeve
    	t.string :shoe_size
    	t.integer :height_feet
    	t.integer :height_inches
    	t.integer :weight
    	t.string :body_type
    	t.string :fit_preference

      t.timestamps null: false
    end
  end
end
