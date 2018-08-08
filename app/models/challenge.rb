class Challenge < ApplicationRecord
  validates :min_rank,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: -30,
      other_than: 0,
      less_than_or_equal_to: 9
    }
  validates :max_rank,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: -30,
      other_than: 0,
      less_than_or_equal_to: 9
    }

  belongs_to :user
end
