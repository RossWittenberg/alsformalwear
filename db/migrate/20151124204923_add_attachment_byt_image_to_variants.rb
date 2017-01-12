class AddAttachmentBytImageToVariants < ActiveRecord::Migration
  def self.up
    change_table :spree_variants do |t|
      t.attachment :byt_image
    end
  end

  def self.down
    remove_attachment :spree_products, :byt_image
  end
end
