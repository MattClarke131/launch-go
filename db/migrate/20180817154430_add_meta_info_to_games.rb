class AddMetaInfoToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :completed, :boolean, :default => false
    add_column :games, :winner_id, :integer
    add_column :games, :result, :string, :default => 'incomplete'
  end
end
