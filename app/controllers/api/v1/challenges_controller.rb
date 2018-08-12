class Api::V1::ChallengesController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @challenges = Challenge.all
    render json: @challenges, each_serializer: ChallengeSerializer
  end

  def create
  end
end
