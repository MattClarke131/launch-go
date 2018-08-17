class Game < ApplicationRecord
  has_many :moves
  has_many :board_states
  has_many :pairings
  has_many :users, through: :pairings

  after_create :create_empty_board_state

  def winner
    winner = nil
    winner_id = self.winner_id
    if winner_id != nil
      winner = User.find(winner_id)
    end

    winner
  end

  private

  def create_empty_board_state
    BoardState.create!(
      game: self,
      move_number: 0,
      board: BoardState.empty_board
    )
  end

  def self.create_game_default(player1, player2)
    players = [player1, player2].shuffle
    new_game = Game.new(size: 9)
    if new_game.save!
      Pairing.create(
        user: players[0],
        game: new_game,
        color: 'black',
      )
      Pairing.create(
        user: players[1],
        game: new_game,
        color: 'white',
      )
      return new_game
    end
  end

  def self.legal_moves(board_state)
    legal_board = JSON.parse(BoardState.empty_board)
    board_state.each_index do |x|
      board_state[x].each_index do |y|
        legal_board[x][y] = board_state[x][y] == legal_board[x][y]
      end
    end

    legal_board
  end

  def self.move_is_legal?(board_state, x, y)
    self.legal_moves(board_state)[x][y]
  end
end
