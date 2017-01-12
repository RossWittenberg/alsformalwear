class AddHighSchoolToEvents < ActiveRecord::Migration
  def change
  	add_reference :events, :high_school, index: true
  	add_foreign_key :events, :high_schools
  end
end