class AddStoreHoursToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :mon_open, :integer
    add_column :locations, :mon_close, :integer
    add_column :locations, :tues_open, :integer
    add_column :locations, :tues_close, :integer
    add_column :locations, :wed_open, :integer
    add_column :locations, :wed_close, :integer
    add_column :locations, :thurs_open, :integer
    add_column :locations, :thurs_close, :integer
    add_column :locations, :fri_open, :integer
    add_column :locations, :fri_close, :integer
    add_column :locations, :sat_open, :integer
    add_column :locations, :sat_close, :integer
    add_column :locations, :sun_open, :integer
    add_column :locations, :sun_close, :integer
  end
end


