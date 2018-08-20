class BoardState < ApplicationRecord
  belongs_to :game

  def self.empty_board
    new_board = Array.new(9,
      Array.new(9,
        'empty'
      )
    )

    JSON.generate(new_board)
  end

  def self.init_legal_moves
    new_board = Array.new(9,
      Array.new(9,
        true
      )
    )

    JSON.generate(new_board)
  end
end
