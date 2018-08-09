FactoryBot.define do
  factory :game do
    sequence(:size) { [9,13,19].sample }
  end
end
