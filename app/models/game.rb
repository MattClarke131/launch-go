class Game < ApplicationRecord
  has_many :moves
  has_many :board_states
end
