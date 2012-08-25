class CreateTableCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :user_id
      t.string :name
      t.integer :money, default: 0
    end
    add_index :companies, :user_id
  end
end
