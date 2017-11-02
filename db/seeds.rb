# In order to have a proper development environment,
# please use rails db:reset from the terminal
# instead of directly calling rails db:seed
require 'csv'
require 'faker'

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
  if games%250 == 0 puts "#{games} Games Created"
end

ADMINS = ['babyface_joe','trevor','rose','james','carla']


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
User.first.avatar.update(top:1)
{2=>[0,719], 3=>[1,444], 4=>[0,123], 5=>[1,666]}.each { |k,v| User.find(k).avatar.update(gender:v[0], hair:v[1], top:v[1], bottom:v[1], shoes:v[1]) }

tmp = Game.get_by_name('Cowboys: The Way of the Gun')
Event.create!(
  {
    game: Game.find(tmp),
    description: "I've always wanted to play #{tmp.name} for the longest time! But I've never been able to find #{tmp.max_players - 1 == 1 ? 'a friend' : 'some people' } who want to play... Come join! I'll have enough drinks for at least #{tmp.max_players} people!",
    datetime: Time.now + 30,
    title: "Come play Cowboys with me!",
    address: '1 Chome-11-1 Nishishinjuku',
    host: User.first.host
  }
)

#carla,rose,trevor join admin event
[5,3,2].each { |id| Event.first.add_user(User.find(id)) }


Event.create!(
  {
    description: "This is the event for the Lewagon Demo night!! We're playing a really short game just to showcase the functionality of QuestBoard, and the survey system!! Feel free to join this before it ends!",
    datetime: Time.new(2017, 11, 3, 23, 45, 0, "+09:00"),
    title: "Lewagon DEMO DAY!! Cards Against Humanity!",
    address: '2-11-3目黒区目黒',
    game: Game.get_by_name('Cards Against Humanity'),
    host: User.find(5).host
  }
)

#trevor, rose, and james join Carla's event - 4/30
[2,3,4].each { |id| Event.last.add_user(User.find(id)) }


Event.create!(
  {
    description: "I Love Kabukicho. I love boardgames. I love you. Come join for some drinks and good times!",
    datetime: Time.new(2017, 11, 11, 19, 0, 0, "+9:00"),
    title: "Carcassonnes night in Kabukicho.",
    address: '21-2, Kabukicho 1-chome, Shinjuku-ku, Tokyo',
    game: Game.get_by_name('Carcassonnes'),
    host: User.find(4).host
  }
)

tmp = Game.find(rand(5000))
Event.create!(
  {
    description: "I'm hosting an event for landing my first job as a web developer!! I'm now working for a great company, and what better way to celebrate than a boardgame night with QuestBoard ;)",
    datetime: Time.new(2017, 11, 10, 18, 45, 0, "+09:00"),
    title: "#{tmp.name} in Hachioji",
    address: '八王子市郷土資料館 1階第一展示場',
    game: tmp,
    host: User.find(2).host
  }
)

12.times do |i|
  tmp = Game.find(rand(5000))
  SAMPLE_DESC = [
    "I've always wanted to play #{tmp.name} for the longest time! But I've never been able to find #{tmp.max_players - 1 == 1 ? 'a friend' : 'some people' } who want to play... Come join! I'll have enough drinks for at least #{tmp.max_players} people!",
    "#{rand(2) == 1 ? 'My house, my rules.' : "Hello Questers! Please be considerate of the neighbors and I'm sure we'll have a good time."} #{rand(2) == 1 ? 'BYOB.' : 'NO ALCOHOL!' }",
    "#{rand(2) == 1 ? 'hey im new to the site and' : 'im kindda new here n'} i just wanna meet sum ppl who like #{tmp.name} as much as i do... bring friends too if u have some",
    "#{rand(2) == 1 ? "yo how's it goin" : "Hello there, fellow Questers. This web service has been brough to my attention by a close friend of mine, and I'd like to partake in some 'Questing'. Please RSVP to assure entry. Thank you."}",
    "WELCOME #{rand(2) == 1 ? '' : 'TO MY EVENT'}!! #{rand(2) == 1 ? '' : 'The community I live in is gated, just'} type in #{(rand()*1000).to_i}** and it should open... If not just message me and I'll buzz you in."
  ]
  SAMPLE_TITLE = [
    "Calling all #{tmp.name} players",

  ]
  Event.create!(
    {
      description: SAMPLE_DESC.sample,
      datetime: Time.now,
      title: SAMPLE_TITLE.sample,
      address: '14-14歌舞伎町',
      game: tmp,
      host: User.first.host
    }
  )
end

tmp = Game.find(rand(5000))
Event.create!(
  {
    description: "I just did rand(5000) and this is the game that came up. You're gonna play and you're gonna like it.",
    datetime: Time.now + 1000000,
    title: "#{tmp.name.capitalize} FANS JOIN",
    address: '2-11-3目黒区目黒',
    game: tmp,
    host: User.find(5).host
  }
)

