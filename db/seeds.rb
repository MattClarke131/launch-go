User.create!(
  email: "2@2",
  password: "222222",
  is_admin: true
)

FactoryBot.create_list(:challenge, 20)

FactoryBot.create_list(:game, 20, size: 9)
