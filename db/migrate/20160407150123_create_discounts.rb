class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
    	t.string :first_name
			t.string :last_name
			t.string :contact_email
			t.string :contact_phone
			t.string :zip_code
			t.string :event_type
			t.date :date
			t.references :location
			t.string :custom_discount
			t.string :wedding_date_string
			t.string :contact_name
			t.boolean :is_group, default: false
			t.boolean :wedding, default: false
			t.integer :custom_discount	
			t.boolean :best_man, default: false	
			t.integer :groomsmen
			t.boolean :fot_bride, default: false
			t.boolean :fot_groom, default: false
			t.boolean :ringbearer, default: false
			t.integer :ushers	
			t.integer :attendants	

    	t.timestamps
    end
  end
end
