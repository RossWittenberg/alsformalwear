class AddOtherExplainToEvent < ActiveRecord::Migration
  def change
    add_column :events, :other_explain, :string
  end
end
