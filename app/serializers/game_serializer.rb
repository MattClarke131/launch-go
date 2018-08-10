class GameSerializer < ActiveModel::Serializer
  attributes :id

  has_many :moves
  has_many :board_states

  def board_states
    result = object.board_states.order('move_number DESC')
    result.map do |board_state|
      new_state = board_state
      new_state['board'] = JSON.parse(new_state['board'])
    end
  end
end
