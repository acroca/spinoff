class AddPriceToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :price, :integer
  end
end
