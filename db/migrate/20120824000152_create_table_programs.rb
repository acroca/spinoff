class CreateTablePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :company_id
      t.string :name
      t.boolean :available, default: false
    end
    add_index :programs, :company_id
  end
end
