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

  private

  def game_params
    params[:id].to_i
  end

  def user_params
    params[:user_email]
  end
end
