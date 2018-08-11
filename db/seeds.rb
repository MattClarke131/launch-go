User.create!(
  email: "1@1",
  password: "111111",
  is_admin: true
)
Challenge.create!(
  user_id: 1
)

FactoryBot.create_list(:challenge, 20)

FactoryBot.create_list(:game, 20, size: 9)

Move.create!(
  move_number: 1,
  color: 'black',
  is_pass: false,
  x: 4,
  y: 4,
  game: Game.last
)
Move.create!(
  move_number: 2,
  color: 'white',
  is_pass: false,
  x: 4,
  y: 5,
  game: Game.last
)
Move.create!(
  move_number: 3,
  color: 'black',
  is_pass: false,
  x: 5,
  y: 4,
  game: Game.last
)
Move.create!(
  move_number: 4,
  color: 'white',
  is_pass: false,
  x: 3,
  y: 4,
  game: Game.last
)
