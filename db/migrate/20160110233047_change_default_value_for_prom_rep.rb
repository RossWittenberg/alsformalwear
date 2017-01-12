class ChangeDefaultValueForPromRep < ActiveRecord::Migration
  def change
  	change_column_default(:events, :prom_rep, nil)
  end
end
