class AddGenreToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :genre, :string
  end
end
