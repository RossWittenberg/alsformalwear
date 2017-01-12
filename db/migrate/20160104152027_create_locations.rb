class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.string   :store_num, null: false
    	t.string   :dist_manager, null: true 
    	t.string   :store_name, null: false 
    	t.string   :street_address, null: true 
    	t.string   :city, null: true 
    	t.string   :state, null: true 
    	t.string   :zip_code, null: true 
    	t.string   :phone_number, null: true 
    	t.string   :manager, null: true 
    	t.float    :latitude, null: false 
    	t.float	   :longitude, null: false 
    	t.string   :mon_hours, null: true 
    	t.string   :tues_hours, null: true 
    	t.string   :wed_hours, null: true 
    	t.string   :thurs_hours, null: true 
    	t.string   :fri_hours, null: true 
    	t.string   :sat_hours, null: true 
    	t.string   :sun_hours, null: true 

    	t.timestamps null: false
    end
  end
end

