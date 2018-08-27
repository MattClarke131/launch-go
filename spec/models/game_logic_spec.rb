require 'rails_helper'

RSpec. describe GameLogic, type: :model do
  let!(:empty_board) { JSON.parse(BoardState.empty_board)}
  let!(:test_board_00) do
    new_board = JSON.parse(BoardState.empty_board)
    new_board[0][0] = 'black'

    new_board
  end

  describe 'neighbors' do
    it 'returns 2 neighbors for a corner point' do
      corner = {x:0, y:0, color: 'empty'}
      expect(
        GameLogic.neighbors(empty_board, corner).length
      ).to eq 2
    end

    it 'returns 3 neighbors for an edge point' do
      edge = {x:0, y:1, color: 'empty'}
      expect(
        GameLogic.neighbors(empty_board, edge).length
      ).to eq 3
    end

    it 'returns 4 neighbors for a center point' do
      edge = {x:1, y:1, color: 'empty'}
      expect(
        GameLogic.neighbors(empty_board, edge).length
      ).to eq 4
    end
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
