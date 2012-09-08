class SetDefaultMoney < ActiveRecord::Migration
  def up
    change_column :companies, :money, :integer, default: 100000
  end

  def down
    change_column :companies, :money, :integer, default: 0
  end
end
