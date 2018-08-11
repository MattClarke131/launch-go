FactoryBot.define do
  factory :game do
    sequence(:size) { [9,13,19].sample }
    after :create do |game|
      FactoryBot.create_list(:board_state, 5, game: game)
    end
  end
end
