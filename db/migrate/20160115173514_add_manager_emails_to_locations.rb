class AddManagerEmailsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :manager_email, :string
  end
end
