class AddHtmlToContents < ActiveRecord::Migration
  def change
    add_column :contents, :html, :boolean, default: false
  end
end
