class OneCompanyPerUser < ActiveRecord::Migration
  def up
    remove_index :companies, :user_id
    add_index :companies, :user_id, unique: true
  end
end
