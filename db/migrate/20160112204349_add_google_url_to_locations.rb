class AddGoogleUrlToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :google_url, :text
  end
end
