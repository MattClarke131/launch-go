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
    board_states = game.board_states.order('move_number DESC')
    newest_state = board_states[0]

    if(Game.legal_moves(JSON.parse(newest_state.board))[params[:x]][params[:y]])
      new_board = JSON.parse(newest_state.board)
      move_color = (newest_state.move_number + 1) % 2 == 1 ? 'black' : 'white'
      new_board[params[:x]][params[:y]] = move_color
      new_board = JSON.generate(new_board)

      new_state = BoardState.new(
        game: game,
        move_number: newest_state.move_number + 1,
        board: new_board
      )
      new_state.save!
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
end
