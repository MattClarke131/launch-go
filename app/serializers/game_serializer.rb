class GameSerializer < ActiveModel::Serializer
  attributes :id

  has_many :moves
  has_many :board_states
end
