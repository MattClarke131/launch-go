class CreateBoardStates < ActiveRecord::Migration[5.2]
  def change
    create_table :board_states do |t|
      t.integer :move_number
      t.integer :size, default: 9
      t.text :board

      t.belongs_to :game
    end
  end
end
