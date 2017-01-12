class AddDeadlineStringToSchoolGroupSales < ActiveRecord::Migration
  def change
    add_column :school_group_sales, :deadline_string, :string
  end
end
