FactoryBot.define do
  factory :game do
    sequence(:size) { [9,13,19].sample }
    after :create do |game|
      FactoryBot.create_list(:board_state, 5, game: game)
      FactoryBot.create_list(:user, 2)
      FactoryBot.create(:pairing,
        user: User.last(2)[0],
        color: 'black',
        game: game
      )
      FactoryBot.create(:pairing,
        user: User.last(2)[1],
        color: 'white',
        game: game
      )
    end
  end
end
