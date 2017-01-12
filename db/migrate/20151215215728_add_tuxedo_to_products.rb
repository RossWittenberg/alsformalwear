class AddTuxedoToProducts < ActiveRecord::Migration
  def change
  	add_column :spree_products, :tuxedo, :boolean, :default => false, :null => false
  end
end
