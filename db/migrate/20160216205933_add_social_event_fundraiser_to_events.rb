class AddSocialEventFundraiserToEvents < ActiveRecord::Migration
  def change
    add_column :events, :social_event_fundraiser, :boolean, default: false
  end
end
