class AddLegalMovesToBoardStates < ActiveRecord::Migration[5.2]
  def change
    add_column :board_states, :legal_moves, :text
  end
end
