class TeamSeason < ApplicationRecord
  belongs_to :team
  belongs_to :season
  has_many :player_registrations, dependent: :destroy

  def matches
    Match.joins(:round)
       .where(rounds: { season_id: season_id })
       .where("matches.home_team_id = :tid OR matches.away_team_id = :tid", tid: team_id)
  end
end