class AddLookToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :look, index: true
    add_foreign_key :events, :looks
  end
end
