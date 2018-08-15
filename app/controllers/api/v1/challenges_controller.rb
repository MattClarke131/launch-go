class Api::V1::ChallengesController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @challenges
    if user_signed_in?
      @challenges = sort_challenges(Challenge.all)
    else
      @challenges = Challenge.all.order(id: :desc)
    end
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
        id: challenge.id,
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

  def destroy
    challenge = User.find_by(email: user_email_params).challenge

    if challenge.destroy
      render json: { deleted: true }
    else
      render json: { deleted: false }

    end
  end

  private

  def challenge_params
    params.require(:challenge).permit(:minRank, :maxRank, :userEmail)
  end

  def sort_challenges(challenges)
    challenges.sort {|x,y| y.user.id <=> current_user.id}
  end

  def user_email_params
    params.require(:user_email)
  end
end
