class CreateCompetitorColors < ActiveRecord::Migration
  def change
    create_table :competitor_colors do |t|
    	t.string :name
    	t.string :hex
    	t.references :parent_color

    	t.timestamps
    end
  end
end
