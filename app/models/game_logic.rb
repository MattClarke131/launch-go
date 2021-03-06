class GameLogic
  # A note about data types:
  # A point is an object, ex: { x: 2, y: 4, color: 'black'}
  #   colors = ['black', 'white', 'empty']
  # A board is a nested array of colors


  class << self
    def remove_captures(board, new_point)
      new_board = board
      neighbors = neighbors(board, new_point)
      groups = neighbors.map { |p| group(board, p) }
      color = new_point[:color]
      enemy_color = color == 'black' ? 'white' : 'black'
      groups.each do |group|
        if group[0][:color] == enemy_color
          if !group_touches_color?(board, group, 'empty')
            group.each do |p|
              new_point = {
                x: p[:x],
                y: p[:y],
                color: 'empty'
              }
              new_board = set_point(board, new_point)
            end
          end
        end
      end

      new_board
    end

    def neighbors(board, point)
      neighbor_points = []
      if point[:x] < board.length - 1
        neighbor_points << {
          x: point[:x]+1,
          y: point[:y],
          color:board[point[:x]+1][point[:y]]
        }
      end
      if point[:x] > 0
        neighbor_points << {
          x: point[:x]-1,
          y: point[:y],
          color:board[point[:x]-1][point[:y]]
        }
      end
      if point[:y] < board.length - 1
        neighbor_points << {
          x: point[:x],
          y: point[:y]+1,
          color:board[point[:x]][point[:y]+1]
        }
      end
      if point[:y] > 0
        neighbor_points << {
          x: point[:x],
          y: point[:y]-1,
          color:board[point[:x]][point[:y]-1]
        }
      end

      neighbor_points
    end

    def group(board, point)
      group = [point]
      point_neighbors = neighbors(board, point)
      color = point[:color]
      point_neighbors = points_of_color(point_neighbors, color)
      unchecked = point_neighbors

      while unchecked.length > 0
        current_point = unchecked[0]

        group << current_point
        neighbors = neighbors(board, current_point)
        neighbors = points_of_color(neighbors, color)

        unchecked.shift

        neighbors = filter_points_by_points(neighbors, group)
        neighbors = filter_points_by_points(neighbors, unchecked)

        unchecked = unchecked.concat(neighbors)
      end

      group
    end

    def points_of_color(points, color)
      points.select { |p| p[:color] == color }
    end

    def filter_points_by_points(source_points, filter_points)
      filtered_points = []

      source_points.each do |point|
        if !point_in_array?(point, filter_points)
          filtered_points << point
        end
      end

      filtered_points
    end

    def point_in_array?(point, array)
      array.any? { |p| p[:x] == point[:x] && p[:y] == point[:y]}
    end

    def group_touches_color?(board, group, color)
      group.any? { |point| color_in_neighbors?(board, point, color)}
    end

    def color_in_neighbors?(board, point, color)
      neighbors = neighbors(board, point)

      neighbors.any? { |p| p[:color] == color }
    end

    def set_point(board, point)
      new_board = board
      new_board[point[:x]][point[:y]] = point[:color]

      new_board
    end

    def is_self_capture?(board, point)
      new_board = JSON.parse(JSON.generate(board))
      new_board[point[:x]][point[:y]] = point[:color]

      !group_touches_color?(
        new_board,
        group(new_board, point),
        'empty',
      )
    end

    def num_captures(old_board, board_after_capture, color)
      new_total = sum_stones_of_color(board_after_capture, color)
      old_total = sum_stones_of_color(old_board, color)

      old_total - new_total
    end

    def sum_stones_of_color(board, color)
      total = 0
      for x in 0..(board.length - 1)
        for y in 0..(board.length - 1)
          if board[x][y] == color
            total += 1
          end
        end
      end

      total
    end

    def legal_moves(board, color)
      # Only empty spaces are legal
      legal_board = empty_points(board)

      # Self capture is illegal
      legal_board = not_self_capture(legal_board, board, color)

      legal_board
    end

    def empty_points(board)
      legal_board = JSON.parse(BoardState.empty_board)

      board.each_index do |x|
        board.each_index do |y|
          legal_board[x][y] = board[x][y] == legal_board[x][y]
        end
      end

      legal_board
    end

    def not_self_capture(legal_board, board, color)
      for x in 0..(legal_board.length - 1)
        for y in 0..(legal_board.length - 1)
          if(legal_board[x][y])
            legal_board[x][y] = !is_self_capture?(board, {x:x, y:y, color:color})
          end
        end
      end

      legal_board
    end
  end
end
