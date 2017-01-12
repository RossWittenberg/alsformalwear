class AddJuniorsAndBlackTieToEvents < ActiveRecord::Migration
  def change
    add_column :events, :juniors, :boolean
    add_column :events, :black_tie, :boolean
  end
end
