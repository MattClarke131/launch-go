class Game < ApplicationRecord
  has_many :moves
  has_many :board_states
  has_many :pairings
  has_many :users, through: :pairings

  class << self
    def create_game_default(player1, player2)
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
  end
end
