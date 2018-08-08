FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:rank) do
      range = (-30..-1).to_a.concat((1..9).to_a).sample
    end
  end
end
