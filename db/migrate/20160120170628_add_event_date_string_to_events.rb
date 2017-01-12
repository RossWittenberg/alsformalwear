class AddEventDateStringToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_date_string, :string
  end
end
