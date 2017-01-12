class AddSchoolFundrasierToEvents < ActiveRecord::Migration
  def change
    add_column :events, :school_fundraiser, :boolean, default: false
  end
end
