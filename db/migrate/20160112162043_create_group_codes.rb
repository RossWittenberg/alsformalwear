class CreateGroupCodes < ActiveRecord::Migration
  def change
    create_table :group_codes do |t|
    	t.integer :number
    	t.references :location
    	t.references :event

    	t.timestamps
    end
  end
end
