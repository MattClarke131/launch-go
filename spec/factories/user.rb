FactoryBot.define do
  factory :user do
    usernames = [
      'sente', 'kikashi', 'honte', 'sabaki', 'taisha', 'nadare', 'hane',
      'keima', 'fuseki', 'joseki',
      'sai', 'hikaru', 'kageyama', 'kitani', 'jie', 'changho', 'seigen',
    ]
    sequence(:email) {|n| "#{usernames.sample}#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    sequence(:rank) do
      range = (-30..-1).to_a.concat((1..9).to_a).sample
    end
  end
end
