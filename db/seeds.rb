User.create!(
  email: "2@2",
  password: "222222",
  is_admin: true
)

FactoryBot.create_list(:challenge, 20)

FactoryBot.create_list(:game, 20, size: 9)

User.create!(
  email: "Lee_Sedol@baduk.org",
  password: 222222,
  is_admin: false
)
User.create!(
  email: "Alpha_Go@gmail.com",
  password: 222222,
  is_admin: false
)
