class CreateLooks < ActiveRecord::Migration
  def change
    create_table :looks do |t|
      t.json :products
      t.belongs_to :user
      t.belongs_to :event

      t.timestamps
    end
  end
end
