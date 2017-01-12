class AddServicesLinksToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :tuxedos_service_link, :string, default: "/catalog/products?category=tuxedos"
		add_column :locations, :suits_service_link, :string, default: "/catalog/products?category=suits"
		add_column :locations, :accessories_service_link, :string, default: "/catalog/products?category=studs-and-links"
		add_column :locations, :photography_service_link, :string, default: "http://www.alsphotography.com/"
		add_column :locations, :video_service_link, :string, default: "http://www.alsphotography.com/Packages.aspx?Type=2"
		add_column :locations, :dj_service_link, :string, default: "http://www.alsphotography.com/Packages.aspx?Type=1"
		add_column :locations, :invitations_service_link, :string, default: "http://alsformalwear.carlsoncraft.com/"
		add_column :locations, :quinceanera_service_link, :string, default: "/quinceanera"
  end
end


