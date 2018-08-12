FactoryBot.define do
  factory :pairing do
    game
    user
    sequence(:color) { |n| n%2 === 0 ? 'black' : 'white'}
  end
end
