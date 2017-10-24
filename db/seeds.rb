# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username:'admin',email:'admin@admin.com',password:"123123")
User.create(username:'trevor',email:'trevor@admin.com',password:"123123")
User.create(username:'james',email:'james@admin.com',password:"123123")
User.create(username:'rose',email:'rose@admin.com',password:"123123")
User.create(username:'carla',email:'carla@admin.com',password:"123123")

Game.create(max_players:4, name:'Mouse Trap', complexity:0.6, game_length:5)
Game.create(max_players:2, name:'Operation', complexity:9.6, game_length:180)
Game.create(max_players:8, name:'Monopoly', complexity:5.6, game_length:60)

Event.create(
  {
    description: "Mouse trap has such a low complexity because nobody ever really played it, they just set up the traps and watched them",
    datetime: Time.now + 10000,
    title: "ADMIN HOSTS GAME",
    address: '123 Street',
    coins: 10,
    experience: 100,
    game: Game.first,
    host: Host.first
  }
)

Event.create(
  {
    description: "This game will not be fun, operation ruins friendships. BYOB.",
    datetime: Time.now + 10000,
    title: "TREVOR HOSTS GAME",
    address: '321 Street',
    coins: 10,
    experience: 100,
    game: Game.get_by_name('Operation'),
    host: Host.get_by_username('trevor')
  }
)
#5 users, 3 games, 2 events
#fill admin game to max
Event.first.add_user(User.get_by_username('trevor'))
Event.first.add_user(User.get_by_username('james'))
Event.first.add_user(User.get_by_username('rose'))
