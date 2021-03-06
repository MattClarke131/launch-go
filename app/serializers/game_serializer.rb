class GameSerializer < ActiveModel::Serializer
  attributes :id, :result

  has_many :board_states
  has_many :players

  def board_states
    result = object.board_states.order('move_number DESC')
    output = result.map do |board_state|
      new_state = board_state
      new_state['board'] = JSON.parse(new_state['board'])
    end

    output
  end

  def players
    players = {}
    object.pairings.each do |pairing|
      players["#{pairing.color}"] = {
        email: pairing.user.email,
        rank: pairing.user.rank,
      }
    end

    players
  end
end
