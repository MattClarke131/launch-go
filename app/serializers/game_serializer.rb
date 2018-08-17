class GameSerializer < ActiveModel::Serializer
  attributes :id, :legal_moves, :result

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
    players = {}
    object.pairings.each do |pairing|
      players["#{pairing.color}"] = {
        email: pairing.user.email,
        rank: pairing.user.rank,
      }
    end

    players
  end

  def legal_moves
    board_states = object.board_states.order('move_number DESC')
    newest_state = board_states[0]

    Game.legal_moves(JSON.parse(newest_state.board))
  end
end
