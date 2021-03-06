# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171101121431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "achieveable_type"
    t.integer  "achieveable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["achieveable_type", "achieveable_id"], name: "index_achievements_on_achieveable_type_and_achieveable_id", using: :btree
  end

  create_table "avatars", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "gender",     default: 0
    t.integer  "bottom",     default: 0
    t.integer  "top",        default: 0
    t.integer  "hair",       default: 0
    t.integer  "shoes",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_avatars_on_user_id", using: :btree
  end

  create_table "badgelists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "achievement_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["achievement_id"], name: "index_badgelists_on_achievement_id", using: :btree
    t.index ["user_id"], name: "index_badgelists_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "description"
    t.datetime "datetime"
    t.string   "title"
    t.string   "address"
    t.integer  "coins"
    t.integer  "experience"
    t.integer  "game_id"
    t.integer  "host_id"
    t.integer  "win_id"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "citycountry"
    t.index ["game_id"], name: "index_events_on_game_id", using: :btree
    t.index ["host_id"], name: "index_events_on_host_id", using: :btree
    t.index ["win_id"], name: "index_events_on_win_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.integer  "max_players"
    t.string   "name"
    t.float    "complexity"
    t.integer  "game_length"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "hosts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_hosts_on_user_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_players_on_event_id", using: :btree
    t.index ["user_id"], name: "index_players_on_user_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "player_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "vote_id"
    t.boolean  "attended",   default: false
    t.index ["player_id"], name: "index_surveys_on_player_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                       null: false
    t.string   "encrypted_password",     default: "",                       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "achieveable_type"
    t.integer  "achieveable_id"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "username"
    t.float    "level",                  default: 1.0
    t.integer  "coins",                  default: 0
    t.string   "description",            default: "I'm a QuestBoard noob!"
    t.float    "lat"
    t.float    "lng"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.index ["achieveable_type", "achieveable_id"], name: "index_users_on_achieveable_type_and_achieveable_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "avatars", "users"
  add_foreign_key "badgelists", "achievements"
  add_foreign_key "badgelists", "users"
  add_foreign_key "events", "games"
  add_foreign_key "events", "hosts"
  add_foreign_key "events", "users", column: "win_id"
  add_foreign_key "hosts", "users"
  add_foreign_key "players", "events"
  add_foreign_key "players", "users"
  add_foreign_key "surveys", "players"
end
