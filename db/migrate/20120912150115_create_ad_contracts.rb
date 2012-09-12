class CreateAdContracts < ActiveRecord::Migration
  def change
    create_table :ad_contracts do |t|
      t.string :advertiser
      t.integer :price
      t.integer :company_id

      t.timestamps
    end
  end
end
