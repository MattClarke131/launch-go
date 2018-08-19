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
              new_board = set_point(board, new_point, 'empty')
            end
          end
        end
      end

      new_board
    end

    def neighbors(board, point)
      neighbor_points = []
      neighbor_points << {x: point[:x]+1, point[:y]} if point[:x] < board.length
      neighbor_points << {x: point[:x]-1, point[:y]} if point[:x] > 0
      neighbor_points << {x: point[:x], point[:y]+1} if point[:y] < board.length
      neighbor_points << {x: point[:x], point[:y]-1} if point[:y] > 0

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

      neighbors.any? { |p| point[:color] == color }
    end

    def set_point(board, point, color)
      new_board = board
      new_board[point[:x]][point[:y]] = color

      new_board
    end

    def is_self_capture?(board, point)
      group_tuoches_color?(
        board,
        group(board, point),
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
  end
end
