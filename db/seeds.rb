User.create!(
  email: "1@1",
  password: "111111"
)

User.create!(
  email: "2@2",
  password: "222222"
)
Challenge.create!(
  user_id: 1
)

Challenge.create!(
  user_id: 2
)
