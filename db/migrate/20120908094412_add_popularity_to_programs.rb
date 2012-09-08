class AddPopularityToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :popularity, :integer, default: 1
    remove_column :programs, :price
  end
end
