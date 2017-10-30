# In order to have a proper development environment,
# please use rails db:reset from the terminal
# instead of directly calling rails db:seed
# TODO: Still need Game model seeder

ADMINS = ['admin','trevor','rose','james','carla']


if Achievement.all.blank?
   Achievement.create(name: "Welcome to the Party", description: "Attend your first event")
   Achievement.create(name: "Socialite", description: "Attend your fifth event")
   Achievement.create(name: "Junior Host", description: "Host your first event")
   Achievement.create(name: "Accomplished Host", description: "Host your five event")
   Achievement.create(name: "One small step..", description: "Reach level 2")
   Achievement.create(name: "Lord of the Board", description: "Reach level 5")
 end



if Game.all.blank?
  Game.create!(max_players:4, name:'Mouse Trap', complexity:0.6, game_length:5)
  Game.create!(max_players:2, name:'Operation', complexity:9.6, game_length:180)
  Game.create!(max_players:8, name:'Monopoly', complexity:5.6, game_length:60)
  Game.create!(max_players:10, name:'Cards Against Humanity', complexity: 0.1, game_length:35)
  Game.create!(max_players:4, name:'The Settlers of Catan', complexity:8.0, game_length:240)
end

ADMINS.each { |name| User.create(username:"#{name}",email:"#{name}@admin.com",password:'123123') } if User.first == nil

Event.create!(
  {
    description: "Mouse trap has such a low complexity because nobody ever really played it, they just set up the traps and watched them",
    datetime: Time.now,
    title: "Mouse Trap at my house!!!",
    address: 'Shibuya, Tokyo',
    coins: 10,
    experience: 100,
    game: Game.first,
    host: User.first.host
  }
)
#carla,rose,trevor join admin event - 4/4
[5,3,2].each { |id| Event.first.add_user(User.find(id)) }

Event.create!(
  {
    description: "This game will not be fun, operation ruins friendships. BYOB.",
    datetime: Time.now - 100000,
    title: "Trevor's Burger King Bash",
    address: 'Long Beach, CA',
    coins: 10,
    experience: 100,
    game: Game.get_by_name('Operation'),
    host: User.find(2).host
  }
)

Event.create!(
  {
    description: "Cards Against Humanity is a game for good people",
    datetime: Time.now + 100000,
    title: "Post pitch party!! LeWagon ONLY",
    address: 'Shibuya, Tokyo',
    coins: 10,
    experience: 100,
    game: Game.get_by_name('Cards Against Humanity'),
    host: User.find(5).host
  }
)

#trevor, rose, and admin join Carla's event - 4/8
[2,3,1].each { |id| Event.last.add_user(User.find(id)) }

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
    title: "Come play mouse trap with James",
    address: 'Otsuka Station, Tokyo',
    coins: 15,
    experience: 120,
    game: Game.first,
    host: User.find(4).host
  }
)

Event.create!(
  {
    description: "Mouse trap has an extremely high skill cap due to the many interconnected components",
    datetime: Time.now,
    title: "Mouse Trap on the STREET",
    address: 'Shinjuku, Tokyo',
    coins: 10,
    experience: 100,
    game: Game.first,
    host: User.first.host
  }
)


Event.create!(
  {
    description: "Mouse trap is pretty popular recently, so I'll get in on the action",
    datetime: Time.now + 1000000,
    title: "Game night at Impact Hub",
    address: 'Impact Hub Tokyo',
    coins: 10,
    experience: 100,
    game: Game.first,
    host: User.find(5).host
  }
)

#rose joins carla's event (rose joins everything) - 2/8
Event.last.add_user(User.find(3))
