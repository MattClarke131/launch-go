require 'faker'

User.create!(
  email: "1@1",
  password: "111111",
  is_admin: true
)
Challenge.create!(
  user_id: 1
)

FactoryBot.create_list(:challenge, 20)
