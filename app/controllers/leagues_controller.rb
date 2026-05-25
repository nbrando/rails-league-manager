class LeaguesController < ApplicationController
  before_action :set_league, only: [ :show, :fixtures]


  def index
    @leagues = League.all
  end


  def show
    @divisions = @league.divisions.includes(seasons: { rounds: { matches: [:home_team, :away_team, :match_result] } })
  end

  def fixtures
    @seasons = @league.divisions.flat_map(&:seasons)
    @season = @seasons.first

    @matches = Match.joins(:round)
                    .where(rounds: { season_id: @season.id })
                    .includes(:match_result, :home_team, :away_team, :venue, round: {})
                    .order("rounds.number ASC, matches.scheduled_at ASC")
                    .group_by(&:round)
  end

  def ladder
    @league = League.find(params[:id])
    @divisions = @league.divisions.includes(seasons: { team_seasons: { team: {} }, rounds: { matches: [:match_result, :home_team, :away_team] } })
  end


  private
  
  def set_league
    @league = League.find(params[:id])
  end
end
