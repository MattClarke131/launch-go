class Api::V1::GamesController < ApplicationController
  def show
    render json: Game.find(game_params[:id])
  end

  def game_params
    params.require(:game).permit(:id)
  end
end
