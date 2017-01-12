class AddAproxdateToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :approximate_event_date, :date
  end
end
