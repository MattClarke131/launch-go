class Game < ApplicationRecord
  has_many :moves
  has_many :board_states
  has_many :pairings
  has_many :users, through: :pairings

end
