# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts ""
puts "\e[1;35mSeeding...\e[0m"

# Setup
print "> \e[33mInitialising basics..."
sport = Sport.find_or_create_by!(name: "Australian Football")
league = League.find_or_create_by!(name: "Seniors League", sport: sport)
division = Division.find_or_create_by!(name: "Division 1", league: league)
season = Season.find_or_create_by!(name: "Autumn/Winter 2026", start_date: Date.new(2026, 4, 18), status: "Ongoing", division: division)
puts ".. \e[32mDone!\e[0m"

# User accounts
print "> \e[33mCreating users..."

super_admin = User.find_or_create_by!(email: "super@example.com") do |user|
  user.password = "password1"
  user.password_confirmation = "password1"
  user.first_name = "Sue"
  user.last_name = "Pradmin"
  user.super_admin = true
end

league_admin = User.find_or_create_by!(email: "league@example.com") do |user|
  user.password = "password1"
  user.password_confirmation = "password1"
  user.first_name = "Leigh"
  user.last_name = "Goodman"
end

team_admin = User.find_or_create_by!(email: "team@example.com") do |user|
  user.password = "password1"
  user.password_confirmation = "password1"
  user.first_name = "Tea"
  user.last_name = "Madman"
end

basic = User.find_or_create_by!(email: "basic@example.com") do |user|
  user.password = "password1"
  user.password_confirmation = "password1"
  user.first_name = "Basik"
  user.last_name = "Yuser"
end

puts "........ \e[32mDone!\e[0m"


# Venues
print "> \e[33mCreating venues..."

venue_details = [
  { name: "Optus Stadium", lat: -31.951105, lng: 115.889089, address: "Crane Place, Burswood, WA, 6100" },
  { name: "Elizabeth Quay", lat: -31.957532, lng: 115.856903, address: "Geoffrey Bolton Way, Perth, WA, 6000" },
  { name: "Macca's Girrawheen", lat: -31.835447, lng: 115.830636, address: "87 Templeton Crescent, Girrawheen, WA, 6064" },
  { name: "ECU Sports and Fitness Centre", lat: -31.754216, lng: 115.773416, address: "Building 22 / 270, Joondalup Drive, Joondalup, WA, 6027" },
  { name: "Fremantle Prison", lat: -32.055088, lng: 115.752712, address: "Fairbairn Street, Fremantle, WA, 6160" },
  { name: "Hillarys Boat Harbour", lat: -31.824008, lng: 115.736160, address: "Northside Drive, Hillarys, WA, 6025" }
] 

venues = venue_details.map do |v|
    Venue.find_or_create_by!(
    venue_name: v[:name],
    lat: v[:lat],
    lng: v[:lng],
    address: v[:address]
  )
end
puts "....... \e[32mDone!\e[0m"


# Teams and TeamSeasons
print "> \e[33mCreating teams..."

team_keys = {
  simpsons: "The Simpsons",
  turtles: "Ninja Turtles",
  rangers: "Power Rangers",
  z_fighters: "Z Fighters",
  earthrealm: "Earthrealm Warriors",
  pokemon: "Pokemon"
}


teams_hash = {}
team_seasons_hash = {}

team_keys.each do |key, name|
  team = Team.find_or_create_by!(name: name)
  team_season = TeamSeason.find_or_create_by!(team: team, season: season)

  teams_hash[key] = team
  team_seasons_hash[key] = team_season
end

puts "........ \e[32mDone!\e[0m"


# Rounds
print "> \e[33mCreating rounds..."

rounds = (1..10).map do |i|
  Round.find_or_create_by!(season: season, number: i)
end

puts "....... \e[32mDone!\e[0m"


# Matches
# Double round-robin. Manually, because i'm not smart and there's too much seeding to do, holy moly.
print "> \e[33mCreating matches..."

match1 = Match.find_or_create_by!(round: rounds[0], home_team: teams_hash[:simpsons], away_team: teams_hash[:pokemon], venue: venues[0], scheduled_at: season.start_date + 0.days + 9.hours, status: "Concluded")
match2 = Match.find_or_create_by!(round: rounds[0], home_team: teams_hash[:turtles], away_team: teams_hash[:earthrealm], venue: venues[1], scheduled_at: season.start_date + 0.days + 12.hours, status: "Concluded")
match3 = Match.find_or_create_by!(round: rounds[0], home_team: teams_hash[:rangers], away_team: teams_hash[:z_fighters], venue: venues[2], scheduled_at: season.start_date + 1.days + 16.hours, status: "Concluded")

match4 = Match.find_or_create_by!(round: rounds[1], home_team: teams_hash[:earthrealm], away_team: teams_hash[:simpsons], venue: venues[4], scheduled_at: season.start_date + 7.days + 13.hours, status: "Concluded")
match5 = Match.find_or_create_by!(round: rounds[1], home_team: teams_hash[:z_fighters], away_team: teams_hash[:pokemon], venue: venues[3], scheduled_at: season.start_date + 8.days + 10.hours, status: "Concluded")
match6 = Match.find_or_create_by!(round: rounds[1], home_team: teams_hash[:rangers], away_team: teams_hash[:turtles], venue: venues[2], scheduled_at: season.start_date + 8.days + 11.hours, status: "Concluded")

match7 = Match.find_or_create_by!(round: rounds[2], home_team: teams_hash[:simpsons], away_team: teams_hash[:z_fighters], venue: venues[0], scheduled_at: season.start_date + 14.days + 10.hours, status: "Concluded")
match8 = Match.find_or_create_by!(round: rounds[2], home_team: teams_hash[:earthrealm], away_team: teams_hash[:rangers], venue: venues[4], scheduled_at: season.start_date + 15.days + 12.hours, status: "Concluded")
match9 = Match.find_or_create_by!(round: rounds[2], home_team: teams_hash[:pokemon], away_team: teams_hash[:turtles], venue: venues[5], scheduled_at: season.start_date + 15.days + 18.hours, status: "Concluded")

match10 = Match.find_or_create_by!(round: rounds[3], home_team: teams_hash[:rangers], away_team: teams_hash[:simpsons], venue: venues[2], scheduled_at: season.start_date + 21.days + 11.hours, status: "Concluded")
match11 = Match.find_or_create_by!(round: rounds[3], home_team: teams_hash[:turtles], away_team: teams_hash[:z_fighters], venue: venues[1], scheduled_at: season.start_date + 22.days + 13.hours, status: "Concluded")
match12 = Match.find_or_create_by!(round: rounds[3], home_team: teams_hash[:pokemon], away_team: teams_hash[:earthrealm], venue: venues[5], scheduled_at: season.start_date + 21.days + 12.hours, status: "Concluded")

match13 = Match.find_or_create_by!(round: rounds[4], home_team: teams_hash[:simpsons], away_team: teams_hash[:turtles], venue: venues[0], scheduled_at: season.start_date + 28.days + 8.hours, status: "Concluded")
match14 = Match.find_or_create_by!(round: rounds[4], home_team: teams_hash[:rangers], away_team: teams_hash[:pokemon], venue: venues[2], scheduled_at: season.start_date + 28.days + 10.hours, status: "Concluded")
match15 = Match.find_or_create_by!(round: rounds[4], home_team: teams_hash[:z_fighters], away_team: teams_hash[:earthrealm], venue: venues[3], scheduled_at: season.start_date + 28.days + 12.hours, status: "Concluded")

match16 = Match.find_or_create_by!(round: rounds[5], home_team: teams_hash[:pokemon], away_team: teams_hash[:simpsons], venue: venues[5], scheduled_at: season.start_date + 35.days + 9.hours, status: "Concluded")
match17 = Match.find_or_create_by!(round: rounds[5], home_team: teams_hash[:earthrealm], away_team: teams_hash[:turtles], venue: venues[4], scheduled_at: season.start_date + 35.days + 12.hours, status: "Concluded")
match18 = Match.find_or_create_by!(round: rounds[5], home_team: teams_hash[:z_fighters], away_team: teams_hash[:rangers], venue: venues[3], scheduled_at: season.start_date + 36.days + 14.hours, status: "Concluded")

match19 = Match.find_or_create_by!(round: rounds[6], home_team: teams_hash[:simpsons], away_team: teams_hash[:earthrealm], venue: venues[0], scheduled_at: season.start_date + 42.days + 9.hours, status: "Scheduled")
match20 = Match.find_or_create_by!(round: rounds[6], home_team: teams_hash[:pokemon], away_team: teams_hash[:z_fighters], venue: venues[5], scheduled_at: season.start_date + 42.days + 12.hours, status: "Scheduled")
match21 = Match.find_or_create_by!(round: rounds[6], home_team: teams_hash[:turtles], away_team: teams_hash[:rangers], venue: venues[1], scheduled_at: season.start_date + 43.days + 10.hours, status: "Scheduled")

match22 = Match.find_or_create_by!(round: rounds[7], home_team: teams_hash[:z_fighters], away_team: teams_hash[:simpsons], venue: venues[3], scheduled_at: season.start_date + 49.days + 8.hours, status: "Scheduled")
match23 = Match.find_or_create_by!(round: rounds[7], home_team: teams_hash[:rangers], away_team: teams_hash[:earthrealm], venue: venues[2], scheduled_at: season.start_date + 50.days + 13.hours, status: "Scheduled")
match24 = Match.find_or_create_by!(round: rounds[7], home_team: teams_hash[:turtles], away_team: teams_hash[:pokemon], venue: venues[1], scheduled_at: season.start_date + 50.days + 10.hours, status: "Scheduled")

match25 = Match.find_or_create_by!(round: rounds[8], home_team: teams_hash[:simpsons], away_team: teams_hash[:rangers], venue: venues[0], scheduled_at: season.start_date + 56.days + 15.hours, status: "Scheduled")
match26 = Match.find_or_create_by!(round: rounds[8], home_team: teams_hash[:z_fighters], away_team: teams_hash[:turtles], venue: venues[3], scheduled_at: season.start_date + 56.days + 11.hours, status: "Scheduled")
match27 = Match.find_or_create_by!(round: rounds[8], home_team: teams_hash[:earthrealm], away_team: teams_hash[:pokemon], venue: venues[4], scheduled_at: season.start_date + 57.days + 12.hours, status: "Scheduled")

match28 = Match.find_or_create_by!(round: rounds[9], home_team: teams_hash[:turtles], away_team: teams_hash[:simpsons], venue: venues[1], scheduled_at: season.start_date + 63.days + 9.hours, status: "Scheduled")
match29 = Match.find_or_create_by!(round: rounds[9], home_team: teams_hash[:pokemon], away_team: teams_hash[:rangers], venue: venues[5], scheduled_at: season.start_date + 63.days + 11.hours, status: "Scheduled")
match30 = Match.find_or_create_by!(round: rounds[9], home_team: teams_hash[:earthrealm], away_team: teams_hash[:z_fighters], venue: venues[4], scheduled_at: season.start_date + 64.days + 12.hours, status: "Scheduled")

puts "...... \e[32mDone!\e[0m"


# Match Results
# Randomly generating scores for only the Concluded games. 
print "> \e[33mCreating match results..."

Match.where(status: "Concluded").find_each do |match|
  g1 = rand(6..14)
  g2 = rand(2..12)
  b1 = rand(5..15)
  b2 = rand(12..18)

  MatchResult.find_or_create_by!(match: match) do |result|
    result.home_goals = g1
    result.home_behinds = b1
    result.away_goals = g2
    result.away_behinds = b2
  end
end

puts " \e[32mDone!\e[0m"


# PLayers
print "> \e[33mCreating players..."

player_data = {
  simpsons: [
    ["Homer", "Simpson", Date.new(1960, 1, 1), 1],
    ["Marge", "Simpson", Date.new(1965, 2, 3), 2],
    ["Bart", "Simpson", Date.new(1985, 4, 1), 3],
    ["Lisa", "Simpson", Date.new(1987, 6, 6), 4],
    ["Maggie", "Simpson", Date.new(1995, 10, 12), 5]
  ],

  turtles: [
    ["Mikey", "Turtle", Date.new(1960, 1, 1), 6],
    ["Raph", "Turtle", Date.new(1965, 2, 3), 7],
    ["Donny", "Turtle", Date.new(1985, 4, 1), 8],
    ["Leo", "Turtle", Date.new(1987, 6, 6), 9],
    ["April", "O'Neil", Date.new(1995, 10, 12), 10]
  ],

  rangers: [
    ["Red", "Ranger", Date.new(1970, 1, 1), 11],
    ["Blue", "Ranger", Date.new(1970, 2, 3), 12],
    ["Pink", "Ranger", Date.new(1970, 4, 1), 13],
    ["Black", "Ranger", Date.new(1970, 6, 6), 14],
    ["Yellow", "Ranger", Date.new(1970, 10, 12), 15]
  ],

  z_fighters: [
    ["Goku", nil, Date.new(1970, 1, 1), 16],
    ["Vegeta", nil, Date.new(1968, 2, 3), 17],
    ["Gohan", nil, Date.new(1995, 4, 1), 18],
    ["Trunks", nil, Date.new(1990, 6, 6), 19],
    ["Piccolo", nil, Date.new(1901, 10, 12), 20]
  ],

  earthrealm: [
    ["Liu", "Kang", Date.new(1989, 1, 1), 21],
    ["Johnny", "Cage", Date.new(1982, 2, 3), 22],
    ["Kung", "Lao", Date.new(1987, 4, 1), 23],
    ["Sonya", "Blade", Date.new(1999, 6, 6), 24],
    ["Jax", "Briggs", Date.new(1975, 10, 12), 25]
  ],

  pokemon: [
    ["Pikachu", nil, Date.new(2020, 1, 1), 25],
    ["Bulbasaur", nil, Date.new(2014, 2, 3), 1],
    ["Charmander", nil, Date.new(2022, 4, 1), 4],
    ["Squirtle", nil, Date.new(2019, 6, 6), 7],
    ["Mewtwo", nil, Date.new(2005, 10, 12), 151]
  ]
}

players = {}

player_data.each do |team_key, list|
  players[team_key] = []

  list.each do |first_name, last_name, dob, jersey_number|
    player = Player.find_or_create_by!(
      first_name: first_name,
      last_name: last_name,
      date_of_birth: dob
    )

    PlayerRegistration.find_or_create_by!(
      player: player,
      team_season: team_seasons_hash[team_key],
      jersey_number: jersey_number
    )

    players[team_key] << player
  end
end

puts "...... \e[32mDone!\e[0m"


# User Roles
print "> \e[33mCreating user roles..."

UserRole.find_or_create_by!(
    user: league_admin,
    role: "league_admin",
    resource: league
  )

UserRole.find_or_create_by!(
    user: team_admin,
    role: "team_admin",
    resource: teams_hash[:turtles]
  )
puts "... \e[32mDone!\e[0m"


puts ""
puts "\e[1;35mSeeding complete.\e[0m"
puts "-----------------------------"
puts "       Sports:  \e[32m#{Sport.count}\e[0m"
puts "Organisations:  \e[32m#{Organisation.count}\e[0m"
puts "      Leagues:  \e[32m#{League.count}\e[0m"
puts "    Divisions:  \e[32m#{Division.count}\e[0m"
puts "      Seasons:  \e[32m#{Season.count}\e[0m"
puts "       Rounds: \e[32m#{Round.count}\e[0m"
puts "        Teams:  \e[32m#{Team.count}\e[0m"
puts " Team seasons:  \e[32m#{TeamSeason.count}\e[0m"
puts "      Players: \e[32m#{Player.count}\e[0m"
puts "Registrations: \e[32m#{PlayerRegistration.count}\e[0m"
puts "      Matches: \e[32m#{Match.count}\e[0m"
puts "Match results: \e[32m#{MatchResult.count}\e[0m"
puts "-----------------------------"
puts""
puts "\e[1;35mLogin accounts:\e[0m"
puts "  Super Admin:  \e[36m super@example.com\e[0m"
puts " League Admin:  \e[36m league@example.com\e[0m"
puts "   Team Admin:  \e[36m team@example.com\e[0m"
puts "   Basic User:  \e[36m basic@example.com\e[0m"
puts ""
puts "All Passwords:  \e[33mpassword1\e[0m"
