class CreatePairings < ActiveRecord::Migration[5.2]
  def change
    create_table :pairings do |t|
      t.belongs_to :user
      t.belongs_to :game
      t.string :color
    end
  end
end
