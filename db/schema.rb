# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_16_102857) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "divisions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "league_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_divisions_on_league_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "sport_id", null: false
    t.datetime "updated_at", null: false
    t.index ["sport_id"], name: "index_leagues_on_sport_id"
  end

  create_table "match_results", force: :cascade do |t|
    t.integer "away_behinds"
    t.integer "away_goals"
    t.datetime "created_at", null: false
    t.integer "home_behinds"
    t.integer "home_goals"
    t.bigint "match_id", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_results_on_match_id", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "away_team_id", null: false
    t.datetime "created_at", null: false
    t.bigint "home_team_id", null: false
    t.bigint "round_id", null: false
    t.datetime "scheduled_at"
    t.string "status"
    t.datetime "updated_at", null: false
    t.bigint "venue_id", null: false
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["round_id"], name: "index_matches_on_round_id"
    t.index ["venue_id"], name: "index_matches_on_venue_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "org_name"
    t.datetime "updated_at", null: false
  end

  create_table "player_registrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "jersey_number"
    t.date "joined_on"
    t.date "left_on"
    t.bigint "player_id", null: false
    t.bigint "team_season_id", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id", "team_season_id"], name: "index_player_registrations_on_player_id_and_team_season_id", unique: true
    t.index ["player_id"], name: "index_player_registrations_on_player_id"
    t.index ["team_season_id"], name: "index_player_registrations_on_team_season_id"
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date_of_birth"
    t.string "first_name", null: false
    t.string "last_name"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_date"
    t.integer "number", null: false
    t.bigint "season_id", null: false
    t.date "start_date"
    t.datetime "updated_at", null: false
    t.index ["season_id", "number"], name: "index_rounds_on_season_id_and_number", unique: true
    t.index ["season_id"], name: "index_rounds_on_season_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "division_id", null: false
    t.date "end_date"
    t.string "name"
    t.date "start_date"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_seasons_on_division_id"
  end

  create_table "sports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "team_seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "season_id", null: false
    t.bigint "team_id", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_team_seasons_on_season_id"
    t.index ["team_id", "season_id"], name: "index_team_seasons_on_team_id_and_season_id", unique: true
    t.index ["team_id"], name: "index_team_seasons_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "organisation_id"
    t.datetime "updated_at", null: false
    t.index ["organisation_id"], name: "index_teams_on_organisation_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "resource_id"
    t.string "resource_type"
    t.string "role"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "role", "resource_type", "resource_id"], name: "idx_on_user_id_role_resource_type_resource_id_c2996a4e0b", unique: true
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name"
    t.string "password_digest", null: false
    t.boolean "super_admin", default: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.decimal "lat"
    t.decimal "lng"
    t.datetime "updated_at", null: false
    t.string "venue_name", null: false
  end

  add_foreign_key "divisions", "leagues"
  add_foreign_key "leagues", "sports"
  add_foreign_key "match_results", "matches"
  add_foreign_key "matches", "rounds"
  add_foreign_key "matches", "teams", column: "away_team_id"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "matches", "venues"
  add_foreign_key "player_registrations", "players"
  add_foreign_key "player_registrations", "team_seasons"
  add_foreign_key "players", "users"
  add_foreign_key "rounds", "seasons"
  add_foreign_key "seasons", "divisions"
  add_foreign_key "team_seasons", "seasons"
  add_foreign_key "team_seasons", "teams"
  add_foreign_key "teams", "organisations"
  add_foreign_key "user_roles", "users"
end
