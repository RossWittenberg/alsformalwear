class AddAttachmentManagerImageContentImage1ContentImage2ContentImage3ToLocations < ActiveRecord::Migration
  def self.up
    change_table :locations do |t|
      t.attachment :manager_image
      t.attachment :content_image_1
      t.attachment :content_image_2
      t.attachment :content_image_3
    end
  end

  def self.down
    remove_attachment :locations, :manager_image
    remove_attachment :locations, :content_image_1
    remove_attachment :locations, :content_image_2
    remove_attachment :locations, :content_image_3
  end
end
