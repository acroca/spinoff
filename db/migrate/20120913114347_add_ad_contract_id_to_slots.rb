class AddAdContractIdToSlots < ActiveRecord::Migration
  def change
    add_column :slots, :ad_contract_id, :integer
  end
end
