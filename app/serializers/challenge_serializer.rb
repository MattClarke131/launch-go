class ChallengeSerializer < ActiveModel::Serializer
  attributes :id, :max_rank, :min_rank, :user, :current_user

  has_one :user

  def current_user
    User.current_user.nil? ? nil : formated_user
  end

  def formated_user
    {
      email: User.current_user.email,
      rank: User.current_user.rank
    }
  end
end
