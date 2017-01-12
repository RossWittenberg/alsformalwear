class AddAltTagToContents < ActiveRecord::Migration
  def change
    add_column :contents, :alt_tag, :string
  end
end
