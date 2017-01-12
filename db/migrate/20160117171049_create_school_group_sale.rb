class CreateSchoolGroupSale < ActiveRecord::Migration
  def change
    create_table :school_group_sales do |t|
    	t.string :first_name
			t.string :last_name
			t.string :street_address
			t.string :city
			t.string :state
			t.string :zip_code
			t.string :contact_phone
			t.string :budget
			t.string :number_uniforms
			t.string :deadline
			t.string :school_district
			t.string :orgname
			t.string :school_type
			t.string :school_level
			t.string :teacher_name
			t.string :group_type
			t.string :uniform_type
			t.string :group_type_explain
			t.string :uniform_explain
			t.string :accessories
			t.string :special_needs
    	t.timestamps
    end
  end
end
