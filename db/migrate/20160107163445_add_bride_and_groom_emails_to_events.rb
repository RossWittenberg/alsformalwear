class AddBrideAndGroomEmailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :bride_email, :string
    add_column :events, :groom_email, :string
  end
end
