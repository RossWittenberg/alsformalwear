class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :event_name
    	t.date   :date
    	t.string :event_type
    	t.string :role
        t.string :groom_first_name
        t.string :groom_last_name
        t.belongs_to :user, index: true

    	t.timestamps
    end
  end
end