# In order to have a proper development environment,
# please use rails db:reset from the terminal
# instead of directly calling rails db:seed
# TODO: Still need Game model seeder

ADMINS = ['admin','trevor','rose','james','carla']
Game.create!(max_players:4, name:'Mouse Trap', complexity:0.6, game_length:5)
Game.create!(max_players:2, name:'Operation', complexity:9.6, game_length:180)
Game.create!(max_players:8, name:'Monopoly', complexity:5.6, game_length:60)

ADMINS.each do |name|
  tmp = User.new(email:"#{name}@admin.com",password:'123123')
  tmp.username = "#{name}"
  tmp.save
end

Event.create!(
  {
    description: "Mouse trap has such a low complexity because nobody ever really played it, they just set up the traps and watched them",
    datetime: Time.now + 10,
    title: "ADMIN HOSTS GAME",
    address: 'Shibuya, Tokyo',
    coins: 10,
    experience: 100,
    game: Game.first,
    host: User.first.host
  }
)

Event.create!(
  {
    description: "This game will not be fun, operation ruins friendships. BYOB.",
    datetime: Time.now + 10000,
    title: "TREVOR HOSTS GAME",
    address: 'Long Beach, CA',
    coins: 10,
    experience: 100,
    game: Game.get_by_name('Operation'),
    host: User.find(2).host
  }
)

Event.create!(
  {
    description: "Monopoly is one of the BEST BOARD GAMES EVER!!!!!!",
    datetime: Time.now + 10000,
    title: "CARLA HOSTS GAME",
    address: 'Shibuya, Tokyo',
    coins: 10,
    experience: 100,
    game: Game.get_by_name('Monopoly'),
    host: User.find(5).host
  }
)

#trevor, rose, and admin join Carla's event - 4/8
[2,3,1].each { |id| Event.last.add_user(User.find(id)) }

#carla,rose,trevor join admin event - 4/4
[5,3,2].each { |id| Event.first.add_user(User.find(id)) }

#random users sign up + join carla's event - 8/8 (will disallow entry after 8/8)
(1..8).each do |i|
  tmp = User.new(email:"random#{i}@gmail.com",password:"123123")
  tmp.username = "Rando#{i}"
  tmp.save
  Event.last.add_user(tmp)
end
Event.create!(
  {
    description: "I just wanna play mouse trap with trevor",
    datetime: Time.now + 10000,
    title: "Come play mouse trap with james",
    address: 'Adelaide University',
    coins: 15,
    experience: 120,
    game: Game.first,
    host: User.find(4).host
  }
)


Event.create!(
  {
    description: "Mouse trap is pretty popular recently, so I'll host one",
    datetime: Time.now + 10000,
    title: "CARLA HOSTS GAME",
    address: 'Impact Hub Tokyo',
    coins: 10,
    experience: 100,
    game: Game.first,
    host: User.find(5).host
  }
)

#rose joins carla's event (rose joins everything) - 2/8
Event.last.add_user(User.find(3))
