# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email:'admin@admin.com',password:"123123")
User.create(email:'trevor@admin.com',password:"123123")

Game.create(max_players:8, name:'Monopoly', complexity:5.6, game_length:60)
Game.create(max_players:4, name:'Operation', complexity:9.6, game_length:180)
Game.create(max_players:4, name:'Mouse Trap', complexity:0.6, game_length:5)
