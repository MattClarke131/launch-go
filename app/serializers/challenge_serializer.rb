class ChallengeSerializer < ActiveModel::Serializer
  attributes :max_rank, :min_rank, :user

  has_one :user
end
