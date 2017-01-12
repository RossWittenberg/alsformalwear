class AddFamilyToProduct < ActiveRecord::Migration
  def change
  	add_column :spree_products, :family, :string
  end
end

