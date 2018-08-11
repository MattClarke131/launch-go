class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :rank, numericality: {
    only_integer: true,
    greater_than_or_equal_to: -30,
    less_than_or_equal_to: 9,
    other_than: 0
  }

  has_one :challenge
  has_many :pairings
  has_many :games, through: :pairings
end
