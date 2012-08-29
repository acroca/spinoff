class AddTypeToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :type, :string
  end
end
