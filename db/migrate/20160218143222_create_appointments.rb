class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
    	t.string
    	t.string     :first_name
    	t.string     :last_name
    	t.string     :contact_email
    	t.string     :contact_phone
    	t.string     :zip_code
    	t.references :location
        t.integer    :group_code
    	t.string     :contact_time
    	t.string     :contact_method
    	t.date       :appointment_date
    	t.string     :apt_time
    	t.string     :appointment_reason
    	t.string     :other_explain
    	t.string     :wedding_apt_details
    	t.string     :message

    	t.timestamps
    end
  end
end
