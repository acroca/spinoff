class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :company_id
      t.integer :program_id
      t.integer :day
      t.integer :time

      t.timestamps
    end
  end
end
