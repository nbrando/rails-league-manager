class Player < ApplicationRecord
  belongs_to :user, optional: true
  has_many :player_registrations, dependent: :destroy

  validates :first_name, presence: true
end
