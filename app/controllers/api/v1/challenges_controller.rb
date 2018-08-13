class Api::V1::ChallengesController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @challenges = Challenge.all
    render json: @challenges, each_serializer: ChallengeSerializer
  end

  def create
    user = User.find_by email: challenge_params[:userEmail]
    challenge = Challenge.new(
      user: user,
      min_rank: challenge_params[:minRank],
      max_rank: challenge_params[:maxRank]
    )
    if challenge.save
      challenge = {
        min_rank: challenge.min_rank,
        max_rank: challenge.max_rank,
        user: {
          email: challenge.user.email,
          rank: challenge.user.rank
        }
      }
      render json: {
        challenge: challenge, errors: []
      }
    else
      render json: {
        challenge: {},
        errors: chalenge.errors.full_messages
      }
    end

  end

  def challenge_params
    params.require(:challenge).permit(:minRank, :maxRank, :userEmail)
  end
end
