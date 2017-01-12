class AddServicesAndContentToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :manager_content_block, :text

    add_column :locations, :tuxedos_service, :boolean, default: true
    add_column :locations, :suits_service, :boolean, default: true

    add_column :locations, :quinceanera_service, :boolean, default: false
    add_column :locations, :accessories_service, :boolean, default: false
    add_column :locations, :photography_service, :boolean, default: false
    add_column :locations, :invitations_service, :boolean, default: false
    add_column :locations, :video_service, :boolean, default: false
    add_column :locations, :dj_service, :boolean, default: false

    add_column :locations, :event_content_block_1, :text
    add_column :locations, :event_content_block_2, :text
    add_column :locations, :event_content_block_3, :text

    add_column :locations, :event_link_text_1, :string
    add_column :locations, :event_link_text_2, :string
    add_column :locations, :event_link_text_3, :string

    add_column :locations, :spanish, :boolean, default: false
  end
end
