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
User.create(username:'rose.desu',email:'rose@admin.com',password:"123123")
User.create(username:'carla.desu',email:'carla@admin.com',password:"123123")

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
    host: Host.find(2)
  }
)

Event.create(
  {
    description: "Monopoly is one of the BEST BOARD GAMES EVER!!!!!!",
    datetime: Time.now + 10000,
    title: "CARLA HOSTS GAME",
    address: 'Lewagon Street',
    coins: 10,
    experience: 100,
    game: Game.get_by_name('Monopoly'),
    host: Host.find(5)
  }
)

#5 users/hosts, 3 games, 3 events
#fill admin game to max
Event.first.add_user(User.get_by_username('trevor'))
Event.first.add_user(User.get_by_username('james'))
Event.first.add_user(User.get_by_username('rose'))

Event.last.add_user(User.get_by_username('trevor'))
Event.last.add_user(User.get_by_username('james'))
Event.last.add_user(User.get_by_username('admin'))

User.create(username:'randomguy1',email:'random1@gmail.com',password:'123123')
Event.last.add_user(User.last)
User.create(username:'randomguy2',email:'random2@gmail.com',password:'123123')
Event.last.add_user(User.last)
User.create(username:'randomguy3',email:'random3@gmail.com',password:'123123')
Event.last.add_user(User.last)
User.create(username:'randomguy4',email:'random4@gmail.com',password:'123123')
Event.last.add_user(User.last)
User.create(username:'randomguy5',email:'random5@gmail.com',password:'123123')


Event.create(
  {
    description: "I just wanna play mouse trap with trevor",
    datetime: Time.now + 10000,
    title: "Come play mouse trap with james",
    address: 'Adelaide University',
    coins: 15,
    experience: 120,
    game: Game.first,
    host: Host.find(3)
  }
)


Event.create(
  {
    description: "Mouse trap is pretty popular recently, so I'll host one",
    datetime: Time.now + 10000,
    title: "CARLA HOSTS GAME",
    address: 'Lewagon Street',
    coins: 10,
    experience: 100,
    game: Game.first,
    host: Host.find(5)
  }
)
