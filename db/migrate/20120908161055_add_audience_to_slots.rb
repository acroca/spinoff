class AddAudienceToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :audience, :integer
  end
end
