class AddProductFeaturedField < ActiveRecord::Migration
  def change
  	add_column :spree_products, :featured, :boolean, :default => false, :null => false
  end
end
