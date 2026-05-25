class TeamSeasonsController < ApplicationController
  def index
  end

  def show
  end

  def fixtures
    @team_season = TeamSeason.find(params[:id])
    @team = @team_season.team
    @season = @team_season.season

    @matches = Match.joins(:round)
                    .where(rounds: { season_id: @season.id })
                    .where("home_team_id = :tid OR away_team_id = :tid", tid: @team.id)
                    .includes(:match_result, :home_team, :away_team, :venue, round: {})
                    .order("rounds.number ASC, matches.scheduled_at ASC")
                    .group_by(&:round)

    # Default to current/upcoming round
    @current_round = @matches.keys.find { |r| r.matches.any? { |m| m.status != "Concluded" } } || @matches.keys.last
  end

end
