class AddManagersToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :regional_district_manager_email, :string
    add_column :locations, :district_manager_email, :string
    add_column :locations, :area_manager_email, :string
  end
end