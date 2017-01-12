class AddSchoolAddressColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :school_city, :string
    add_column :events, :school_state, :string
    add_column :events, :school_zip_code, :string
  end
end
