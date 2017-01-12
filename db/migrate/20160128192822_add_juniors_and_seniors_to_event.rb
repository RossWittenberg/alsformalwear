class AddJuniorsAndSeniorsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :number_juniors, :string
    add_column :events, :number_seniors, :string
  end
end
