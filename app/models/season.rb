class Season < ApplicationRecord
  belongs_to :division
  has_many :rounds, dependent: :destroy
  has_many :team_seasons

  validates :name, :start_date, :status, presence: true
end
