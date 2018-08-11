class AddSizeToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :size, :integer, null: false
  end
end
