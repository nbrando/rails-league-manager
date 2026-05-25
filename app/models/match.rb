class Match < ApplicationRecord
  belongs_to :round
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :venue, optional: true

  has_one :match_result, dependent: :destroy

  validates :status, presence: true

  def home_score
    return nil unless match_result
    (match_result.home_goals * 6) + match_result.home_behinds
  end

  def away_score
    return nil unless match_result
    (match_result.away_goals * 6) + match_result.away_behinds
  end

  def winner_id
    return nil unless home_score && away_score
    return nil if home_score == away_score  # draw
    home_score > away_score ? home_team_id : away_team_id
  end

  def loser_id
    return nil unless home_score && away_score
    return nil if home_score == away_score
    home_score < away_score ? home_team_id : away_team_id
  end
end
