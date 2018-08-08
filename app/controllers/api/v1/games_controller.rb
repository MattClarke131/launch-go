class Api::V1::GamesController < ApplicationController
  def show
    render json: Game.find(game_params)
  end

  def game_params
    params[:id].to_i
  end
end
