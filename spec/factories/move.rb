FactoryBot.define do
  factory :move do
    game
    sequence(:move_number) { |n| }
    sequence(:color) { ['black', 'white'].sample }
    sequence(:is_pass) { [true, false].sample }
    x Random.new.rand(1..9)
    y Random.new.rand(1..9)
  end
end
