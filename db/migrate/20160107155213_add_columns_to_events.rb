class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :location, index: true
    add_foreign_key :events, :locations
    add_column :events, :orgname, :string
    add_column :events, :street_address, :string
    add_column :events, :city, :string
    add_column :events, :state, :string
    add_column :events, :zip_code, :string
    add_column :events, :tax_id, :string
    add_column :events, :referral_name, :string
    add_column :events, :contact_title, :string
    add_column :events, :contact_phone, :string
    add_column :events, :school_year, :string
  end
end
