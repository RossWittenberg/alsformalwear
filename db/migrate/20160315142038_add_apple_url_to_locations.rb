class AddAppleUrlToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :apple_url, :string
  end
end