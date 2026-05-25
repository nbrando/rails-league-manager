class Team < ApplicationRecord
  belongs_to :organisation, optional:true
  has_many :team_seasons, dependent: :destroy
  has_many :user_roles, as: :resource, dependent: :destroy

  validates :name, presence: true
end
