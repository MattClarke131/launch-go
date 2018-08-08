class Api::V1::ChallengesController < ApplicationController
  def index
    render json: Challenge.all 
  end
end
