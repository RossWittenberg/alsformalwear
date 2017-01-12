class AddAttachmentSecondaryBytImageToVariants < ActiveRecord::Migration
  def self.up
    change_table :spree_variants do |t|
      t.attachment :secondary_byt_image
    end
  end

  def self.down
    remove_attachment :spree_products, :secondary_byt_image
  end
end
