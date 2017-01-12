class AddContactEmailToSchoolGroupSale < ActiveRecord::Migration
  def change
    add_column :school_group_sales, :contact_email, :string
  end
end
