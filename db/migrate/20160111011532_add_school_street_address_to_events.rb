class AddSchoolStreetAddressToEvents < ActiveRecord::Migration
  def change
    add_column :events, :school_street_address, :string
  end
end
