class AddAttachmentStoreImageToLocations < ActiveRecord::Migration
  def self.up
    change_table :locations do |t|
      t.attachment :store_image
    end
  end

  def self.down
    remove_attachment :locations, :store_image
  end
end
