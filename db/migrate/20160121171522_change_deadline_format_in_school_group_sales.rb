class ChangeDeadlineFormatInSchoolGroupSales < ActiveRecord::Migration
  def change
  	remove_column :school_group_sales, :deadline
  	add_column :school_group_sales, :deadline, :datetime
  end
end
