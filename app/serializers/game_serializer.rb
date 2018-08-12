class GameSerializer < ActiveModel::Serializer
  attributes :id

  has_many :moves
  has_many :board_states
  has_many :players


  def board_states
    result = object.board_states.order('move_number DESC')
    result.map do |board_state|
      new_state = board_state
      new_state['board'] = JSON.parse(new_state['board'])
    end
  end

  def players
    players = object.pairings.map do |pairing|
      {
        email: pairing.user.email,
        rank: pairing.user.rank,
        color: pairing.color
      }
    end

    players
  end
end
