require 'rails_helper'

RSpec. describe GameLogic, type: :model do
  let!(:empty_board) { JSON.parse(BoardState.empty_board)}
  let!(:test_board_00) do
    new_board = JSON.parse(BoardState.empty_board)
    new_board[0][0] = 'black'

    new_board
  end

  describe 'set point' do
    it 'changes a board point to black' do
      new_board = GameLogic.set_point(
        empty_board, {x:0, y:0, color:'black'}
      )

      expect(new_board[0][0]).to eq 'black'
    end
    it 'changes a board point to white' do
      new_board = GameLogic.set_point(
        empty_board, {x:0, y:0, color:'white'}
      )

      expect(new_board[0][0]).to eq 'white'
    end
    it 'changes a board point to empty' do
      new_board = GameLogic.set_point(
        test_board_00, {x:0, y:0, color:'empty'}
      )

      expect(test_board_00[0][0]).to eq 'empty'
    end
  end
end
