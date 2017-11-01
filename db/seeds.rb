# In order to have a proper development environment,
# please use rails db:reset from the terminal
# instead of directly calling rails db:seed
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'utf8.csv'))
csv = CSV.parse(csv_text, :headers => true)
games = 0
csv.each do |row|
  Game.create!({
    name: row['names'],
    max_players: row['max_players'],
    complexity: row['weight'],
    game_length: row['avg_time']
    })
  games += 1
  puts "#{games} Games Created"
end

ADMINS = ['admin','trevor','rose','james','carla']


if Achievement.all.blank?
   Achievement.create(name: "Welcome to the Party", description: "Attend your first event")
   Achievement.create(name: "Socialite", description: "Attend your fifth event")
   Achievement.create(name: "Junior Host", description: "Host your first event")
   Achievement.create(name: "Accomplished Host", description: "Host your five event")
   Achievement.create(name: "One small step..", description: "Reach level 2")
   Achievement.create(name: "Lord of the Board", description: "Reach level 5")
   Achievement.create(name: "Forever Alone", description: "It's going to be ok..")
   puts "achievements seeded"
 end

ADMINS.each { |name| User.create(username:"#{name}",email:"#{name}@admin.com",password:'123123') } if User.first == nil

tmp = Game.find(rand(5000))
Event.create!(
  {
    game: Game.find(tmp),
    description: "I just did rand(5000) and this is the game that came up. You're gonna play and you're gonna like it.",
    datetime: Time.now,
    title: "Let's play #{tmp.name}",
    address: 'Otsuka Station, Tokyo',
    host: User.first.host
  }
)
#carla,rose,trevor join admin event - 4/4
[5,3,2].each { |id| Event.first.add_user(User.find(id)) }

tmp = Game.find(rand(5000))
Event.create!(
  {
    description: "I just did rand(5000) and this is the game that came up. You're gonna play and you're gonna like it.",
    datetime: Time.now - 100000,
    title: "Let's play #{tmp.name}",
    address: 'Long Beach, CA',
    game: tmp,
    host: User.find(2).host
  }
)

Event.create!(
  {
    description: "Cards Against Humanity is a game for good people",
    datetime: Time.now + 100000,
    title: "Post pitch party!! LeWagon ONLY",
    address: '2 Chome-2 Dogenzaka, Shibuya, Tokyo 150-0043',
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

tmp = Game.find(rand(5000))
Event.create!(
  {
    description: "I just did rand(5000) and this is the game that came up. You're gonna play and you're gonna like it.",
    datetime: Time.now + 10000,
    title: "Let's play #{tmp.name}",
    address: '21-2, Kabukicho 1-chome, Shinjuku-ku, Tokyo',
    game: tmp,
    host: User.find(4).host
  }
)

tmp = Game.find(rand(5000))
Event.create!(
  {
    description: "I just did rand(5000) and this is the game that came up. You're gonna play and you're gonna like it.",
    datetime: Time.now,
    title: "Let's play #{tmp.name}",
    address: '14-14歌舞伎町',
    game: tmp,
    host: User.first.host
  }
)

tmp = Game.find(rand(5000))
Event.create!(
  {
    description: "I just did rand(5000) and this is the game that came up. You're gonna play and you're gonna like it.",
    datetime: Time.now + 1000000,
    title: "Let's play #{tmp.name}",
    address: '2-11-3目黒区目黒',
    game: tmp,
    host: User.find(5).host
  }
)



#rose joins carla's event (rose joins everything) - 2/8
Event.last.add_user(User.find(3))
