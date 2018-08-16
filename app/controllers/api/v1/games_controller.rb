class Api::V1::GamesController < ApplicationController
  protect_from_forgery with: :null_session
  def show
    render json: Game.find(game_params)
  end

  def create
    challenge_user = User.find_by(email: user_params)
    challenge_current_user = User.current_user

    unless User.current_user.challenge.nil?
      challenge_current_user.challenge.delete
    end

    challenge_user.challenge.delete

    new_game = Game.create_game_default(
      challenge_user,
      challenge_current_user
    )

    render json: new_game
  end

  def update
    game = Game.find(params[:id])

    if authorize_player(game)
      if params[:type] === 'move' && authorize_move(game, params[:x], params[:y])

        move = {
          type: 'move',
          x: params[:x],
          y: params[:y]
        }
        update_game(game, move)
      end
    end

    render json: game
  end

  private

  def game_params
    params[:id].to_i
  end

  def user_params
    params[:user_email]
  end

  def authorize_move(game, x, y)
    board_states = game.board_states.order('move_number DESC')
    newest_state = board_states[0]
    board = JSON.parse(newest_state.board)

    Game.move_is_legal?(board, x, y)
  end

  def authorize_player(game)
    num_board_states = game.board_states.length
    active_color = num_board_states % 2 == 0 ? 'white' : 'black'
    active_pairing =
      game.pairings.select { |pair| pair.color == active_color}[0]
    active_player_id = active_pairing.user_id

    active_player_id === User.current_user.id
  end

  def update_game(game, move)
    board_states = game.board_states.order('move_number DESC')
    newest_state = board_states[0]
    new_board = JSON.parse(newest_state.board)
    move_color = newest_state.move_number % 2 === 0 ? 'black' : 'white'
    if move[:type] === 'move'
      x = move[:x]
      y = move[:y]
      new_board[x][y] = move_color
    elsif move[:type] === 'pass'
      # do nothing
    end
    new_board = JSON.generate(new_board)
    new_state = BoardState.new(
      game: game,
      move_number: newest_state.move_number + 1,
      board: new_board
    )

    new_state.save!
  end
end
