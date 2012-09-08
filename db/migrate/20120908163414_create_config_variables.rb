class CreateConfigVariables < ActiveRecord::Migration
  def change
    create_table :config_variables, id: false do |t|
      t.string :key
      t.string :value
    end
    add_index :config_variables, :key, unique: true
  end
end
