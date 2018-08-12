class ChallengeSerializer < ActiveModel::Serializer
  attributes :max_rank, :min_rank, :user, :current_user

  has_one :user

  def current_user
    User.current_user.nil? ? nil : User.current_user.email
  end
end
