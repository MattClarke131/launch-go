class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.string :color, null: false
      t.integer :x
      t.integer :y
      t.integer :move_number, null: false
      t.boolean :is_pass, null: false

      t.timestamps
    end

    add_index(:moves, :move_number)
  end
end
