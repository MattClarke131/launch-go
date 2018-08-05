class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def self.up
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :rank, :integer, default: -30
  end

  def self.down
    remove_column :users, :is_admin
    remove_column :users, :rank
  end
end
