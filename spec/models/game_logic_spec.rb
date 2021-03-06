require 'rails_helper'

RSpec. describe GameLogic, type: :model do
  let!(:empty_board) { JSON.parse(BoardState.empty_board)}
  let!(:test_board_00) do
    new_board = JSON.parse(BoardState.empty_board)
    new_board[0][0] = 'black'

    new_board
  end
  let!(:test_board_dead) do
    new_board = JSON.parse(BoardState.empty_board)
    new_board[0][0] = 'black'
    new_board[0][1] = 'white'
    new_board[1][0] = 'white'

    new_board
  end
  let!(:test_board_group_00) do
    new_board = JSON.parse(BoardState.empty_board)
    for x in 0..3
      for y in 0..3
        new_board[x][y] = 'black'
      end
    end

    new_board
  end
  let!(:test_board_group_01) do
    new_board = JSON.parse(BoardState.empty_board)
    new_board[0][1] = 'black'
    new_board[2][1] = 'black'
    new_board[3][1] = 'black'
    new_board[1][0] = 'black'
    new_board[3][0] = 'black'

    new_board
  end
  let!(:test_board_self_capture) do
    new_board = JSON.parse(BoardState.empty_board)
    new_board[0][1] = 'black'
    new_board[1][0] = 'black'
    new_board[2][1] = 'black'
    new_board[1][2] = 'black'

    new_board
  end
  let!(:points_00) do
    points = []
    points << {x:0, y:0, color:'black'}
    points << {x:0, y:1, color:'white'}
    points << {x:0, y:2, color:'empty'}
    points << {x:0, y:3, color:'black'}

    points
  end
  let!(:points_01) do
    points = []
    points << {x:0, y:0, color:'black'}
    points << {x:0, y:1, color:'white'}

    points
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

  describe 'group' do
    it 'returns the whole board on an empty_board' do
      expect(
        GameLogic.group(empty_board, {x:0,y:0,color:'empty'}).length
      ).to eq 81
    end

    it 'returns a group of size 1 for a stone with no neighbors' do
      expect(
        GameLogic.group(test_board_00, {x:0,y:0,color:'black'}).length
      ).to eq 1
    end

    it 'returns a group of size 80 for empty stones after move 1' do
      expect(
        GameLogic.group(test_board_00, {x:0,y:1,color:'empty'}).length
      ).to eq 80
    end

    it 'gets all stones of a clumped group once' do
      expect(
        GameLogic.group(test_board_group_00, {x:0,y:1,color:'black'}).length
      ).to eq 16
    end

    it 'Does not connect stones by diagonal' do
      expect(
        GameLogic.group(test_board_group_01, {x:2,y:1,color:'black'}).length
      ).to eq 3
    end
  end

  describe 'points_of_color' do
    it 'removes all non-empty points from an array' do
      expect(
        GameLogic.points_of_color(points_00, 'empty').length
      ).to eq 1
    end

    it 'returns points of the correct color' do
      expect(
        GameLogic.points_of_color(points_00, 'empty')[0][:color]
      ).to eq 'empty'
    end
  end

  describe 'filter_points_by_points' do
    it 'returns an empty array on filtering self' do
      expect(
        GameLogic.filter_points_by_points(points_00, points_00).length
      ).to eq 0
    end

    it 'returns points only in first array' do
      expect(
        GameLogic.filter_points_by_points(points_00, points_01).length
      ).to eq 2
    end
  end

  describe 'point_in_array?' do
    it 'returns false on empty array' do
      expect(
        GameLogic.point_in_array?({x:0,y:0,color:'black'}, [])
      ).to be false
    end

    it 'returns true if point is in array' do
      expect(
        GameLogic.point_in_array?({x:0,y:0,color:'black'}, points_00)
      ).to be true
    end

    it 'returns false if point is not in array' do
      expect(
        GameLogic.point_in_array?({x:4,y:4,color:'black'}, points_00)
      ).to be false
    end
  end

  describe 'group_touches_color?' do
    it 'returns true when a group has liberties' do
      corner_stone_group = [{x:0, y:0, color:'black'}]
      expect(
        GameLogic.group_touches_color?(
          test_board_00, corner_stone_group, 'empty'
        )
      ).to be true
    end

    it 'returns false when a group has no liberties' do
      corner_stone_group = [{x:0, y:0, color:'black'}]
      expect(
        GameLogic.group_touches_color?(
          test_board_dead, corner_stone_group, 'empty'
        )
      ).to be false
    end
  end

  describe 'color_in_neighbors' do
    it 'returns false on capture' do
      expect(
        GameLogic.color_in_neighbors?(
          test_board_dead,
          {x:0,y:0,color:'black'},
          'empty'
        )
      )
    end

    it 'returns true on a group with liberties' do
      expect(
        GameLogic.color_in_neighbors?(
          test_board_00,
          {x:0,y:0,color:'black'},
          'empty'
        )
      )
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

  describe 'is_self_capture?' do
    it 'returns true when a move would be self captured' do
      expect(
        GameLogic.is_self_capture?(
          test_board_self_capture,
          {x:1,y:1,color:'white'}
        )
      ).to be true
    end
    it 'returns false when a move would not be self captured' do
      expect(
        GameLogic.is_self_capture?(
          test_board_self_capture,
          {x:1,y:1,color:'black'}
        )
      ).to be false
    end
  end

  describe 'legal_moves' do
    it 'returns a nested array of booleans' do
      expect(
        GameLogic.legal_moves(empty_board, 'black')[0][0]
      ).to be true
    end

    it 'sets full coordinates to false' do
      expect(
        GameLogic.legal_moves(test_board_00, 'black')[0][0]
      ).to be false
    end
    it ' correctly accounts for self capture being illegal' do
      expect(
        GameLogic.legal_moves(test_board_self_capture, 'white')[0][0]
      ).to be false
      expect(
        GameLogic.legal_moves(test_board_self_capture, 'white')[1][1]
      ).to be false
      expect(
        GameLogic.legal_moves(test_board_self_capture, 'white')[2][2]
      ).to be true
      expect(
        GameLogic.legal_moves(test_board_self_capture, 'black')[0][0]
      ).to be true
    end
  end
end
