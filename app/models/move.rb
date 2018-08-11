class Move < ApplicationRecord
  validates :move_number,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0
    }
  validates :color, :move_number, :is_pass,
    null: false
  validates :color,
    presence: true,
    inclusion: { in: %w(black white) }
  validates :is_pass,
    inclusion: { in: [true, false] }

  belongs_to :game
end
